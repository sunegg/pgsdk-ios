import Foundation
// MARK: - ConfigResponse
public struct ConfigResponse: Codable {
     let code: Int?
     let error, msg: String?
     let result: ConfigResult?
    enum CodingKeys: String, CodingKey {
        case code, error, msg, result
    }
}

// MARK: - ConfigResult
public struct ConfigResult: Codable {
 let serviceTel: String?
 let googlePay, loginNeed: Int?
 let review: Review?
 let serviceQq, privacyUrl, serviceWx,serviceLine: String?
 let share: Share?
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
     let enable, time: Int?
}

// MARK: - Share
public struct Share: Codable {
      let text, title, url: String?
}
