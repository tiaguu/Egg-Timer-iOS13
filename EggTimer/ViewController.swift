//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer : Timer?
    var initialTime : Int! = 0
    var timeLeft : Int! = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBAction func EggPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        timer?.invalidate()
        initialTime = eggTimes[hardness]
        timeLeft = eggTimes[hardness]
        
        doneLabel.text = ("Faltam \(timeLeft!) segundos.")
        progressBar.progress = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: timeLeft, repeats: true)
        
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        
        progressBar.progress = Float(Double(initialTime - timeLeft) / Double(initialTime))
        doneLabel.text = ("Faltam \(timeLeft!) segundos.")
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            doneLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    

}
