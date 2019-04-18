//
//  Animal.swift
//  ItsAZooInThere
//
//  Created by Mahjeed Marrow on 4/17/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import Foundation
import UIKit



//MARK: Animal class declaration
class Animal: CustomStringConvertible {
    
    //declare object properties
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath:String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
    
    //prints to console some information about the animal
    var description: String {
        return "Animal: name = \(name), species = \(species), age = \(age)"
    }
}
