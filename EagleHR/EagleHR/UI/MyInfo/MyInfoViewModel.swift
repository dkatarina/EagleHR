//
// Created by Katarina Dokic
//

import Foundation
import OrderedCollections

extension MyInfoView {
    @Observable
    class ViewModel {
        private let networkManager = NetworkManager.shared

        var state = ViewState()

        init() {
            // TODO: implement
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                var mockData = Data()
                mockData.fields[.firstName]!.value = "Test"
                mockData.fields[.lastName]!.value = "Testeric"
                mockData.fields[.dateOfBirth]!.value = "12/07/1993"
                mockData.fields[.hireDate]!.value = "01/03/2024"
                mockData.fields[.emailAddress]!.value = "mail@test.com"
                mockData.fields[.address]!.value = "Test address"
                mockData.fields[.college]!.value = "Etf"
                mockData.fields[.phoneNumber]!.value = "064333333"

                self.state.dataResult = .success(data: mockData)
            }
        }

        func updateInfo() {
            // TODO: implement
            self.state.updateInfoResult = .processing
            let updateFields = self.state.editableData.fields
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                var updatedData = self.state.data
                updatedData.fields[.emailAddress] = updateFields[.emailAddress]
                updatedData.fields[.address] = updateFields[.address]
                updatedData.fields[.college] = updateFields[.college]
                updatedData.fields[.phoneNumber] = updateFields[.phoneNumber]
                self.state.data = updatedData
                self.state.updateInfoResult = .success
            }
        }
    }
}
