//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation
import Alamofire

protocol NetManagerInput {
    func get( request: NetRequest )
}

class NetManager : NSObject {

    let sharedManager = Alamofire.Manager.sharedInstance

    var baseUrl : String?

    override init() {
        baseUrl = NSBundle.mainBundle().objectForInfoDictionaryKey("BASE_URL") as? String
    }

    func headers() -> [String: String] {
        return [ "token" : "xxx" ]
    }

    func get( request: NetRequest ) {

        let path = baseUrl! + request.path

        self.sharedManager.request(.GET, path, parameters: request.parameters, headers: headers())
        .responseJSON { response in

            switch (response.result) {
            case .Success(let json):
                guard let onSuccess = request.onSuccess else {
                    return
                }
                onSuccess( json as! NSDictionary )
                break
            case .Failure(let error):
                guard let onFailure = request.onFailure else {
                    return
                }
                onFailure( error.localizedDescription )
                break
            }

        }

    }

}
