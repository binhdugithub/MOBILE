//
//  UICollectionView+Protocol.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 1/8/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

extension UICollectionView
{
  
  func Scroll2Index(p_index: NSIndexPath?) -> Void
  {
    
    if let l_index = p_index
    {
      self.scrollToItemAtIndexPath(
        l_index,
        atScrollPosition: .CenteredVertically,
        animated: true)
      
    }
    
  }
}