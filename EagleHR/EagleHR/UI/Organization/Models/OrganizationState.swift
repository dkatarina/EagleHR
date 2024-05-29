//
// Created by Katarina Dokic
//

import Foundation

extension OrganizationView {
    struct ViewState {
        var dataResult: DataLoadingResult<Data> = .loading {
            didSet {
                if case .success(let data) = dataResult {
                    self.data = data.users.map { user in
                        UserFields(organizationUser: user)
                    }
                }
                if case .failure(_) = dataResult {
                    isErrorDialogShown = true
                }
            }
        }
        var data: [UserFields] = []

        var isProgressViewShown: Bool {
            if case .loading = dataResult {
                true
            } else {
                false
            }
        }

        var isErrorDialogShown: Bool = false
        var error: DescriptiveError? {
            if case .failure(let error) = dataResult {
                error
            } else {
                nil
            }
        }
    }
}
