import Foundation

// MARK: - InitResponse
public struct InitResponse: Codable {
    public let code: Int?
    public let error, msg: String?
    public let result: InitResult?
}

// MARK: - InitResult
public struct InitResult: Codable {
    public let androidIndexUrl, androidLink, appId, appSecret: String?
    public let config: String?
    public let createTime: String?
    public let discount: Double?
    public let id: Int?
    public let indexUrl, iosLink: String?
    public let jumpToApp: Int?
    public let name: String?
    public let needRealAndroid, needRealIos: Int?
    public let package, payUrl, scheme: String?
    public let status: Int?
}
