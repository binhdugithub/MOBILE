//
//  NSTextAttachment+Protocol.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/14/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Alamofire


extension NSTextAttachment
{
  func GetImageFromStory(p_story: Story)
  {
    if p_story.m_imageurl == "" && p_story.m_image == nil
    {
      self.image = UIImage(named: "story_default")
    }
    
    Alamofire.request(.GET, p_story.m_imageurl!).validate().response(){
      (_,_,imgData, p_error) in
      
      if p_error == nil
      {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
          {
            if imgData?.length > 0
            {
              if (p_story.m_image == nil)
              {
                p_story.m_image = imgData
                self.image = UIImage(data: p_story.m_image!)
              }
              
            }
        }
        
      }
      else
      {
        print("Load image fail: \(p_story.m_imageurl)")
      }
      
      
    }//end Alamofire
    
    
    return
  }
  

}
