//
// Created by Katarina Dokic
//

import Foundation
import OrderedCollections

extension OrganizationView {
    struct Data {
        let users: [OrganizationUser]

        init(users: [OrganizationUser] = []) {
            self.users = users
        }

        static func fromGetAllUsersResponse(_ getAllUsersResponse: GetAllUsersRequest.NetworkResponse) -> Data {
            let users = getAllUsersResponse.items.map { user in
                OrganizationUser(
                    id: user.id,
                    name: "\(user.firstName) \(user.lastName)",
                    hireDate: DateFormatting.toUserFriendlyDateFormat(user.hireDate),
                    email: user.email,
                    phoneNumber: user.phoneNumber,
                    dateOfBirth: DateFormatting.toUserFriendlyDateFormat(user.dateOfBirth)
                )
            }
            return Data(users: users)
        }
    }

    struct OrganizationUser {
        let id: Int
        let name: String
        let hireDate: String
        let email: String
        let phoneNumber: String
        let dateOfBirth: String
    }

    struct UserFields: Identifiable {
        var id: Int

        let dataFields: OrderedDictionary<String, String>

        init(organizationUser: OrganizationUser) {
            self.id = organizationUser.id
            
            var dataFields: OrderedDictionary<String, String> = [:]
            dataFields["Name:"] = organizationUser.name
            dataFields["Joined from:"] = organizationUser.hireDate
            dataFields["Email:"] = organizationUser.email
            dataFields["Phone number:"] = organizationUser.phoneNumber
            dataFields["Birthday:"] = organizationUser.dateOfBirth
            self.dataFields = dataFields
        }
    }
}
