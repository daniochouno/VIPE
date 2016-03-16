//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol HomePresenterInput {
    func loadDataAction()
    func logoutAction()
}

protocol HomePresenterOutput {
    func didLoadData( data: [HomeViewModel] )
    func didFailLoadData( message: String )
    func didLogout()
}

class HomePresenter : NSObject, HomePresenterInput {

    var output: HomePresenterOutput?

    var feed = Feed()

    override init() {
        super.init()
        self.feed.output = self
    }

    func loadDataAction() {
        self.feed.execute( 20 )
    }

    func logoutAction() {
        self.didLogout()
    }

}

extension HomePresenter : FeedOutput {

    func didExecute( data: [RandomUser] ) {
        var randomUsers = [HomeViewModel]()
        for randomUser in data {
            randomUsers.append(HomeViewModel( randomUser: randomUser ))
        }
        self.output?.didLoadData( randomUsers )
    }

    func didFailExecute( errorMessage: String ) {
        self.output?.didFailLoadData( errorMessage )
    }

    func didLogout() {
        self.output?.didLogout()
    }

}
