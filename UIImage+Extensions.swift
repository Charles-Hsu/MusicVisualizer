//
//  UIImage+Extensions.swift
//  MusicVisualizer
//
//  Created by Charles Hsu on 2/10/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit

public extension UIImage {
  
  public func scaleToSize(size: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    
    let context: CGContextRef = UIGraphicsGetCurrentContext()
    CGContextTranslateCTM(context, 0.0, size.height)
    CGContextScaleCTM(context, 1.0, -1.0)
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, size.width, size.height), self.CGImage)
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return scaledImage
  }
  
  
}