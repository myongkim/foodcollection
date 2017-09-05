//
//  DataItem.swift
//  FoodCollection
//
//  Created by Isaac Kim on 9/1/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import UIKit

class DataItem {
    var title: String
    var kind: Kind
    var imageName: String
    
    init(title: String, kind: Kind, imageName: String) {
        self.title = title
        self.kind = kind
        self.imageName = imageName
    }
}


enum Kind: Int {
    case Asian
    case American
    
    func description() -> String {
        switch self {
        case .Asian:
            return "Asian"
        case .American:
            return "American"
        }
    }
}
