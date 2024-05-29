//
// Created by Katarina Dokic
//

import Foundation
import Combine

extension MyInfoView {
    @Observable
    class ViewModel {
        private let networkManager = NetworkManager.shared
        private var cancellables = Set<AnyCancellable>()

        private let authenticationManager = AuthenticationManager.shared

        var state = ViewState()

        func fetchData() {
            if case .success(_) = state.dataResult {
                return
            }

            networkManager.requests.getUserInfo.execute()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self else {
                            return
                        }

                        if case .failure(_) = completion {
                            self.state.dataResult = .failure(
                                DescriptiveError(errorDescription: "Something went wrong.")
                            )
                        }
                    },
                    receiveValue: { [weak self] userInfoResponse in
                        guard let self else {
                            return
                        }

                        let data = Data.fromUserInfoResponse(userInfoResponse)
                        self.state.dataResult = .success(data: data)
                    })
                .store(in: &cancellables)
        }

        func updateInfo() {
            self.state.updateInfoResult = .processing

            let updateFields = self.state.editableData.fields

            let isEmailChanged = updateFields[.emailAddress]!.value != self.state.data.fields[.emailAddress]!.value

            let requestBody = UpdateUserInfoRequest.Body(
                email: updateFields[.emailAddress]!.value,
                address: updateFields[.address]!.value,
                phoneNumber: updateFields[.phoneNumber]!.value,
                college: updateFields[.college]!.value
            )

            networkManager.requests.updateUserInfo.execute(requestBody)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self else {
                            return
                        }

                        if case .failure(let error) = completion {
                            self.state.updateInfoResult = .failure(
                                DescriptiveError(errorDescription: (error as? ApiError)?.message ?? error.localizedDescription)
                            )
                        }
                    },
                    receiveValue: { [weak self] _ in
                        guard let self else {
                            return
                        }

                        var updatedData = self.state.data
                        updatedData.fields[.emailAddress] = updateFields[.emailAddress]
                        updatedData.fields[.address] = updateFields[.address]
                        updatedData.fields[.college] = updateFields[.college]
                        updatedData.fields[.phoneNumber] = updateFields[.phoneNumber]
                        self.state.data = updatedData

                        if isEmailChanged {
                            self.state.isForceLogoutDialogShown = true
                        }

                        self.state.updateInfoResult = .success
                    })
                .store(in: &cancellables)
        }

        func logout() {
            authenticationManager.logout()
        }
    }
}
