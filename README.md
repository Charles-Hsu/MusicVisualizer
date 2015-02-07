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

# Reference

- [How To Make a Music Visualizer in iOS](http://www.raywenderlich.com/36475/how-to-make-a-music-visualizer-in-ios)
