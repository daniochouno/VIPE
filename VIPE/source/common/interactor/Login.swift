//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol LoginInput {
    func execute()
}

protocol LoginOutput {
    func didExecute()
    func didFailExecute( errorMessage: String )
}

class Login : NSObject, LoginInput {

    var output: LoginOutput?

    var userProvider: UserProvider

    var username : String?
    var password : String?

    override init() {
        self.userProvider = UserProvider.sharedProvider
        super.init()
    }

    func execute() {

        guard let username = self.username else {
            self.output?.didFailExecute("Username cannot be empty")
            return
        }
        guard let password = self.password else {
            self.output?.didFailExecute("Password cannot be empty")
            return
        }

        guard username.characters.count > 0 else {
            self.output?.didFailExecute("Username cannot be empty")
            return
        }
        guard password.characters.count > 0 else {
            self.output?.didFailExecute("Password cannot be empty")
            return
        }

        self.userProvider.login( username, password: password, onSuccess: {
            self.output?.didExecute()
        }, onFailure: { errorMessage in
            self.output?.didFailExecute( errorMessage )
        })

    }

}
