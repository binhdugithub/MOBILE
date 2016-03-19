//
//  UIButton+Protocol.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/10/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIButton
{
  func meSetImage(p_link: String)
  {
    if p_link == ""
    {
      return
    }
    
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
                  UIGraphicsBeginImageContext(self.frame.size)
                  UIImage(data: imgData!)!.drawInRect(self.bounds)
                  let l_image = UIGraphicsGetImageFromCurrentImageContext()
                  UIGraphicsEndImageContext()
                  
                  //self.setImage(l_image, forState: .Normal)

                  self.backgroundColor = UIColor(patternImage: l_image)
                }
        
            }
        }
        
      }
      else
      {
        print("Load image fail: \(p_link)")
      }
      
      
    }//end Alamofire
    
  }

}
