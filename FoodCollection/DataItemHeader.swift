//
//  DataItemHeader.swift
//  FoodCollection
//
//  Created by Isaac Kim on 9/4/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import UIKit

class DataItemHeader: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
}
