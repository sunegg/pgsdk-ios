public struct ProductListResponse: Codable {
      let code: Int?
      let error: String?
      let msg: String?
    public  let result: [ProductListResult]?
}

public struct ProductListResult: Codable {
      let beginCreateTime: JSONNull?
      let createTime: String?
      let endCreateTime: JSONNull?
      let gameId: Int?
      let googleIapId: String?
      let iapId: String?
      let id: Int?
      let iosIapId: String?
      let memo: String?
      let name: String?
      let os: Int?
      let price: Double?
      let status: Int?
      let sub: Int?
      let updateTime: String?
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
