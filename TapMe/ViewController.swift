//
//  ViewController.swift
//  TapMe
//
//  Created by Vamshedhar on 03/02/15.
//  Copyright (c) 2015 Vamshedhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var buttonBeep = AVAudioPlayer()
    var secondBeep = AVAudioPlayer()
    var backgroundMusic = AVAudioPlayer()
    
    let gameTime = 10;
    
    var count = 0;
    
    var seconds = 0;
    
    var timer = NSTimer()
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        var path = NSBundle.mainBundle().pathForResource(file, ofType:type)
        var url = NSURL.fileURLWithPath(path!)
        
        //2
        var error: NSError?
        
        //3
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4
        return audioPlayer!
    }

    
    func setUpGame(){
        backgroundMusic.volume = 0.3
        backgroundMusic.play()
        count = 0;
        seconds = gameTime;
        
        timerLabel.text = "Time: \(seconds) sec"
        scoreLabel.text = "Score: \n\(count)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
    }
    
    func subtractTime(){
        seconds--;
        secondBeep.play()
        
        timerLabel.text = "Time: \(seconds) sec"
        
        if(seconds == 0){
            timer.invalidate()
            let alert = UIAlertController(title: "Time is up!",
                message: "You scored \(count) points",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.setUpGame()
            }))
            
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_tile.png")!)
        
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score.png")!)
        timerLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_time.png")!)
        
        buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav")
        secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav")
        backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3")


        // Do any additional setup after loading the view, typically from a nib.
        setUpGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        buttonBeep.play()
        count++
        scoreLabel.text = "Score: \n\(count)"
    }

}

