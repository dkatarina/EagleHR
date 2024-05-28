//
// Created by Katarina Dokic
//

import Foundation

enum DataLoadingResult <Data> {
    case success(data: Data)
    case failure(_ error: DescriptiveError)
    case loading
}
