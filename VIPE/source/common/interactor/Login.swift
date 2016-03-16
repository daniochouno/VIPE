//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol LoginInput {
    func execute( username: String, password: String )
}

protocol LoginOutput {
    func didExecute()
    func didFailExecute( errorMessage: String )
}

class Login : NSObject, LoginInput {

    var output: LoginOutput?

    var userProvider: UserProvider

    override init() {
        self.userProvider = UserProvider.sharedProvider
        super.init()
    }

    func execute( username: String, password: String ) {

        self.userProvider.login( username, password: password, onSuccess: {
            self.output?.didExecute()
        }, onFailure: { errorMessage in
            self.output?.didFailExecute( errorMessage )
        })

    }

}