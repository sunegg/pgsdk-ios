import Foundation

// MARK: - InitResponse
struct InitResponse: Codable {
    let code: Int?
    let error, msg: String?
    let result: InitResult?
}

// MARK: - InitResult
struct InitResult: Codable {
    let androidIndexUrl, androidLink, appId, appSecret: String?
    let config: String?
    let createTime: String?
    let discount: Double?
    let id: Int?
    let indexUrl, iosLink: String?
    let jumpToApp: Int?
    let name: String?
    let needRealAndroid, needRealIos: Int?
    let package, payUrl, scheme: String?
    let status: Int?
}
