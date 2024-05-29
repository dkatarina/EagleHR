//
// Created by Katarina Dokic
//

import Foundation

extension UsedDaysView {
    struct ViewState {
        var dataResult: DataLoadingResult<Data> = .loading {
            didSet {
                if case .success(let data) = dataResult {
                    self.data = data
                }
                if case .failure(_) = dataResult {
                    isErrorDialogShown = true
                }
            }
        }
        var data: Data = Data()

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
