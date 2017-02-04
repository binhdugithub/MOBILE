//
//  PinterestLayoutAttributes.swift
//  Pinterest
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class LayoutAttributes: UICollectionViewLayoutAttributes
{

  // 1
  var photoHeight: CGFloat = 0.0
  
  // 2
  override func copy(with zone: NSZone?) -> Any
  {
    let copy = super.copy(with: zone) as! LayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  // 3
  override func isEqual(_ object: Any?) -> Bool
  {
    if let attributes = object as? LayoutAttributes
    {
      if( attributes.photoHeight == photoHeight  )
      {
        return super.isEqual(object)
      }
    }
    
    return false
  }
  
}
