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
  
  init()
  {
    
  }
  
  init(p_id: Int?,p_title: String?, p_content: String?, p_image: NSData?)
  {
    self.m_id = p_id
    self.m_title = p_title
    self.m_content = p_content
    self.m_image = p_image
  }
  
  
  convenience init(dictionary: NSDictionary)
  {
    let id = dictionary["id"] as? Int
    let caption = dictionary["caption"] as? String
    let content = dictionary["content"] as? String
    let photo = dictionary["photo"] as? NSData
    //let image = UIImage(data: photo!)?.decompressedImage
    self.init(p_id: id,p_title: caption!, p_content: content!, p_image: photo!)
  }
  
  
  func heightForComment(font: UIFont, width: CGFloat) -> CGFloat
  {
    let l_HintContent = self.m_content!.substringToIndex(self.m_content!.startIndex.advancedBy(50))
    let rect = NSString(string: l_HintContent).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return ceil(rect.height)
  }
  
}
