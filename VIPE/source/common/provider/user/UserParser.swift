//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

class UserParser {

    func parse( input: NSDictionary ) -> [RandomUser] {

        var randomUsers = [RandomUser]()

        if let results = input["results"] as? [[String: AnyObject]] {
            for result in results {
                if let user = result["user"] as? [String: AnyObject] {

                    let _gender = user["gender"] as? String
                    var _first : String?
                    var _last : String?
                    if let userName = user["name"] as? [String: AnyObject] {
                        _first = userName["first"] as? String
                        _last = userName["last"] as? String
                    }
                    let _email = user["email"] as? String
                    var _thumbnail : String?
                    if let userPicture = user["picture"] as? [String: AnyObject] {
                        _thumbnail = userPicture["thumbnail"] as? String
                    }
                    let _nationality = user["nationality"] as? String

                    let randomUser = RandomUser(
                    gender: _gender,
                            nameFirst: _first,
                            nameLast: _last,
                            email: _email,
                            pictureThumbnail: _thumbnail,
                            nationality: _nationality
                    )
                    randomUsers.append(randomUser)

                }
            }
        }

        return randomUsers

    }

}
