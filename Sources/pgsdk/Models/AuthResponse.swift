import Foundation

struct AuthResponse: Codable {
    let code: Int?
    let error, msg: String?
    let result: AuthResult?

    enum CodingKeys: String, CodingKey {
        case code, error, msg, result
    }
}

struct AuthResult: Codable {
    let gameSign, gameUrl, gameToken: String?
    let gameUser: GameUser?

    enum CodingKeys: String, CodingKey {
        case gameSign = "game_sign"
        case gameUrl = "game_url"
        case gameUser = "game_user"
        case gameToken = "game_token"
    }
}

struct GameUser: Codable {
    let nickName: String?
    let id, realVerify: Int?
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case nickName, id, realVerify, userName
    }
}
