import Foundation

struct CreateOrderRequest: Codable {
    let productId: Int
    let payType: Int
    let productName: String
    let productDesc: String
    let price: String
    let serverId: String
    let serverName: String
    let roleId: String
    let roleName: String
    let attach: String
}
