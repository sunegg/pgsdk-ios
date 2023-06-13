class PgooApi {
    
    static let baseUrl = PgooConfigs.baseUrl
    static let register = baseUrl + "/login/register"
    static let login = baseUrl + "/login/login"
    static let tokenLogin = baseUrl + "/login/tokenLogin"
    static let deviceLogin = baseUrl + "/login/deviceLogin"
    static let thirdLogin = baseUrl + "/login/thirdLogin"
    static let initGame = baseUrl + "/game/init"
    static let realVerify = baseUrl + "/game/realVerify"
    static let uploadRole = baseUrl + "/game/uploadRole"
    static let getProductList = baseUrl + "/game/getProductList"
    static let createOrder = baseUrl + "/order/createOrder"
    static let pay = baseUrl + "/game/pay"
    static let updateGoogleOrder = baseUrl + "/order/updateGoogleOrder"
    static let config = baseUrl + "/game/config"
    
    private init() {}
}
