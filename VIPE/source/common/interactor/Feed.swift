//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol FeedInput {
    func execute( max: Int )
}

protocol FeedOutput {
    func didExecute( data: [RandomUser] )
    func didFailExecute( errorMessage: String )
}

class Feed : NSObject, FeedInput {

    var output: FeedOutput?

    var userProvider: UserProvider

    override init() {
        self.userProvider = UserProvider.sharedProvider
        super.init()
    }

    func execute( max: Int ) {

        self.userProvider.feed( max, onSuccess: { randomUsers in
            self.output?.didExecute( randomUsers )
        }, onFailure: { errorMessage in
            self.output?.didFailExecute( errorMessage )
        })

    }

}
