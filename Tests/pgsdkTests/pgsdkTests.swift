import XCTest
@testable import pgsdk

final class pgsdkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(pgsdk().text, "Hello, World!")
//        print(PgooApi.baseUrl)
//        let urlString = "https://api.github.com/users/octocat/repos"
//        let parameters = ["sort": "updated"]
//        let headers = ["Accept": "application/vnd.github.v3+json"]
//
//        let expectation = self.expectation(description: "Fetch Github repos")
//
//        PgooService().get(url: urlString, queryParameters: parameters, headers: headers) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data {
//                let str = String(data: data, encoding: .utf8)
//                print("Received data:\n\(str ?? "")")
//            }
//            expectation.fulfill()
//        }
        let expectation = self.expectation(description: "login")
        let service = PgooService()
        service.login(username: "wiiix", password: "111111") { (authResponse, error) in
            // Handle the response and error inside this closure
            if let error = error {
                print("Error during login: \(error)")
            } else if let authResponse = authResponse {
                print("Received auth response: \(authResponse)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
