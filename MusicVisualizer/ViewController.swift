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

class ViewController: UIViewController, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate {

  var audioPlayer: AVAudioPlayer?
  var isPlaying: Bool = false
  var playItems: NSArray?
  var pauseItems: NSArray?
  var isBarHide: Bool = false
  
  var isVolumeSilderHide: Bool = true
  
  var interruptedOnPlayback: Bool = false
  
  let kPickedMusicUrl = "pickedMusicUrl"
  let kPickedMusicTitle = "pickedMusicTitle"
  
  var lastTranslationX: CGFloat = 0
  var currentDeviceVolume: Float = 0.0

  
  //var volumeSlider: UISlider?
  
  @IBOutlet weak var songTitle: UINavigationItem!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var volumeIcon: UIBarButtonItem!
  
  @IBOutlet weak var slider: UISlider!
  //@IBOutlet weak var statusLabel: UILabel!
  
  var mpVolumeSilder: UISlider?
  
  @IBOutlet weak var mpVolumeView: MPVolumeView!
  
  @IBAction func tapDetected(sender: UITapGestureRecognizer) {
    //statusLabel.text = "Single Tap"
    NSLog("Single Tap")
    playPause()
    //toggleBars()
  }
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBars()
    configureAudioPlayer()
    settingAudioSessionHardware()
    
    setupVolumeView()
    
//    let playlistsQuery: MPMediaQuery = MPMediaQuery.playlistsQuery()
//    let playlists: NSArray = playlistsQuery.collections
//    for var i=0; i < playlists.count; i++ {
//      var playlist = playlists[i] as MPMediaPlaylist
//      println("playlist=\(playlist.valueForProperty(MPMediaPlaylistPropertyPersistentID))")
//      println("playlist=\(playlist.valueForProperty(MPMediaPlaylistPropertyName))")
//      println("playlist=\(playlist.valueForProperty(MPMediaPlaylistPropertyPlaylistAttributes))")
//      println("playlist=\(playlist.valueForProperty(MPMediaPlaylistPropertySeedItems))")
//    }
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  //
  // AVAudioRecorderDelegate protocol
  //
  func audioPlayerBeginInterruption(player: AVAudioPlayer!) {
    if isPlaying {
      isPlaying = false
      interruptedOnPlayback = true
      // self.updateUserInterface()
    }
  }
  
  //
  // AVAudioRecorderDelegate protocol
  //
  func audioPlayerEndInterruption(player: AVAudioPlayer!) {
    if interruptedOnPlayback {
      player.prepareToPlay()
      player.play()
      isPlaying = true
      interruptedOnPlayback = false
    }
  }
  
  //
  // Setting AudioSession hardware values
  //
  func settingAudioSessionHardware() {
    
    NSLog("settingAudioSessionHardware")
    
    var session = AVAudioSession.sharedInstance()
    var error: NSError?
    
    session.setCategory(AVAudioSessionCategoryPlayback, error: &error)
    if error != nil {
      // Todo: show a alert inform user error message
      println(error!.localizedDescription)
    }
//    session.setActive(true, error: &error)
//    if error != nil {
//      // Todo: show a alert inform user error message
//      println(error!.localizedDescription)
//    }
  }
  
  func activeAudioSession(isEnable: Bool) {
    var activationError: NSError?
    var success: Bool = AVAudioSession.sharedInstance().setActive(isEnable, error: &activationError)
    if !success {
      // Todo: show a alert to inform user activation failed
      println(activationError!.localizedDescription)
      return
    }
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
    
    let volumeIcon: UIImage = UIImage(named: "VolumeIcon.png")!
    let iconSize: CGSize = CGSizeMake(27, 27)
    
    let volumeBBI = UIBarButtonItem(image: volumeIcon.scaleToSize(iconSize),
      style: UIBarButtonItemStyle.Plain, target: self, action: nil /*"showVolumeSlider"*/)
    
    playItems = [pickBarButtonItem, leftFlexBBI, playBarButtonItem, rightFlexBBI, volumeBBI]
    pauseItems = [pickBarButtonItem, leftFlexBBI, pauseBarButtonItem, rightFlexBBI, volumeBBI]
    
    toolbar.items = playItems
    
    println("toolbar.frame.size = \(toolbar.frame.size)") // 600, 44
    println("toolbar.items!.count = \(toolbar.items!.count)")
    println("toolbar.frame.origin = \(toolbar.frame.origin)") // 600, 44
    println("volumeBBI.image?.description=\(volumeBBI.image?.description)")
    println("volumeBBI.customView?.frame.origin=\(volumeBBI.customView?.frame.origin)")

    UIToolbar.appearance().tintColor = UIColor.brownColor()
    //UIToolbar.appearance().setBackgroundImage(UIImage(named: "English-Study-Abroad.jpg"), forToolbarPosition: UIBarPosition.Bottom, barMetrics: UIBarMetrics.Default)
  }
  
