//
// Created by Katarina Dokic
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()

    private init(){}

    let requests = Requests()

    struct Requests {
        let login = LoginRequest()
        let getUserInfo = GetUserInfoRequest()
        let updateUserInfo = UpdateUserInfoRequest()
    }
}
