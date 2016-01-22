//
//  Photo.swift
//  RWDevCon
//
//  Created by Mic Pringle on 04/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Story
{
  var m_row: NSIndexPath?
  var m_id: Int?
  var m_title: String?
  var m_content: String?
  var m_imageurl: String?
  var m_audiourl: String?
  var m_image: NSData?
  var m_audio: NSData?
  var m_liked: Bool?
  
  init()
  {
    print("Init Story")
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
    l_Story.m_row   = self.m_row
    l_Story.m_liked  = self.m_liked
    
    return l_Story
  }
  
  init(p_id: Int?,p_title: String?, p_content: String?, p_image: NSData?, p_liked: Bool?)
  {
    self.m_id = p_id
    self.m_title = p_title
    self.m_content = p_content
    self.m_image = p_image
    self.m_liked = p_liked
  }
  
  func Discription() -> Void
  {
    print("******************")
    print("Id:\(self.m_id)")
    print("Title:\(self.m_title)")
    print("Row:\(self.m_row?.row)")
    print("******************")
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
