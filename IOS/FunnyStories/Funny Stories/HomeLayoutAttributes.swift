//
//  PinterestLayoutAttributes.swift
//  Pinterest
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class HomeLayoutAttributes: UICollectionViewLayoutAttributes
{

  // 1
  var photoHeight: CGFloat = 0.0
  
  // 2
  override func copyWithZone(zone: NSZone) -> AnyObject
  {
    let copy = super.copyWithZone(zone) as! HomeLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  // 3
  override func isEqual(object: AnyObject?) -> Bool
  {
    if let attributes = object as? HomeLayoutAttributes
    {
      if( attributes.photoHeight == photoHeight  )
      {
        return super.isEqual(object)
      }
    }
    
    
    return false
  }
  
}
