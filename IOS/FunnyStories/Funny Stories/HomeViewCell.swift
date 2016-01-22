//
//  AnnotatedPhotoCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell
{
  
  @IBOutlet weak var m_View: RoundedCornersView!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet private weak var captionLabel: UILabel!
  @IBOutlet private weak var commentLabel: UILabel!
  
  @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    m_ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    m_ActivityIndicator.hidesWhenStopped = true
    
    m_View.cornerRadius = 5
    captionLabel.textColor = FSDesign.ShareInstance.COLOR_COLLECTION_TEXT
    commentLabel.textColor = FSDesign.ShareInstance.COLOR_COLLECTION_TEXT
    captionLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    commentLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
  }
  
  var m_Story: Story?
  {
    didSet
    {
      if let l_Story = m_Story
      {
        captionLabel.text = l_Story.m_title
        captionLabel.numberOfLines = 1

        commentLabel.text = l_Story.m_content
        commentLabel.numberOfLines = 2
        //commentLabel.
        if let l_image = l_Story.m_image
        {
          imageView.image = UIImage(data: l_image)?.decompressedImage
          m_ActivityIndicator.stopAnimating()
        }
        else
        {
          imageView.image = UIImage(named: "story_default")
          m_ActivityIndicator.startAnimating()
        }
        
      }
    }
  }
  
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes)
  {
    super.applyLayoutAttributes(layoutAttributes)
    if let attributes = layoutAttributes as? LayoutAttributes
    {
      imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
  }
  
  
}
