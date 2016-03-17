//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

class UserService {

    let netManager = NetManager()

    func login( username: String, password: String, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? ) {

        var netRequest = NetRequest( path: "?results=1" )
        netRequest.parameters = [
            "user": username,
            "password": password
        ]
        netRequest.onSuccess = { response in
            guard let onSuccess = onSuccess else {
                return
            }
            onSuccess( response )
        }
        netRequest.onFailure = { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        }

        self.netManager.get( netRequest )

    }

    func feed( max: Int, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? ) {

        var netRequest = NetRequest( path: "?results=\(max)" )
        netRequest.onSuccess = { response in
            guard let onSuccess = onSuccess else {
                return
            }
            onSuccess( response )
        }
        netRequest.onFailure = { error in
            guard let onFailure = onFailure else {
                return
            }
            onFailure( error )
        }

        self.netManager.get( netRequest )

    }

}
