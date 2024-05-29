//
// Created by Katarina Dokic
//

import Foundation
import Combine

extension OrganizationView {
    @Observable
    class ViewModel {
        private let networkManager = NetworkManager.shared
        private var cancellables = Set<AnyCancellable>()

        var state = ViewState()

        func fetchData() {
            if case .success(_) = state.dataResult {
                return
            }
            networkManager.requests.getAllUsers.execute()
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
                    receiveValue: { [weak self] getAllUsersResponse in
                        guard let self else {
                            return
                        }

                        let data = Data.fromGetAllUsersResponse(getAllUsersResponse)
                        self.state.dataResult = .success(data: data)
                    })
                .store(in: &cancellables)
        }
    }
}
