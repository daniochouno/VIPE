//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

class UserService {

    let netManager = NetManager()

    func login( username: String, password: String, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? ) {

        self.netManager.get( "?results=1", parameters: [
            "user": username,
            "password": password
        ], onSuccess: { response in

            guard let onSuccess = onSuccess else {
                return
            }
            onSuccess( response )

        }, onFailure: { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        })

    }

    func feed( max: Int, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? ) {

        self.netManager.get( "?results=\(max)", parameters: nil, onSuccess: { response in

            guard let onSuccess = onSuccess else {
                return
            }
            onSuccess( response )

        }, onFailure: { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        })

    }

}
