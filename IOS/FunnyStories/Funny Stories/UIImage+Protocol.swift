//
//  UIImage+Decompression.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Alamofire

extension UIImage
{
  
  var decompressedImage: UIImage {
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    drawAtPoint(CGPointZero)
    let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return decompressedImage
  }
  
  
  func GetImageFromURL(p_link: String) -> UIImage?
  {
    if p_link == ""
    {
      return nil
    }
    
    var l_img: UIImage! = nil
    
    Alamofire.request(.GET, p_link).validate().response(){
      (_,_,imgData, p_error) in
      
      if p_error == nil
      {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
          {
            if imgData?.length > 0
            {
              
              dispatch_async(dispatch_get_main_queue())
              {
                l_img = UIImage(data: imgData!)!
              }
              
            }
        }
        
      }
      else
      {
        print("Load image fail: \(p_link)")
      }
      
      
    }//end Alamofire
    
    
    return l_img
  }
  
    
}
