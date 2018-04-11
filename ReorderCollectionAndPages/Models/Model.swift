//
//  Model.swift
//  PageBasedApp
//
//  Created by Imanou Petit on 17/10/2016.
//  Copyright © 2016 Imanou Petit. All rights reserved.
//

import Foundation

class Model {
    
    /// The array containing the elements to display.
    var array: [String]
    
    init() {
        array = [Int](1...100).map(String.init)
    }
    
}
