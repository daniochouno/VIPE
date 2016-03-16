//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

struct HomeViewModel {

    let nameFirst : String?
    let nameLast : String?
    let pictureThumbnail : String?

    init( randomUser: RandomUser ) {
        self.nameFirst = randomUser.nameFirst
        self.nameLast = randomUser.nameLast
        self.pictureThumbnail = randomUser.pictureThumbnail
    }

    func fullName() -> String {
        guard let first = self.nameFirst else {
            return ""
        }
        guard let last = self.nameLast else {
            return ""
        }
        return last + ", " + first
    }

}
