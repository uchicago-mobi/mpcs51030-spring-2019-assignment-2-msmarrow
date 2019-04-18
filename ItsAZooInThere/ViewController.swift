//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Mahjeed Marrow on 4/16/19.
//  Copyright © 2019 Mahjeed Marrow. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    //MARK: outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var speciesLabel: UILabel!
    
    //MARK: class properties
    var animals = [Animal]()
    var animalSounds: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set scrollView properties
        scrollView.delegate = self as UIScrollViewDelegate
        scrollView.contentSize = CGSize(width:1125, height:500)
        scrollView.isPagingEnabled = true
        
        // declare image variables
        let ocelotImage = UIImage(named:"Ocelot")!
        let bearImage = UIImage(named:"Bear")!
        let foxImage = UIImage(named:"Fox")!
        
        //delcare sound file variables
        let ocelotSound = Bundle.main.path(forResource: "ocelot.mp3", ofType: nil)
        let bearSound = Bundle.main.path(forResource: "bear.mp3", ofType: nil)
        let foxSound = Bundle.main.path(forResource: "fox.mp3", ofType: nil)
        
        //define animal instances
        let ocelot: Animal = Animal(name:"Womack", species:"Ocelot", age: 9, image: ocelotImage, soundPath: ocelotSound!)
        let bear: Animal = Animal(name:"Khabib", species:"Brown Bear", age: 14, image: bearImage, soundPath: bearSound!)
        let fox: Animal = Animal(name:"De'Aaron", species:"Fox", age: 2, image: foxImage, soundPath: foxSound!)
        
        // shuffle array so order of animal appearance is random on each load
        self.animals = [ocelot,bear,fox].shuffled()
        
        // set label properties
        speciesLabel.textAlignment = .center
        speciesLabel.text = animals[0].species
        
        //add button and image subviews for each animal
        for (index, animal) in animals.enumerated(){
            let button = UIButton(type: .system)
            let imageSub = UIImageView()
            
            //set x position of button
            let xCoord = CGFloat(index) * 375
            
            //set button properties for a single animal
            button.frame = CGRect(x: xCoord, y: 0, width: 375, height: 500)
            button.tag = index
            button.setTitle(animal.name, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            scrollView.addSubview(button)
            
            //set image view properties for a single animal
            imageSub.image = animal.image
            imageSub.frame = CGRect(x: xCoord, y: 0, width: 375, height: 500)
            scrollView.addSubview(imageSub)
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        //specify which animal to display information on
        let animalTag = sender.tag
        let animal = animals[animalTag]
        
        //specify content of alert
        let alertHandler = UIAlertController(title: "Hyde Park Zoo", message: "Name: \(animal.name) \r Species: \(animal.species) \r Age: \(animal.age)", preferredStyle: .alert)
        
        alertHandler.addAction(UIAlertAction(title:"Awesome!",style:.default))
        self.present(alertHandler, animated: true, completion: nil)
        
        //print appropriate animal to the console
        print(animal)

        //handle audio
        let url = URL(fileURLWithPath: animal.soundPath)
        do {
            animalSounds = try AVAudioPlayer(contentsOf: url)
            animalSounds?.play()
        } catch {
            print("Audio Not Found!")
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let xCoord = Int(scrollView.contentOffset.x)
        var pageCurrent = 0
        
        //change page depending on X coordinate positioning
        switch xCoord {
        case 187..<562:
            pageCurrent = 1
        case 562..<938:
            pageCurrent = 2
        default:
            pageCurrent = 0
        }
        
        // set current alpha value and animal
        let animalCurrent = animals[pageCurrent]
        let alphaVal: CGFloat = CGFloat(abs((187.5 - Double(xCoord % 375)) / (375 / 2)))
        speciesLabel.alpha = alphaVal
        
        // set appropriate label
        speciesLabel.text = animalCurrent.species
    }
}
