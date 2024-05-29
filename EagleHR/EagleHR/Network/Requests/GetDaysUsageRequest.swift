//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct GetDaysUsageRequest : GetRequest, Authorized {
    typealias NetworkResponse = Response

    var url: String {
        "https://api-assigment.eaglelab.com/v1/usage"
    }
}

extension GetDaysUsageRequest {
    struct Response : Decodable {
        let items: [Usage]
    }

    struct Usage: Decodable {
        let paidTimeOff: Int
        let sickDays: Int
        let patronSaintDay: Int
        let personalExcuse: Int
        let absenceDueToBusiness: Int
        let workFromHome: Int

        enum CodingKeys: String, CodingKey {
            case paidTimeOff
            case sickDays
            case patronSaintDay
            case personalExcuse
            case absenceDueToBusiness
            case workFromHome
        }
    }
}
