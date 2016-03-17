//
// Created by Daniel  Martinez Muñoz on 17/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation

struct NetRequest {

    let path: String
    var parameters: [String: AnyObject]?
    var onSuccess: ((NSDictionary) -> Void)?
    var onFailure: ((String) -> Void)?

    init( path: String ) {
        self.path = path
    }

}
