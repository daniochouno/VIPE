//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import Foundation
import Alamofire

protocol NetManagerInput {
    func get( url: String, parameters: [String: AnyObject]?, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? )
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

    func get( url: String, parameters: [String: AnyObject]?, onSuccess: ((NSDictionary) -> Void)?, onFailure: ((String) -> Void)? ) {

        let path = baseUrl! + url

        self.sharedManager.request(.GET, path, parameters: parameters, headers: headers())
        .responseJSON { response in

            switch (response.result) {
            case .Success(let json):
                guard let onSuccess = onSuccess else {
                    return
                }
                onSuccess( json as! NSDictionary )
                break
            case .Failure(let error):
                guard let onFailure = onFailure else {
                    return
                }
                onFailure( error.localizedDescription )
                break
            }

        }

    }

}
