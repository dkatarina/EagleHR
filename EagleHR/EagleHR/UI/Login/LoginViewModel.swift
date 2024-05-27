//
// Created by Katarina Dokic
//

import Foundation
import Combine

extension LoginView {
    @Observable
    class ViewModel {
        private let networkManager = NetworkManager.shared
        private var cancellables = Set<AnyCancellable>()

        var state = ViewState()

        func login() {
            state.loginResult = .processing

            networkManager.requests.login.execute(
                body: LoginRequest.Body(
                    email: state.email.content,
                    password: state.password.content
                )
            ).receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self else {
                            return
                        }
                        if case .failure(let error) = completion {
                            self.state.loginResult = .failure(
                                DescriptiveError(
                                    errorDescription: (error as? ApiError)?.message ?? error.localizedDescription
                                )
                            )
                        }
                    },
                    receiveValue: { [weak self] _ in
                        guard let self else {
                            return
                        }
                        self.state.loginResult = .success
                    })
                .store(in: &cancellables)
        }
    }
}
