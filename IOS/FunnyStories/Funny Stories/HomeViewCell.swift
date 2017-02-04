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
  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet fileprivate weak var captionLabel: UILabel!
  //@IBOutlet private weak var commentLabel: UILabel!
  
  @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    m_ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
    m_ActivityIndicator.hidesWhenStopped = true
    
    m_View.cornerRadius = 5
    captionLabel.textColor = FSDesign.ShareInstance.COLOR_COLLECTION_TEXT
    captionLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
   
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
    imageView.backgroundColor = UIColor.white
  }
  
  var m_Story: Story?
  {
    didSet
    {
      m_ActivityIndicator.stopAnimating()
      if let l_Story = m_Story
      {
        captionLabel.text = l_Story.m_title
        captionLabel.numberOfLines = 2
        imageView.image = UIImage(contentsOfFile: l_Story.m_imageurl!)
      }
    }
  }
  
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
  {
    super.apply(layoutAttributes)
    if let attributes = layoutAttributes as? LayoutAttributes
    {
      imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
  }
  
}

class HomeViewLoadingCell: UICollectionReusableView
{
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    
    spinner.startAnimating()
    spinner.center = self.center
    addSubview(spinner)
  }
}

