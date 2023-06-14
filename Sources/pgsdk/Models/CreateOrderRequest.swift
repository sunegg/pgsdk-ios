import Foundation

public struct CreateOrderRequest: Codable {
    public let productId: Int
    public let payType: Int
    public let productName: String
    public let productDesc: String
    public let price: String
    public let serverId: String
    public let serverName: String
    public let roleId: String
    public let roleName: String
    public let attach: String
}
