# MusicVisualizer

```swift
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
```


```swift
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
```

Change MPVolumeView's MPVolumeSlider's value by Pan 

```swift
@IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
  
  let translation = recognizer.translationInView(self.view)
  
  translation.x // CGFloat
  mpVolumeView.frame.width // CGFloat
  
  let dx = (translation.x-lastTranslationX)
  let volumeChanged = Float(dx / mpVolumeView.frame.width)

  currentDeviceVolume = currentDeviceVolume + Float(volumeChanged)

  if currentDeviceVolume > 1 {
    currentDeviceVolume = 1
  } else if currentDeviceVolume < 0 {
    currentDeviceVolume = 0
  }
  
  mpVolumeSilder!.value = currentDeviceVolume
  
  if recognizer.state == .Changed {
    lastTranslationX = translation.x
  }
  
  if recognizer.state == .Ended || recognizer.state == .Began {
    lastTranslationX = 0
    self.showVolumeSliderView()
  }
  
}
```
Find the MPVolumeSlider, get current device's volume

```swift
for view in mpVolumeView.subviews {
  let uiview: UIView = view as UIView
  println("\(uiview.description)")
  if uiview.description.rangesOfString("MPVolumeSlider").first != nil {
    mpVolumeSilder = (uiview as UISlider)
    currentDeviceVolume = mpVolumeSilder!.value
    return
  }
}
```
![](http://i.imgur.com/Eez23oS.jpg)

# Reference

- [How To Make a Music Visualizer in iOS](http://www.raywenderlich.com/36475/how-to-make-a-music-visualizer-in-ios)
- [An iOS 8 Swift Gesture Recognition Tutorial](http://www.techotopia.com/index.php/An_iOS_8_Swift_Gesture_Recognition_Tutorial)
- [Using UIGestureRecognizer with Swift Tutorial](http://www.raywenderlich.com/76020/using-uigesturerecognizer-with-swift-tutorial)
- [NSUserDefaults — A Swift Introduction](http://www.codingexplorer.com/nsuserdefaults-a-swift-introduction/)
- [A selection of algorithms that work with Strings](http://sketchytech.blogspot.tw/2014/08/swift-pure-swift-method-for-returning.html)
- [The simplest way to resize an UIImage?](http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage)
- [Detecting Pan Gesture End](http://stackoverflow.com/questions/6467638/detecting-pan-gesture-end)