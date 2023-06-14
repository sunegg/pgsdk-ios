import Foundation

public struct UploadRoleRequest: Codable {
    public  let serverId: String
    public  let serverName: String
    public  let roleId: String
    public  let roleName: String
    public  let roleType: Int
    public  let level: String
}
