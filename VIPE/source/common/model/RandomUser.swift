//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

struct RandomUser {

    let gender : String?
    let nameFirst : String?
    let nameLast : String?
    let email : String?
    let pictureThumbnail : String?
    let nationality : String?

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
