import Foundation
// MARK: - ConfigResponse
public struct ConfigResponse: Codable {
    public  let code: Int?
    public  let error, msg: String?
    public  let result: ConfigResult?
    enum CodingKeys: String, CodingKey {
        case code, error, msg, result
    }
}

// MARK: - ConfigResult
public struct ConfigResult: Codable {
    public  let serviceTel: String?
    public  let googlePay, loginNeed: Int?
    public  let review: Review?
    public  let serviceQq, privacyUrl, serviceWx,serviceLine: String?
    public  let share: Share?
    enum CodingKeys: String, CodingKey {
        case googlePay="google_pay"
        case review
        case share
        case loginNeed="login_need"
        case serviceTel="service_tel"
        case serviceQq = "service_qq"
        case privacyUrl = "privacy_url"
        case serviceWx = "service_wx"
        case serviceLine = "service_line"
    }
}

// MARK: - Review
public struct Review: Codable {
    public let enable, time: Int?
}

// MARK: - Share
public struct Share: Codable {
    public  let text, title, url: String?
}
