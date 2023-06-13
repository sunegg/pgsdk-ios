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
        // TODO: Handle the products
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
                // TODO: Handle the successful purchase
                print("购买成功");
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // TODO: Handle the restored purchase
                print("恢复购买");
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                // TODO: Handle the failed purchase
                print("购买失败");
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
}
