//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol LoginPresenterInput {
    func loginAction( username: String, password: String )
}

protocol LoginPresenterOutput {
    func didLogin()
    func didFailLogin( message: String )
}

class LoginPresenter : NSObject, LoginPresenterInput {

    var output: LoginPresenterOutput?

    var login = Login()

    override init() {
        super.init()
        self.login.output = self
    }

    func loginAction( username: String, password: String ) {
        self.login.execute( username, password: password )
    }

}

extension LoginPresenter : LoginOutput {

    func didExecute() {
        self.output?.didLogin()
    }
    
    func didFailExecute( errorMessage: String ) {
        self.output?.didFailLogin( errorMessage )
    }

}