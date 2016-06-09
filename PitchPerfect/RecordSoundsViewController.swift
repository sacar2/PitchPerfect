//
//  ViewController.swift
//  PitchPerfect
//
//  Created by selin acar on 2016-06-05.
//  Copyright © 2016 selin acar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {


    @IBOutlet weak var record_label: UILabel!
    @IBOutlet weak var record_button: UIButton!
    @IBOutlet weak var stopRecording_button: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewWillAppear(animated: Bool) {
        stopRecording_button.enabled = false
    }


    @IBAction func recordAudio(sender: AnyObject) {
        record_label.text = "Recording Audio"
        stopRecording_button.enabled = true
        record_button.enabled = false
        
        //we need a path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        
        //this is the audio recording
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
        //this creates the path for the file, then PRINTS it
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        //grab the session!!! grab the single instance of the av audiosession
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        record_label.text = "NOT Recording Audio"
        stopRecording_button.enabled = false
        record_button.enabled = true
        
        audioRecorder.stop()
        let audiosession = AVAudioSession.sharedInstance()
        try! audiosession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool){
        if (flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Saving of recording failed!")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "stopRecording") {
                let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
                let recordedAudioURL = sender as! NSURL
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
    }
}

