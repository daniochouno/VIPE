//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

protocol FeedInput {
    func execute()
}

protocol FeedOutput {
    func didExecute( data: [RandomUser] )
    func didFailExecute( errorMessage: String )
}

class Feed : NSObject, FeedInput {

    var output: FeedOutput?

    var userProvider: UserProvider

    var max : Int?

    override init() {
        self.userProvider = UserProvider.sharedProvider
        super.init()
    }

    func execute() {

        guard let max = self.max else {
            self.output?.didFailExecute("An error appears")
            return
        }

        self.userProvider.feed( max, onSuccess: {
            randomUsers in
            self.output?.didExecute(randomUsers)
        }, onFailure: {
            errorMessage in
            self.output?.didFailExecute(errorMessage)
        })

    }

}
