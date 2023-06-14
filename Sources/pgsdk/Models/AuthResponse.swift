import Foundation

public struct AuthResponse: Codable {
    public let code: Int?
    public let error, msg: String?
    public   let result: AuthResult?

    enum CodingKeys: String, CodingKey {
        case code, error, msg, result
    }
}

public struct AuthResult: Codable {
    public  let gameSign, gameUrl, gameToken: String?
    public  let gameUser: GameUser?

    enum CodingKeys: String, CodingKey {
        case gameSign = "game_sign"
        case gameUrl = "game_url"
        case gameUser = "game_user"
        case gameToken = "game_token"
    }
}

public struct GameUser: Codable {
    public  let nickName: String?
    public  let id, realVerify: Int?
    public  let userName: String?

    enum CodingKeys: String, CodingKey {
        case nickName, id, realVerify, userName
    }
}
