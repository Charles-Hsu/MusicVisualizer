//
//  MPMediaItemProperty.swift
//  MusicVisualizer
//
//  Created by Charles Hsu on 2/14/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit
import MediaPlayer

struct itemProperties {
  var url: NSURL
  var title: String
  var artist: String?
  var artwork: MPMediaItemArtwork?
  var duration: NSTimeInterval
  
  var albumArtist: String?
  var albumTitle: String?
  var genre: String?
  var composer: String?
  var albumTrackNumber: NSInteger
  var albumTrackCount: NSInteger
  var discNumber: NSInteger
  var discCount: NSInteger
  var lyrics: String?
  var isCompilation: Bool
  var releaseDate: NSDate?
  var beatsPerMinute: NSInteger
  var comments: String?
  var isCloudItem: Bool
}
