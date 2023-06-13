import Foundation

struct UploadRoleRequest: Codable {
    let serverId: String
    let serverName: String
    let roleId: String
    let roleName: String
    let roleType: Int
    let level: String
}
