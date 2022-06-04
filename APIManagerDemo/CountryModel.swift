//
//  CountryModel.swift
//  APIManagerDemo
//
//  Created by Avadh on 23/04/21.
//  Copyright © 2021 Avadh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CountryModel {
    
    var flag : String!
    var name : String!
    
    init(fromJSON json: JSON){
        flag = json["flag"].string ?? ""
        name = json["name"].string ?? ""
    }
    
}
