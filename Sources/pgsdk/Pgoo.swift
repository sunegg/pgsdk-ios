    import Foundation

    public class Pgoo: PgooServiceInterface {
        
        var state = PgooState()
        
        var realVerify: Int?
        var config: ConfigResult?
        var initResult: InitResult?
        var productList: [ProductListResult]?

        static let shared = Pgoo()

            private init() {
               
            }

        var headers: [String: String] = ["game_id": String(PgooConfigs.gameId), "locale": PgooConfigs.locale]
        var auth: AuthResult?
        var payUrl: String?
        var verify: Bool?
        var orderId: String?

        func post(url: String, body: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
            guard let url = URL(string: url) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            var allHeaders = self.headers
            headers?.forEach { key, value in
                allHeaders[key] = value
            }

            for (key, value) in allHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }

            if let body = body {
                var components = URLComponents()
                components.queryItems = body.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
                request.httpBody = components.query?.data(using: .utf8)
            }

            let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
            task.resume()
        }
        
        func onResponse(data: Data){
            let decoder = JSONDecoder()
            do {
                print(String(decoding: data, as: UTF8.self))
                let res = try decoder.decode( BaseResponse.self, from: data)
                if (res.code != 1 && res.msg != nil){
                print(res.msg!)
                }
            } catch let decodeError {
                print(decodeError)
            }
        }

        func updateToken(_ res: AuthResponse, token: String? = nil) -> Void {
            if let result = res.result {
                auth = result
            }
            let defaults = UserDefaults.standard
            if(token != nil){
                headers["game_token"] = token
                defaults.set(token, forKey:"token" )
            }else if let gameToken = auth?.gameToken {
                headers["game_token"] = gameToken
                defaults.set(gameToken, forKey:"token" )
            }
            if let gameTokenHeader = headers["game_token"], !gameTokenHeader.isEmpty {
                Pgoo.shared.fetchConfig { (res:ConfigResponse?, error) in
                    self.config=res?.result;
                    print(self.config ?? "config为空")
                }
                Pgoo.shared.getProductList { (res:ProductListResponse?, error) in
                    self.productList=res?.result;
                    print("=====productList=====")
                    print(self.productList ?? "productList为空")
                        let productIds = Set( self.productList!.compactMap { $0.iosIapId })
                    print("=====productIds=====")
                    print(productIds)
                        IAPManager.shared.getProducts(productIds: productIds)
                }
            }
        }
        
        func payTest(){
            let productID = "com.temporary.id"
            IAPManager.shared.getProducts(productIds: Set(arrayLiteral: productID))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                IAPManager.shared.buy(id:  productID  )
        }
        }
            
        func pay(price: Int,
                 productName: String,
                 productDesc: String,
                 serverId: String,
                 serverName: String,
                 roleId: String,
                 roleName: String,
                 attach: String,
                 completion: @escaping (Bool) -> Void) {
            guard let product = getProductByPrice(price: price) else {
                print("product_not_found")
                completion(false)
                return
            }
            IAPManager.shared.buy(id:  product.iosIapId! )
        }

        func getProductByPrice(price: Int) -> ProductListResult? {
            return self.productList?.first(where: { Int($0.price ??  0) == price })
        }

        func signOut(){
            let defaults = UserDefaults.standard
            defaults.set(nil, forKey:"token" )
            print("退出登录")
        }
    
        func login(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
            post(url: PgooApi.login, body: ["username": username, "password": password]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let authResponse = try decoder.decode(AuthResponse.self, from: data)
                        self.updateToken(authResponse)
                        completion(authResponse, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }

        func register(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
            post(url: PgooApi.register, body: ["username": username, "password": password,"pgcid":PgooConfigs.pgCid]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let authResponse = try decoder.decode(AuthResponse.self, from: data)
                        self.updateToken(authResponse)
                        completion(authResponse, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func tokenLogin(token: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
            post(url: PgooApi.tokenLogin,headers:["game_token":token]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let authResponse = try decoder.decode(AuthResponse.self, from: data)
                        self.updateToken(authResponse,token: token)
                        completion(authResponse, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func deviceLogin(uuid: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
            post(url: PgooApi.deviceLogin, body: ["uuid": uuid,"pgcid":PgooConfigs.pgCid]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let authResponse = try decoder.decode(AuthResponse.self, from: data)
                        self.updateToken(authResponse)
                        completion(authResponse, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func thirdLogin(loginId: String, loginType: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
            post(url: PgooApi.thirdLogin, body: ["loginId": loginId, "loginType": loginType,"pgcid":PgooConfigs.pgCid]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let authResponse = try decoder.decode(AuthResponse.self, from: data)
                        self.updateToken(authResponse)
                        completion(authResponse, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func initGame(appId: String, appSecret: String, completion: @escaping (InitResponse?, Error?) -> Void) {
            post(url: PgooApi.initGame, body: ["appId": appId, "appSecret": appSecret]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(InitResponse.self, from: data)
                        if(self.auth?.gameUser?.realVerify==0 && res.result?.needRealIos==1){
                            self.state.isShowingRealVerifyView=true;
                        }
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func realVerify(realName: String, idNo: String, completion: @escaping (BaseResponse?, Error?) -> Void) {
            post(url: PgooApi.realVerify, body: ["realName": realName, "idNo": idNo]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(BaseResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func uploadRole(role: UploadRoleRequest, completion: @escaping (BaseResponse?, Error?) -> Void) {
            post(url: PgooApi.uploadRole, body: ["serverId": role.serverId, "serverName": role.serverName, "roleId": role.roleId,"roleName": role.roleName,"roleType":String(role.roleType),"level": role.level]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(BaseResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func getProductList(completion: @escaping (ProductListResponse?, Error?) -> Void) {
            post(url: PgooApi.getProductList, body: ["platform": "ios"]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(ProductListResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func createOrder(order: CreateOrderRequest, completion: @escaping (OrderResponse?, Error?) -> Void) {
            post(url: PgooApi.uploadRole, body: ["productId": String(order.productId), "payType": String(order.payType), "productName": order.productName,"productDesc": order.productDesc,"price": order.productDesc,"serverId": order.serverId,"serverName": order.serverName,"roleId": order.roleId,"roleName": order.roleName,"attach": order.attach]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(OrderResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func updateGoogleOrder(purchaseToken: Int, completion: @escaping (BaseResponse?, Error?) -> Void) {
            post(url: PgooApi.updateGoogleOrder, body: ["orderId": orderId ?? "", "purchaseToken": purchaseToken]) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(BaseResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func fetchConfig(completion: @escaping (ConfigResponse?, Error?) -> Void) {
            post(url: PgooApi.config) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.onResponse(data:data)
                        let res = try decoder.decode(ConfigResponse.self, from: data)
                        completion(res, error)
                    } catch let decodeError {
                        completion(nil, decodeError)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
        
        func fetchPayUrl(payType: Int) -> String {
            let baseAndPay = PgooApi.baseUrl + PgooApi.pay
            let orderPart = "?orderId=" + (orderId ?? "defaultOrderID")
            let payTypePart = "&payType=" + String(payType)
            return baseAndPay + orderPart + payTypePart
        }
    
    }
