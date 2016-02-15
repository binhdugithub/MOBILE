//
//  FavoriteViewCell.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 1/7/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell
{
  @IBOutlet weak var m_View: RoundedCornersView!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var m_Favorite: UIImageView!
  
  @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    m_ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    m_ActivityIndicator.hidesWhenStopped = true
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
    
  }
  
  var m_Story: Story?
    {
    didSet {
      if let l_Story = m_Story
      {
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
        
        
        if m_Story?.m_liked == true
        {
            m_Favorite.image = UIImage(named: "favorite_yes")
        }
        else
        {
            m_Favorite.image = UIImage(named: "favorite_no")
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
