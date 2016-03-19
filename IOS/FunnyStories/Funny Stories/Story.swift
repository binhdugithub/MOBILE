//
//  Photo.swift
//  RWDevCon
//
//  Created by Mic Pringle on 04/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Alamofire

class Story
{
  //var m_row: NSIndexPath?
  var m_id: Int?
  var m_title: String?
  var m_content: String?
  var m_imageurl: String?
  var m_audiourl: String?
  var m_image: NSData?
  var m_audio: NSData?
  var m_liked: Bool? = false
  
  init()
  {
    //print("Init Story")
  }
  
  func Copy() -> Story
  {
    let l_Story = Story()
    l_Story.m_id = self.m_id
    l_Story.m_title = self.m_title
    l_Story.m_content = self.m_content
    l_Story.m_imageurl = self.m_imageurl
    l_Story.m_audiourl = self.m_audiourl
    l_Story.m_image = self.m_image
    l_Story.m_audio = self.m_audio
    l_Story.m_liked  = self.m_liked
    
    return l_Story
  }
  
  init(p_id: Int?,p_title: String?, p_content: String?, p_imageurl: String?, p_audiourl: String?, p_liked: Bool? = false)
  {
    self.m_id = p_id
    self.m_title = p_title
    self.m_content = p_content
    self.m_imageurl = p_imageurl
    self.m_audiourl = p_audiourl
    self.m_liked = p_liked
  }
  
  init(p_id: Int?,p_title: String?, p_content: String?,p_imageurl: String?, p_image: NSData?, p_audiourl: String?, p_audio: NSData?, p_like: Bool?)
  {
    self.m_id = p_id
    self.m_title = p_title
    self.m_content = p_content
    self.m_imageurl = p_imageurl
    self.m_image = p_image
    self.m_audiourl = p_audiourl
    self.m_audio = p_audio
    self.m_liked = p_like
  }
  
  func GetImage() -> UIImage?
  {
    if self.m_imageurl == "" && self.m_image == nil
    {
      return UIImage(named: "story_default")
    }
    
    let l_img: UIImage! = UIImage(named: "story_default")
    
    Alamofire.request(.GET, self.m_imageurl!).validate().response(){
      (_,_,imgData, p_error) in
      
      if p_error == nil
      {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
          {
            if imgData?.length > 0
            {
              if (self.m_image == nil)
              {
                self.m_image = imgData
              }
              
            }
        }
        
      }
      else
      {
        print("Load image fail: \(self.m_imageurl)")
      }
      
      
    }//end Alamofire
    
    if (self.m_image == nil)
    {
      return l_img
    }
    else
    {
      return UIImage(data: self.m_image!)
    }

  }
  
  
  func heightForComment(font: UIFont, width: CGFloat) -> CGFloat
  {
    let l_HintContent = self.m_content!.substringToIndex(self.m_content!.startIndex.advancedBy(50))
    let rect = NSString(string: l_HintContent).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return ceil(rect.height)
  }
  
  func heightForTitle(font: UIFont, width: CGFloat) -> CGFloat
  {
    let l_HintContent = self.m_content!.substringToIndex(self.m_content!.startIndex.advancedBy(5))
    let rect = NSString(string: l_HintContent).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return ceil(rect.height)
  }

  
}


class App
{
  var m_name: String
  var m_imageurl: String
  var m_link: String
  
  init()
  {
    m_name = ""
    m_imageurl = ""
    m_link = ""
  }
  
  init(p_name: String, p_imageurl: String, p_link: String)
  {
    m_name = p_name
    m_imageurl = p_imageurl
    m_link = p_link
  }
  
}
