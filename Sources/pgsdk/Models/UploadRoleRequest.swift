import Foundation

public struct UploadRoleRequest: Codable {
     let serverId: String
     let serverName: String
     let roleId: String
     let roleName: String
     let roleType: Int
     let level: String
    public init(serverId: String, serverName: String, roleId: String, roleName: String, roleType: Int, level: String) {
         self.serverId = serverId
         self.serverName = serverName
         self.roleId = roleId
         self.roleName = roleName
         self.roleType = roleType
         self.level = level
     }
}
