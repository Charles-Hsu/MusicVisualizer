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
  
  let kPersistentID = "MusicPersistentID"
  
  var pickedItemProperty: itemProperties?
  
  //var volumeSlider: UISlider?
  
  @IBOutlet weak var songTitle: UINavigationItem!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var volumeIcon: UIBarButtonItem!
  
  var artworkImageView: UIImageView?
  
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
  

  func setPickedItemProperty(item: MPMediaItem) {
    
    NSLog("setCurrentItemProperties")
    
//    println("url=\(item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL)")
//    println("title=\(item.valueForProperty(MPMediaItemPropertyTitle) as String)")
//    println("Artist=\(item.valueForProperty(MPMediaItemPropertyArtist) as? String)")
//    println("Artwork=\(item.valueForProperty(MPMediaItemPropertyArtwork) as? MPMediaItemArtwork)")
//    println("duration=\(item.valueForProperty(MPMediaItemPropertyPlaybackDuration) as NSTimeInterval)")
//    println("albumArtist=\(item.valueForProperty(MPMediaItemPropertyAlbumArtist) as? String)")
//    println("albumTitle=\(item.valueForProperty(MPMediaItemPropertyAlbumTitle) as? String)")
//    println("genre=\(item.valueForProperty(MPMediaItemPropertyGenre) as? String)")
//    println("composer=\(item.valueForProperty(MPMediaItemPropertyComposer) as? String)")
//    println("albumTrackNumber=\(item.valueForProperty(MPMediaItemPropertyAlbumTrackNumber))")
//    println("albumTrackCount=\(item.valueForProperty(MPMediaItemPropertyAlbumTrackCount))")
//    println("discNumber=\(item.valueForProperty(MPMediaItemPropertyDiscNumber))")
//    println("discCount=\(item.valueForProperty(MPMediaItemPropertyDiscCount))")
//    println("lyrics=\(item.valueForProperty(MPMediaItemPropertyLyrics) as? String)")
//    println("isCompilation=\(item.valueForProperty(MPMediaItemPropertyIsCompilation) as Bool)")
//    println("releaseData=\(item.valueForProperty(MPMediaItemPropertyReleaseDate) as? NSDate)")
//    println("beatsPerMinute=\(item.valueForProperty(MPMediaItemPropertyBeatsPerMinute))")
//    println("comments=\(item.valueForProperty(MPMediaItemPropertyComments) as? String)")
//    println("isCloudItem=\(item.valueForProperty(MPMediaItemPropertyIsCloudItem) as Bool)")
//
//    println("----")
    
    pickedItemProperty = itemProperties(
      url: item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL,
      title: item.valueForProperty(MPMediaItemPropertyTitle) as String,
      artist: item.valueForProperty(MPMediaItemPropertyArtist) as? String,
      artwork: item.valueForProperty(MPMediaItemPropertyArtwork) as? MPMediaItemArtwork,
      duration: item.valueForProperty(MPMediaItemPropertyPlaybackDuration) as NSTimeInterval,
      albumArtist: item.valueForProperty(MPMediaItemPropertyAlbumArtist) as? String,
      albumTitle: item.valueForProperty(MPMediaItemPropertyAlbumTitle) as? String,
      genre: item.valueForProperty(MPMediaItemPropertyGenre) as? String,
      composer: item.valueForProperty(MPMediaItemPropertyComposer) as? String,
      albumTrackNumber: item.valueForProperty(MPMediaItemPropertyAlbumTrackNumber) as NSInteger,
      albumTrackCount: item.valueForProperty(MPMediaItemPropertyAlbumTrackCount) as NSInteger,
      discNumber: item.valueForProperty(MPMediaItemPropertyDiscNumber) as NSInteger,
      discCount: item.valueForProperty(MPMediaItemPropertyDiscCount) as NSInteger,
      lyrics: item.valueForProperty(MPMediaItemPropertyLyrics) as? String,
      isCompilation: item.valueForProperty(MPMediaItemPropertyIsCompilation) as Bool,
      releaseDate: item.valueForProperty(MPMediaItemPropertyReleaseDate) as? NSDate,
      beatsPerMinute: item.valueForProperty(MPMediaItemPropertyBeatsPerMinute) as NSInteger,
      comments: item.valueForProperty(MPMediaItemPropertyComments) as? String,
      isCloudItem: item.valueForProperty(MPMediaItemPropertyIsCloudItem) as Bool
    )
    
    println("----")

    println("url=\(pickedItemProperty!.url)")
    println("title=\(pickedItemProperty!.title)")
    println("Artist=\(pickedItemProperty!.artist)")
    println("Artwork=\(pickedItemProperty!.artwork)")
    println("duration=\(pickedItemProperty!.duration)")
    println("albumArtist=\(pickedItemProperty!.albumArtist)")
    println("albumTitle=\(pickedItemProperty!.albumTitle)")
    println("genre=\(pickedItemProperty!.genre)")
    println("composer=\(pickedItemProperty!.composer)")
    println("albumTrackNumber=\(pickedItemProperty!.albumTrackNumber)")
    println("albumTrackCount=\(pickedItemProperty!.albumTrackCount)")
    println("discNumber=\(pickedItemProperty!.discNumber)")
    println("discCount=\(pickedItemProperty!.discCount)")
    println("lyrics=\(pickedItemProperty!.lyrics)")
    println("isCompilation=\(pickedItemProperty!.isCompilation)")
    println("releaseData=\(pickedItemProperty!.releaseDate)")
    println("beatsPerMinute=\(pickedItemProperty!.beatsPerMinute)")
    println("comments=\(pickedItemProperty!.comments)")
    println("isCloudItem=\(pickedItemProperty!.isCloudItem)")
    
    println("----")

    
  }
  
  
  func addingConstraintsByPureClassicStyle() {
    var new_view = UIView()
    new_view.backgroundColor = UIColor.redColor()
    view.addSubview(new_view)
    
    //Don't forget this line
    new_view.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    var constX = NSLayoutConstraint(item: new_view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
    view.addConstraint(constX)
    
    var constY = NSLayoutConstraint(item: new_view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
    view.addConstraint(constY)
    
    var constW = NSLayoutConstraint(item: new_view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
    new_view.addConstraint(constW)
    //view.addConstraint(constW) also works
    
    var constH = NSLayoutConstraint(item: new_view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
    new_view.addConstraint(constH)
    //view.addConstraint(constH) also works
  }
  
  
  func addingConstraintsByPureVisualFormatLanguage() {
    
    var new_view = UIView()
    new_view.backgroundColor = UIColor.redColor()
    view.addSubview(new_view)
    
    //Don't forget this line
    new_view.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    let views = ["view": view, "new_view": new_view]
    
    var constH = NSLayoutConstraint.constraintsWithVisualFormat("H:[view]-(<=0)-[new_view(200)]", options: NSLayoutFormatOptions.DirectionRightToLeft, metrics: nil, views: views)
    view.addConstraints(constH)
    //
    //
    // .AlignAllCenterX  -> X
    // .AlignAllCenterY
    // .AlignAllFirstBaseline   -> Top of screen
    // .AlignAllLastBaseline    -> Bottom of screen
    // .AlignAllLeading         -> X
    // .AlignAllLeft            -> X
    // .AlignAllRight           -> X
    // .AlignAllTop             -> Over Top of screen
    // .AlignAllTrailing        -> X
    // .AlignmentMask           -> X
    // .allZeros                -> empty
    
    var constW = NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-(<=0)-[new_view(100)]", options: .AlignAllCenterX, metrics: nil, views: views)
    view.addConstraints(constW)
    
    //var constH1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[new_view]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views)
    //view.addConstraints(constH1)

  }

  
  func testConstraint() {
    
    NSLog("testConstraint()")
    
    println("view.frame=\(view.frame)")
    
    //var new_view = UIImageView()  //UIView()
    artworkImageView = UIImageView()
    
    //var artworkImageView = UIImageView()
    
    artworkImageView!.backgroundColor = UIColor.redColor()
    view.addSubview(artworkImageView!)
    
    //Don't forget this line
    artworkImageView!.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    var constX = NSLayoutConstraint(item: artworkImageView!,
      attribute: NSLayoutAttribute.LeadingMargin, //Leading /*.CenterX*/,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view,
      attribute: NSLayoutAttribute.LeadingMargin,
      multiplier: 1,
      constant: 0)
    //constX.priority = 100
    view.addConstraint(constX)
 
    println("slider.frame.height=\(slider.frame.height)")
    
    var constY = NSLayoutConstraint(item: artworkImageView!,
      attribute: NSLayoutAttribute.CenterY, // Top,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view, //slider,
      attribute: NSLayoutAttribute.CenterY, //BottomMargin,
      multiplier: 1,
      constant: 0)
    //constY.priority = 100
    view.addConstraint(constY)
    
    let margin = 44 + 31 * 2 + 50 + 44 + 44 + 44
    let width = view.frame.height - CGFloat(margin)
    println("view.frame.height=\(view.frame.height)")
    println("width=\(width)")
    
    var constW = NSLayoutConstraint(item: artworkImageView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
    artworkImageView!.addConstraint(constW)
    //view.addConstraint(constW) also works
    
    var constH = NSLayoutConstraint(item: artworkImageView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
    artworkImageView!.addConstraint(constH)
    //view.addConstraint(constH) also works

  }
  
  
  func setupArtworkImageView() {
    //let superview = self.view
    //let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    //button.setTranslatesAutoresizingMaskIntoConstraints(false)
    //button.setTitle("Button", forState: UIControlState.Normal)
    //superview.addSubview(button)
    
    artworkImageView = UIImageView()
    view.addSubview(artworkImageView!)
    
    artworkImageView!.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    var cn = NSLayoutConstraint(item: artworkImageView!,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view,
      attribute: NSLayoutAttribute.CenterX,
      multiplier: 1.0,
      constant: 0.0)
    
    view.addConstraint(cn)

    cn = NSLayoutConstraint(item: artworkImageView!,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view,
      attribute: NSLayoutAttribute.CenterY,
      multiplier: 1.0,
      constant: 0.0)
    
    view.addConstraint(cn)

//    cn = NSLayoutConstraint(item: artworkImageView!,
//      attribute: NSLayoutAttribute.Bottom,
//      relatedBy: NSLayoutRelation.Equal,
//      toItem: view,
//      attribute: NSLayoutAttribute.Bottom,
//      multiplier: 1.0,
//      constant: -20.0)
//    
//    view.addConstraint(cn)
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.bringSubviewToFront(toolbar)
    
    configureBars()
    configureAudioPlayer()
    settingAudioSessionHardware()
    
    setupVolumeView()
    
    //setupArtworkImageView()
    
    testConstraint()
    
    //artworkImageView.removeConstraint(constraint: NSLayoutConstraint.)
    
    
    //println("self.artwork.frame=\(self.artworkImageView.frame)")
    //println("self.view.frame=\(self.view.frame)")
    
    //self.artworkImageView.frame = CGRectMake(0, 0, 150, 150)

    //println("self.artworkImageView.frame=\(self.artworkImageView.frame)")

    
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
      //println("\(uiview.description)")
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
    
    let ofsetHeight = toolbar.frame.height
    
    UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
      var basketTopFrame = self.mpVolumeView.frame
      
      if self.isVolumeSilderHide {
        basketTopFrame.origin.y -= ofsetHeight // basketTopFrame.size.height
      } else {
        basketTopFrame.origin.y += ofsetHeight //basketTopFrame.size.height
      }
      
      self.isVolumeSilderHide = !self.isVolumeSilderHide
      self.mpVolumeView.frame = basketTopFrame
      
      println("self.mpVolumeView.frame=\(self.mpVolumeView.frame)")

    }, completion: { finished in
        //println("Basket doors opened!")
    })

  }


  func configureAudioPlayer() {
    
    var url: NSURL? = nil //getLastPickedMusicUrl()
    var title: String? = nil //getLastPickedMusicTitle()
    
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
  
//  func getLastPickedMusicUrl() -> NSURL? {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    if let url = defaults.URLForKey(kPickedMusicUrl) {
//      return url
//    }
//    return nil
//  }
//  
//  func getLastPickedMusicTitle() -> String? {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    if let title: String = defaults.objectForKey(kPickedMusicTitle) as? String {
//      return title
//    }
//    return nil
//  }
//  
//  func setPickedMusicUrl(url: NSURL, title: String) {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    defaults.setURL(url, forKey: kPickedMusicUrl)
//    defaults.setObject(title, forKey: kPickedMusicTitle)
//  }
  
  func saveMediaItemToUserDefaults(mediaItem: MPMediaItem) {
    
    
    NSLog("setMediaItemToUserDefaults")
    
    
    let key = MPMediaItemPropertyPersistentID
    let persistentID: AnyObject! = mediaItem.valueForProperty(key)
    
    println("set persistentID=\(persistentID)")
    
    let defaults = NSUserDefaults.standardUserDefaults()
    //defaults.setInteger(persistentID as Int, forKey: kPersistentID)
    defaults.setObject(persistentID, forKey: kPersistentID)

  }
  
  func getMediaItemFromUserDefaults() -> MPMediaItem? {
    
    let key = MPMediaItemPropertyPersistentID
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //var song = MPMediaItem()
    
    var persistentID: AnyObject! = defaults.objectForKey(kPersistentID) as AnyObject!
    println("get persistentID=\(persistentID)")
    

    var predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
    var songQuery = MPMediaQuery()
    songQuery.addFilterPredicate(predicate)
    
    println("predicate=\(predicate)")
    println("songQuery.items.count=\(songQuery.items.count)")
    
    if songQuery.items.count > 0 {
      var song: MPMediaItem = songQuery.items[0] as MPMediaItem
      println("songQuery.items[0]=\(songQuery.items[0])")
      //song.valueForProperty(<#property: String!#>)
      
      setPickedItemProperty(song)
      
    }
    
    
    
    /*
    
    var everything = MPMediaQuery.songsQuery()
  
    var itemsFromGenericQuery = everything.items as NSArray
    var songItem = NSMutableArray()
    
    println("itemsFromGenericQuery.count=\(itemsFromGenericQuery.count)")
    
    for song in itemsFromGenericQuery as [MPMediaItem] {
      let songID: AnyObject! = song.valueForProperty(MPMediaItemPropertyPersistentID)
      songItem.addObject(songID)
    }

    */

    if let id = defaults.objectForKey(kPersistentID) as? NSNumber {
      let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
      
      println("predicate.value=\(predicate.value)")
      
      var songsQuery = MPMediaQuery()
      songsQuery.addFilterPredicate(predicate)
      
      println("songsQuery.items.count=\(songsQuery.items.count)")
      
      
      //let item = predicate.valueForKey(predicate.value as String) as MPMediaItem?
      
      //if let _item = item {
      //  println("title=\(_item.valueForProperty(MPMediaItemPropertyTitle))")
      //}
      
      
      
//      MPMediaPropertyPredicate * predicate =
//        [MPMediaPropertyPredicate
//          predicateWithValue:persistentID
//          forProperty:MPMediaItemPropertyPersistentID];
//      return id
    }
    return nil

  }
  
  
  func setPickedMusicPersistentID(value: NSNumber) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(value as Int, forKey: kPersistentID)
  }
  
  func getPickedMusicPersistentID() -> NSNumber? {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let id: NSNumber = defaults.objectForKey(kPersistentID) as? NSNumber {
      return id
    }
    return nil
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
    
    self.songTitle.title = "Default Title" //self.getLastPickedMusicTitle() as String!
    
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
    
    //setPickedMusicUrl(url, title: title)
    saveMediaItemToUserDefaults(item)
    getMediaItemFromUserDefaults()
    
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

