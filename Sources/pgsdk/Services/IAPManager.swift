import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = IAPManager()

    var productsRequest: SKProductsRequest?
    var products = [SKProduct]()

    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    func getProducts(productIds: Set<String>) {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productIds)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print("=====请求商品=====")
        print(response.products)
    }
    
    func buy(id: String){
            if let product = self.products.first(where: { $0.productIdentifier == id }) {
                IAPManager.shared.buyProduct(product: product)
            } else {
                print("Product not found")
            }
    }

    func buyProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("购买成功");
                guard let receiptUrl = Bundle.main.appStoreReceiptURL,
                                  FileManager.default.fileExists(atPath: receiptUrl.path) else {
                                return
                            }
                            let receiptData = try? Data(contentsOf: receiptUrl)
                            let receiptString = receiptData?.base64EncodedString(options: [])
                            SKPaymentQueue.default().finishTransaction(transaction)
                Pgoo.shared.updateIosOrder(receipt: receiptString!, payOrderId: transaction.transactionIdentifier!) { (res:BaseResponse?, err) in
                                print(res)
                            }
            case .restored:
                print("恢复购买");
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                print("购买失败");
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
}
