//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import UIKit

class LoginViewController : ScrollableContentViewController {

    let presenter = LoginPresenter()

    @IBOutlet weak var usernameText: UITextField?
    @IBOutlet weak var passwordText: UITextField?
    @IBOutlet weak var errorMessage: UILabel!

    @IBAction func loginButtonPressed() {
        guard let username = self.usernameText!.text else {
            return
        }
        guard let password = self.passwordText!.text else {
            return
        }
        self.presenter.loginAction( username, password: password )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPresenter()
        setUpDelegates()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
        setUpForm()
    }

    func setUpPresenter() {
        self.presenter.output = self
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }

    func setUpDelegates() {
        self.usernameText?.delegate = self
        self.passwordText?.delegate = self
    }
    
    func setUpForm() {
        self.usernameText?.text = ""
        self.passwordText?.text = ""
        self.errorMessage.text = ""
        self.errorMessage.hidden = true
    }

}

extension LoginViewController : LoginPresenterOutput {

    func didLogin() {
        self.performSegueWithIdentifier("LoginToHome", sender: self)
    }

    func didFailLogin( message: String ) {
        self.errorMessage.text = message
        self.errorMessage.hidden = false
    }

}
