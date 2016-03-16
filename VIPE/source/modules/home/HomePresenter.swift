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
    func didLoadData()
    func didFailLoadData( message: String )
    func didLogout()
}

class HomePresenter : NSObject, HomePresenterInput {

    var output: HomePresenterOutput?

    var feed = Feed()

    var array : [RandomUser]?

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

    func numberOfItemsInSection( section: Int ) -> Int {
        if let array = self.array {
            return array.count
        }
        return 0
    }

    func cellForItemAtIndexPath( indexPath: NSIndexPath ) -> RandomUser? {
        return self.array?[indexPath.row]
    }

}

extension HomePresenter : FeedOutput {

    func didExecute( data: [RandomUser] ) {
        self.array = data
        self.output?.didLoadData()
    }

    func didFailExecute( errorMessage: String ) {
        self.output?.didFailLoadData( errorMessage )
    }

    func didLogout() {
        self.output?.didLogout()
    }

}
