//
//  ViewController.swift
//  MusicVisualizer
//
//  Created by Charles Hsu on 2/5/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

  var audioPlayer: AVAudioPlayer?
  var isPlaying: Bool?
  var playItems: NSArray?
  var pauseItems: NSArray?
  
  @IBOutlet weak var toolbar: UIToolbar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBars()
    configureAudioPlayer()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  func configureBars() {
    isPlaying = false
    
    // UIToolbar
    let pickBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search,
      target: self,
      action: "pickSong")
    let playBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Play,
      target: self,
      action: "playPause")
    let pauseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Pause,
      target: self,
      action: "playPause")
    
    let leftFlexBBI = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
      target: nil,
      action: nil)
    let rightFlexBBI = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
      target: nil,
      action: nil)
    
    playItems = [pickBarButtonItem, leftFlexBBI, playBarButtonItem, rightFlexBBI]
    pauseItems = [pickBarButtonItem, leftFlexBBI, pauseBarButtonItem, rightFlexBBI]
    
    toolbar.items = playItems
  }

  func configureAudioPlayer() {
    var audioFileURL: NSURL! = NSBundle.mainBundle().URLForResource("DemoSong", withExtension: "m4a")

    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
    
    if error != nil {
      NSLog(error!.localizedDescription)
    }
    
    audioPlayer!.numberOfLoops = -1 // loop forever
    //audioPlayer!.play()
  }

  
  func playPause() {
    
    if isPlaying! {
      
      audioPlayer!.pause()
      isPlaying = false
      toolbar.items = playItems

    } else {
      
      audioPlayer!.play()
      isPlaying = true
      toolbar.items = pauseItems
      
    }
  }
  
  func playURL(audioFileURL: NSURL) {
    if isPlaying! {
      playPause() // Pause the previous audio player
    }
    
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
    
    if error != nil {
      NSLog(error!.localizedDescription)
    }
    
    audioPlayer!.numberOfLoops = -1 // loop forever
    audioPlayer!.meteringEnabled = true
    
    playPause() // Play
    
  }
  
  
  func pickSong() {
    let picker: MPMediaPickerController = MPMediaPickerController(mediaTypes: .Music)
    picker.delegate = self
    picker.allowsPickingMultipleItems = false
    presentViewController(picker, animated: false, completion: { () -> Void in
      // code
    })
    
  }
  
  /*
   * This method is called when the user chooses something from the media picker screen.
   * It dismisses the media picker screen and plays the selected song.
   */
  func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
    // remove the media picker screen
    dismissViewControllerAnimated(false, completion: { () -> Void in
      // code
    })
    let item: MPMediaItem = mediaItemCollection.items[0] as MPMediaItem
    let url = item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL
    playURL(url)
  }
  
  /*
   * This method is called when the user cancels out of the media picker.
   * It just dismisses the media picker screen.
   */
  func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
    dismissViewControllerAnimated(false, completion: nil)
  }
  
  
}

