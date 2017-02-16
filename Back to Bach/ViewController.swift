//
//  ViewController.swift
//  Back to Bach
//
//  Created by Marc Aupont on 12/25/15.
//  Copyright © 2015 Digimark. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet var volumeSlider: UISlider!
    
    @IBOutlet var scrubSlider: UISlider!
    
    @IBAction func scrub(sender: AnyObject) {
        
        //This line of code makes it so that the scrub slider's value sets the current time of the music being played. This allows user to seek/scrub through the audio file being played
        player.currentTime = NSTimeInterval(scrubSlider.value)
    }
    

    @IBAction func play(sender: AnyObject) {
        
        player.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        
        player.pause()
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        player.stop()
        
        loadFile()
    }
    
    @IBAction func adjustVolume(sender: AnyObject) {
        
        player.volume = volumeSlider.value
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFile()
        
    }
    
    //This function will set the scrubslider value to the current time of the audio file being played
    func updateScrubSlider() {
        
        scrubSlider.value = Float(player.currentTime)
    }
    
    func loadFile() {
        
        //This line of code sets up the variable that points to the actual audio file thats part of the project/app
        let audioPath = NSBundle.mainBundle().pathForResource("bach-bwv924-breemer", ofType: "mp3")!
        
        
        //This code below says "do" the code in between the brackets, and "try" to play the audio file. If you cannot, the catch option is the "error handling" portion of it
        do {
            
            try player = AVAudioPlayer(contentsOfURL:NSURL(fileURLWithPath: audioPath))
            
            //This line of code limits the max value of slider to the duration of mp3 file. The max value is of type "Float" and the player.duration is of type NSTimeInterval. In order for this to work we have to convert the player duration to type "Float"
            scrubSlider.maximumValue = Float(player.duration)
            
            
        } catch {
            
            print("Could not load file")
            
        }
        
        //This code is to set up the slider so that it increments in intervals of 1 second
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