  @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
    
    let translation = recognizer.translationInView(self.view)
    
    //println("self.view.frame=\(self.view.frame)")
    // 4s: 480x320
    // 5:  568x320
    // 5s: 568x320
    // 6:  667x375
    // 6+: 736x414
    // iPad 2:      1024x768
    // iPad Air:    1024x768
    // iPad Retina: 1024x768
    
    //println("mpVolumeView.frame.width=\(mpVolumeView.frame.width)")
    // 4s: 402
    // 5:  490
    // 5s: 490
    // 6:  589
    // 6+: 650
    // iPad 2:      938
    // iPad Air:    938
    // iPad Retina: 938

    translation.x // CGFloat
    mpVolumeView.frame.width // CGFloat
    
    let dx = (translation.x-lastTranslationX)
    let volumeChanged = Float(dx / mpVolumeView.frame.width)

    //println("currentDeviceVolume=\(currentDeviceVolume)")
    //println("lastTranslationX=\(lastTranslationX) \t translationX=\(translation.x) \t dx=\(dx))\t volumeChanged=\(volumeChanged)")

    currentDeviceVolume = currentDeviceVolume + Float(volumeChanged)

    if currentDeviceVolume > 1 {
      currentDeviceVolume = 1
    } else if currentDeviceVolume < 0 {
      currentDeviceVolume = 0
    }
    
    //println("currentDeviceVolume=\(currentDeviceVolume)")
    
    mpVolumeSilder!.value = currentDeviceVolume
    
    if recognizer.state == .Changed {
      lastTranslationX = translation.x
    }
    
