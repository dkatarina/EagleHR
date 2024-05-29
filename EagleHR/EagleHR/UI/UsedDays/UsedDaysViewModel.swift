//
// Created by Katarina Dokic
//

import Foundation
import Combine

extension UsedDaysView {
    @Observable
    class ViewModel {
        private let networkManager = NetworkManager.shared
        private let authenticationManager = AuthenticationManager.shared
        private var cancellables = Set<AnyCancellable>()

        var state = ViewState()

        func fetchData() {
            if case .success(_) = state.dataResult {
                return
            }
            networkManager.requests.getDaysUsage.execute()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self else {
                            return
                        }

                        if case .failure(let error) = completion {
                            print(error)
                            self.state.dataResult = .failure(
                                DescriptiveError(errorDescription: "Something went wrong.")
                            )
                        }
                    },
                    receiveValue: { [weak self] getDaysUsageResponse in
                        guard let self else {
                            return
                        }

                        guard let daysUsage = getDaysUsageResponse.items.first else {
                            self.state.dataResult = .failure(
                                DescriptiveError(errorDescription: "Something went wrong.")
                            )
                            return
                        }

                        let data = Data(
                            availablePto: authenticationManager.getAvailablePto(),
                            totalUsedPto: daysUsage.paidTimeOff,
                            calledInSick: daysUsage.sickDays,
                            personalLeave: daysUsage.personalExcuse,
                            patronSaintDay: daysUsage.patronSaintDay,
                            onBusinessLeave: daysUsage.absenceDueToBusiness,
                            workedFromHome: daysUsage.workFromHome
                        )
                        self.state.dataResult = .success(data: data)
                    })
                .store(in: &cancellables)
        }
    }
}

