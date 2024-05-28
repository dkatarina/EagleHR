//
// Created by Katarina Dokic
//

import Foundation
import OrderedCollections

extension MyInfoView {
    struct Data {
        var fields: OrderedDictionary<FieldId, Field> = [:]

        init(fieldIds: Array<FieldId> = FieldId.allCases) {
            fieldIds.forEach { fieldId in
                fields[fieldId] = defaultField(fieldId)
            }
        }

        private func defaultField(_ fieldId: FieldId) -> Field {
            Field(isEditable: FieldId.editableFields.contains(fieldId), value: "")
        }
    }

    struct Field {
        let isEditable: Bool
        var value: String

        init(isEditable: Bool, value: String) {
            self.isEditable = isEditable
            self.value = value
        }
    }

    enum FieldId: String, CaseIterable, Identifiable {
        var id: FieldId {
            return self
        }

        case firstName = "First name:"
        case lastName = "Last name:"
        case dateOfBirth = "Date of birth:"
        case hireDate = "Hire date:"

        case emailAddress = "Email:"
        case address = "Address:"
        case college = "College:"
        case phoneNumber = "Phone number:"

        static let editableFields: Array<FieldId> = [
            .emailAddress,
            .address,
            .college,
            .phoneNumber
        ]
    }
}
