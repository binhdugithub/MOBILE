//
//  UIImageView + Protocol.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/21/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

extension UIView
{
    func Rotation360Degree(p_time: Double) -> Void
    {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = p_time
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
    
    func Shake() -> Void
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.addAnimation(animation, forKey: "shake")
    }
    
    
    func pulseToSize(p_scale: CGFloat, p_duration: NSTimeInterval, p_repeat: Bool)
    {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")

        pulseAnimation.duration = p_duration;
        pulseAnimation.toValue = p_scale
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = p_repeat ? Float(CGFloat.max) : 0

        self.layer.addAnimation(pulseAnimation, forKey:"pulse")
    }
    
}

extension UIImage
{
    //resize image
    func ResizeImage(targetSize: CGSize) -> UIImage
    {
        let size = self.size
        let widthRatio  = targetSize.width  / self.size.width
        
        if widthRatio <= 1
        {
            return self
        }
        //let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        let newSize: CGSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
//        
//        var newSize: CGSize
//        if(widthRatio > heightRatio)
//        {
//            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
//        }
//        else
//        {
//            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
//        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}