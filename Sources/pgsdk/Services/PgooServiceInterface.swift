import Foundation

protocol PgooServiceInterface {
    func login(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void)
    func register(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void)
    func tokenLogin(token: String, completion: @escaping (AuthResponse?, Error?) -> Void)
    func deviceLogin(uuid: String, completion: @escaping (AuthResponse?, Error?) -> Void)
    func thirdLogin(loginId: String, loginType: String, completion: @escaping (AuthResponse?, Error?) -> Void)
    func initGame(appId: String, appSecret: String, completion: @escaping (InitResponse?, Error?) -> Void)
    func realVerify(realName: String, idNo: String, completion: @escaping (BaseResponse?, Error?) -> Void)
    func uploadRole(role: UploadRoleRequest, completion: @escaping (BaseResponse?, Error?) -> Void)
    func getProductList(completion: @escaping (ProductListResponse?, Error?) -> Void)
    func createOrder(order: CreateOrderRequest, completion: @escaping (OrderResponse?, Error?) -> Void)
    func updateGoogleOrder(purchaseToken: Int, completion: @escaping (BaseResponse?, Error?) -> Void)
    func fetchConfig(completion: @escaping (ConfigResponse?, Error?) -> Void)
//    func fetchGameUrl() -> String
    func fetchPayUrl(payType: Int) -> String
}
