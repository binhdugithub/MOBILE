//
//  AnnotatedPhotoCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewCell: UICollectionViewCell
{
  
  @IBOutlet weak var m_View: RoundedCornersView!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet private weak var captionLabel: UILabel!
  //@IBOutlet private weak var commentLabel: UILabel!
  
  @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    m_ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    m_ActivityIndicator.hidesWhenStopped = true
    
    m_View.cornerRadius = 5
    captionLabel.textColor = FSDesign.ShareInstance.COLOR_COLLECTION_TEXT
    //commentLabel.textColor = FSDesign.ShareInstance.COLOR_COLLECTION_TEXT
    captionLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
   // commentLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
    
    //print("width: \(m_View.frame.size)")
    //commentLabel.hidden = true
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

        if let l_image = l_Story.m_image
        {
          imageView.image = UIImage(data: l_image)?.decompressedImage
          //m_ActivityIndicator.stopAnimating()
        }
        else
        {
          imageView.image = UIImage(named: "story_default")
          let l_imageURL = m_Story?.m_imageurl
          
          Alamofire.request(.GET, l_imageURL!).validate().response(){
            (_,_,imgData, p_error) in
            
           if p_error == nil
           {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
              {
                if imgData?.length > 0
                {
                  self.m_Story!.m_image = imgData
                  dispatch_async(dispatch_get_main_queue())
                  {
                      self.imageView.image = UIImage(data: imgData!)
                  }
                }
            }
            
           }
            
            
          }//end Alamofire
          //m_ActivityIndicator.startAnimating()
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
