//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by selin acar on 2016-06-05.
//  Copyright © 2016 selin acar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snail_button: UIButton!
    @IBOutlet weak var rabbit_button: UIButton!
    @IBOutlet weak var chipmunk_button: UIButton!
    @IBOutlet weak var darthvader_button: UIButton!
    @IBOutlet weak var parrot_button: UIButton!
    @IBOutlet weak var reverb_button: UIButton!
    @IBOutlet weak var stop_button: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum buttonType: Int{ case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("stopbutton pressed")
        stopAudio()
    }
    
    @IBAction func playButtonPressed(sender: AnyObject) {
        print("playbutton pressed")
        
        switch (buttonType(rawValue: sender.tag)!){
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 2.0)
        case .Chipmunk:
            playSound(pitch:1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo:true)
        case .Reverb:
            playSound(reverb:true)
        }
        configureUI(.Playing)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("playSoundviewcontroller loaded")
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        //set the UI to not playing
        configureUI(.NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
