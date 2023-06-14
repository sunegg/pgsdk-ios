public struct ProductListResponse: Codable {
    public  let code: Int?
    public  let error: String?
    public  let msg: String?
    public  let result: [ProductListResult]?
}

public struct ProductListResult: Codable {
    public  let beginCreateTime: JSONNull?
    public  let createTime: String?
    public  let endCreateTime: JSONNull?
    public  let gameId: Int?
    public  let googleIapId: String?
    public  let iapId: String?
    public  let id: Int?
    public  let iosIapId: String?
    public  let memo: String?
    public  let name: String?
    public  let os: Int?
    public  let price: Double?
    public  let status: Int?
    public  let sub: Int?
    public  let updateTime: String?
}

// For handling null values in JSON
public struct JSONNull: Codable {
    public init() {}
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
