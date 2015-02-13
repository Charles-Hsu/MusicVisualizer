//
//  String.swift
//  MusicVisualizer
//
//  Created by Charles Hsu on 2/8/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import Foundation

extension String {
  func rangesOfString(findStr:String) -> [Range<String.Index>] {
    var arr = [Range<String.Index>]()
    var startInd = self.startIndex
    // check first that the first character of search string exists
    if contains(self, first(findStr)!) {
      // if so set this as the place to start searching
      startInd = find(self,first(findStr)!)!
    }
    else {
      // if not return empty array
      return arr
    }
    var i = distance(self.startIndex, startInd)
    while i<=countElements(self)-countElements(findStr) {
      if self[advance(self.startIndex, i)..<advance(self.startIndex, i+countElements(findStr))] == findStr {
        arr.append(Range(start:advance(self.startIndex, i),end:advance(self.startIndex, i+countElements(findStr))))
        i = i+countElements(findStr)
      }
      else {
        i++
      }
    }
    return arr
  }
}
// try further optimisation by jumping to next index of first search character after every find