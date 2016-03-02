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
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var m_Favorite: UIImageView!
    @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    m_ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    m_ActivityIndicator.hidesWhenStopped = true
    
    m_View.cornerRadius = 5
    
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
    
    //print("Cell home frame: \(m_View.frame.size)")
    //commentLabel.hidden = true
  }
  
  var m_Story: Story?
  {
    didSet
    {
      m_ActivityIndicator.stopAnimating()
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