    if recognizer.state == .Ended || recognizer.state == .Began {
      lastTranslationX = 0
      self.showVolumeSliderView()
    }
    
  }

  func setupVolumeView() {
    
    NSLog("setupVolumeView()")
    
    let model = UIDevice.currentDevice().model as String
    let range = model.rangesOfString("Simulator")

    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
    let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)

    mpVolumeView.backgroundColor = UIColor.clearColor()
    
    if range.first != nil {
      slider.setThumbImage(thumbImageNormal, forState: .Normal)
      slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
      slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
      slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
      return
    }
  
    slider.hidden = true
    
    mpVolumeView.showsVolumeSlider = true
    mpVolumeView.showsRouteButton = false
    
    mpVolumeView.setVolumeThumbImage(thumbImageNormal, forState: .Normal)
    mpVolumeView.setVolumeThumbImage(thumbImageHighlighted, forState: .Highlighted)
    mpVolumeView.setMinimumVolumeSliderImage(trackLeftResizable, forState: .Normal)
    mpVolumeView.setMaximumVolumeSliderImage(trackRightResizable, forState: .Normal)
    
    //mpVolumeView.setRouteButtonImage(thumbImageNormal, forState: .Normal)
    //mpVolumeView.setRouteButtonImage(thumbImageHighlighted, forState: .Highlighted)
    
    for view in mpVolumeView.subviews {
      let uiview: UIView = view as UIView
      println("\(uiview.description)")
      if uiview.description.rangesOfString("MPVolumeSlider").first != nil {
        mpVolumeSilder = (uiview as UISlider)
        currentDeviceVolume = mpVolumeSilder!.value
        return
      }
    }
    
    //mpVolumeSilder?.value = 0.0

    //println("mpVolumeSilder?.value=\(mpVolumeSilder?.value)")  // [0.0, 1.0]
    //println("mpVolumeView.frame.width=\(mpVolumeView.frame.width)")
    
    //let trans = CGAffineTransformMakeRotation(CGFloat(M_PI * -0.5))
    //println("mpVolumeView.layer.position=\(mpVolumeView.layer.position)")
    //println("mpVolumeView.layer.anchorPoint=\(mpVolumeView.layer.anchorPoint)")
    
    //mpVolumeView.setTranslatesAutoresizingMaskIntoConstraints(true)

    //mpVolumeView.center = CGPointMake(300, 0)
    //mpVolumeView.frame.origin = CGPointMake(600, 600)
    
    //println("mpVolumeView.frame=\(mpVolumeView.frame)")
    //println("mpVolumeView.bounds=\(mpVolumeView.bounds)")
    //println("self.view.bounds=\(self.view.bounds)")
    //println("self.view.frame=\(self.view.frame)")

    //mpVolumeView.layer.anchorPoint = CGPointMake(0.5, 0.5)
    //mpVolumeView.transform = trans
    
  }
  
  
  func showVolumeSliderView() {
    
    let ofsetHeight = toolbar.frame.height * 2
    
    UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
      var basketTopFrame = self.mpVolumeView.frame
      
      if self.isVolumeSilderHide {
        basketTopFrame.origin.y -= ofsetHeight // basketTopFrame.size.height
      } else {
        basketTopFrame.origin.y += ofsetHeight //basketTopFrame.size.height
      }
      
      self.isVolumeSilderHide = !self.isVolumeSilderHide
      self.mpVolumeView.frame = basketTopFrame

    }, completion: { finished in
        //println("Basket doors opened!")
    })

  }


  func configureAudioPlayer() {
    var url: NSURL? = getPickedMusicUrl()
    var title: String? = getPickedMusicTitle()
    
    println("pickedMusicUrl=\(url)")

    if url == nil {
      var audioFileURL: NSURL! = NSBundle.mainBundle().URLForResource("DemoSong", withExtension: "m4a")
      url = audioFileURL
    }
    
    songTitle.title = title as String!
    var error: NSError?

    audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    
    if error != nil {
      println(error!.localizedDescription)
      return
    }
    
    //var str = "Hello, world, world"
    //println(str.rangesOfString("world").count) // .count=2
    
    audioPlayer!.numberOfLoops = -1 // loop forever
    
  }
  
  func getPickedMusicUrl() -> NSURL? {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let url = defaults.URLForKey(kPickedMusicUrl) {
      return url
    }
    return nil
  }
  
  func getPickedMusicTitle() -> String? {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let title: String = defaults.objectForKey(kPickedMusicTitle) as? String {
      return title
    }
    return nil
  }
  
  func setPickedMusicUrl(url: NSURL, title: String) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setURL(url, forKey: kPickedMusicUrl)
    defaults.setObject(title, forKey: kPickedMusicTitle)
  }
  
  
//  func toggleBars() {
//    var toolbarDistance: CGFloat = 44
//    
//    if isBarHide {
//      toolbarDistance *= -1
//    }
//    
//    UIView .animateWithDuration(0.3, animations: { () -> Void in
//      var toolbarCenter: CGPoint = self.toolbar.center
//      toolbarCenter.y = toolbarCenter.y + toolbarDistance
//      self.toolbar.center = toolbarCenter
//    })
//    
//    isBarHide = isBarHide ? false : true
//    
//    println("Bar is hide = \(isBarHide)")
//    
//  }

  
  func playPause() {
    
    if isPlaying {
      
      audioPlayer!.pause()
      isPlaying = false
      toolbar.items = playItems
      activeAudioSession(false)

    } else {
      
      audioPlayer!.play()
      isPlaying = true
      toolbar.items = pauseItems

      activeAudioSession(true)
      
      println("audioPlayer!.url=\(audioPlayer!.url)")
      
    }
  }
  
  func playURL(audioFileURL: NSURL) {
    
    NSLog("playURL(audioFileURL: NSURL)=\(audioFileURL)")
    
    self.songTitle.title = self.getPickedMusicTitle() as String!
    
    if isPlaying {
      playPause() // Pause the previous audio player
    }
    
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
    
    if error != nil {
      // Todo: show a alert on screen
      NSLog(error!.localizedDescription)
      return
    }
    
    audioPlayer!.numberOfLoops = -1 // loop forever
    audioPlayer!.meteringEnabled = true
    
    playPause() // Play
    
  }
  
  
  func pickSong() {
    //let picker: MPMediaPickerController = MPMediaPickerController(mediaTypes: .Music)
    let picker = MPMediaPickerController(mediaTypes: MPMediaType.AnyAudio)
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
    let title = item.valueForProperty(MPMediaItemPropertyTitle) as String
    
    setPickedMusicUrl(url, title: title)
    
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

