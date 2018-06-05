//
//  ViewController.swift
//  yesOrNo
//
//  Created by Antonio Giaquinto on 17/02/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var goButton: UIButton!
    
    var point = 0
    var error = 0
    var counter = 0
    var totalGame = 150
    var seconds = 0.00
    var timer = Timer()
    var isTimerRunning = false
    var images = [#imageLiteral(resourceName: "g"), #imageLiteral(resourceName: "ng"), #imageLiteral(resourceName: "ng2"), #imageLiteral(resourceName: "ng3")]
    var newImage: UIImage!
    var go: [UIImage] = []
    var missedGo = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.50, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        self.isTimerRunning = true
    }
    
    @objc func updateTimer(){
        play()
        seconds += 0.50
//        debugPrint("Time: \(seconds)")
    }
    
    func restartTimer() {
        print("Restart ok")
        timer.invalidate()
        seconds = 0
        isTimerRunning = false
        runTimer()
    }
    
    func play() {
        if counter < totalGame {
            debugPrint("Game: \(counter)")
            goButton.isEnabled = false
            image.image = #imageLiteral(resourceName: "fixation point")
            debugPrint("Time Restarted1: \(seconds)")
            if seconds > 0.99 && seconds < 1.01 {
                goButton.isEnabled = true
                var randomNumber = Int(arc4random_uniform((UInt32(images.count))))
                newImage = images[randomNumber]
                image.image = newImage
                if newImage == #imageLiteral(resourceName: "g") {
                    go.append(newImage)
                }
                counter += 1
                restartTimer()
                debugPrint("Time Restarted2: \(seconds)")
                if seconds > 0.49 && seconds < 0.51 {
                    play()
                    debugPrint("Sono nel terzo if")
                }
            }
        } else {
            image.image = #imageLiteral(resourceName: "fixation point")
            goButton.isEnabled = false
            debugPrint("END: game \(counter)")
            if go.count == point {
                debugPrint("All go is tapped: \(go.count) = \(point)")
            } else {
                missedGo = go.count - point
                debugPrint("Go Missed: \(missedGo)")
            }
        }
    }
    
    @IBAction func go(_ sender: Any) {
        if newImage == #imageLiteral(resourceName: "g") {
            point += 1
            debugPrint("Points: \(point)")
            debugPrint("Errors: \(error)")
        } else {
            error += 1
            debugPrint("Errors: \(error)")
            debugPrint("Points: \(point)")
        }
    }
}

