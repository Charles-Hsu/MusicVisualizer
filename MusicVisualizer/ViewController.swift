//
//  ViewController.swift
//  MusicVisualizer
//
//  Created by Charles Hsu on 2/5/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  var audioPlayer: AVAudioPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func configureAudioPlayer() {
    var audioFileURL: NSURL! = NSBundle.mainBundle().URLForResource("DemoSong", withExtension: "m4a")

    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
  }

}

