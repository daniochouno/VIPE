//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

class UserProvider : NSObject {

    static let sharedProvider = UserProvider()

    var userService: UserService

    override init() {
        self.userService = UserService()
        super.init()
    }

    func login( username: String, password: String, onSuccess: ((Void) -> Void)?, onFailure: ((String) -> Void)? ) {

        self.userService.login( username, password: password, onSuccess: { _ in
            guard let onSuccess = onSuccess else {
                return
            }
            onSuccess()
        }, onFailure: { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        })

    }

    func feed( max: Int, onSuccess: (([RandomUser]) -> Void)?, onFailure: ((String) -> Void)? ) {

        self.userService.feed( max, onSuccess: { data in

            guard let onSuccess = onSuccess else {
                return
            }

            let dataFormatted = UserParser().parse( data )
            onSuccess( dataFormatted )

        }, onFailure: { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        })

    }

}
