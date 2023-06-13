import XCTest
@testable import pgsdk // Replace 'YourProject' with your actual project name

class PgooServiceTests: XCTestCase {

    var service: PgooService!
    
    override func setUp() {
        super.setUp()
        service = PgooService()
        service.headers["game_token"]="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI3MDMiLCJleHAiOjE2ODc5NDc5ODcsImlhdCI6MTY4NTM1NTk4N30.8lcFz3ubCNEr_3-yw82SmN5LXTVgN9IKF2hN9IhLxp8"
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

//    func testLogin() {
//        let expectation = self.expectation(description: "Login")
//
//        service.login(username: "wiiix", password: "111111") { authResponse, error in
//            XCTAssertNotNil(authResponse)
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }

//    func testDeviceLogin() {
//        let expectation = self.expectation(description: "DeviceLogin")
//
//        service.deviceLogin(uuid: "test111") { authResponse, error in
//            XCTAssertNotNil(authResponse)
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }
//
//    func testTokenLogin() {
//        let expectation = self.expectation(description: "TokenLogin")
//
//        service.tokenLogin(token: "1234") { authResponse, error in
//            XCTAssertNotNil(authResponse)
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }
//
//    func testThirdLogin() {
//        let expectation = self.expectation(description: "TokenLogin")
//
//        service.thirdLogin(loginId: "xxxxxx", loginType: "5") { authResponse, error in
//            XCTAssertNotNil(authResponse)
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }
    
//    func testRegister() {
//        let expectation = self.expectation(description: "Register")
//
//        service.register(username: "test", password: "test") { authResponse, error in
//            XCTAssertNotNil(authResponse)
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }

    func testFetchConfig() {
        let expectation = self.expectation(description: "FetchConfig")
        service.fetchConfig { configResponse, error in
            XCTAssertNotNil(configResponse)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testInit() {
        let expectation = self.expectation(description: "InitGame")
        service.initGame(appId: "0233421", appSecret: "876955f7ec1138914187d82cbea4e855") { res, error in
            XCTAssertNotNil(res)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testRealVerify() {
        let expectation = self.expectation(description: "RealVerify")
        service.realVerify(realName: "喜阳阳", idNo: "320999198909092280") { res, error in
            XCTAssertNotNil(res)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testUploadRole() {
        let expectation = self.expectation(description: "UploadRole")
        service.uploadRole(role: UploadRoleRequest(serverId: "125", serverName: "a", roleId: "123", roleName: "b", roleType: 2, level: "10")) { configResponse, error in
            XCTAssertNotNil(configResponse)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetProductList() {
        let expectation = self.expectation(description: "GetProductList")
        service.getProductList(){ res, error in
            XCTAssertNotNil(res)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testCreateOrder() {
        let expectation = self.expectation(description: "CreateOrder")
        service.createOrder(order: CreateOrderRequest(productId: 1, payType: 1, productName: "100元宝", productDesc: "100元宝", price: String(1), serverId: String(5509), serverName: "359区 风月无边", roleId: "6057410703169536", roleName: "蜀蜀兔子哥", attach: "rolename=蜀蜀兔子哥~roleid=6057410703169536~goodid=31000801~uid=26491~sid=5509~cporderid=6057411696791552")){ res, error in
            XCTAssertNotNil(res)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testUpdateGoogleOrder() {
        let expectation = self.expectation(description: "UpdateGoogleOrder")
        service.updateGoogleOrder(purchaseToken: 1) { res, error in
            XCTAssertNotNil(res)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
