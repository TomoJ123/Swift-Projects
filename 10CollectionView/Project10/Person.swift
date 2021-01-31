//
//  Person.swift
//  Project10
//
//  Created by Tomislav Jurić-Arambašić on 28.01.2021..
//  Copyright © 2021 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
