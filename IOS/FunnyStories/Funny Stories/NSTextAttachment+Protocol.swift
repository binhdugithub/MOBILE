//
//  NSTextAttachment+Protocol.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/14/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit



extension NSTextAttachment
{
  func GetImageFromStory(_ p_story: Story)
  {
    if p_story.m_imageurl == ""
    {
      self.image = UIImage(named: "story_default")
    }
    else
    {
        self.image = UIImage(contentsOfFile: p_story.m_imageurl!)
    }
 
    
    return
  }
  

}
