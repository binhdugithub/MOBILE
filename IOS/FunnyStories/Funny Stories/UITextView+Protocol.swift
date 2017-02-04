//
//  UITextView+Font.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 1/6/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

extension UITextView
{
  func SetFont (_ p_font: UIFont) -> Void
  {
    let l_content = NSMutableAttributedString(attributedString: self.attributedText)
    let l_attributeFont = [NSFontAttributeName: p_font]
    l_content.addAttributes(l_attributeFont, range: NSRange(location: 0,length: l_content.length))
    
    self.attributedText = l_content

  }
}
