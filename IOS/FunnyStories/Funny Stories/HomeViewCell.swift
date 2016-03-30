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
    captionLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
   
    m_View.backgroundColor = FSDesign.ShareInstance.COLOR_CELL_BG
    imageView.backgroundColor = UIColor.whiteColor()
  }
  
  var m_Story: Story?
  {
    didSet
    {
      //imageView.backgroundColor = UIColor.whiteColor()
      m_ActivityIndicator.stopAnimating()
      if let l_Story = m_Story
      {
        captionLabel.text = l_Story.m_title
        captionLabel.numberOfLines = 2

        if let l_image = l_Story.m_image
        {
          imageView.image = UIImage(data: l_image)
          //m_ActivityIndicator.stopAnimating()
        }
        else
        {
          imageView.image = UIImage(named: "story_default")
          let l_imageURL = m_Story?.m_imageurl
          let l_id = m_Story?.m_id

          Alamofire.request(.GET, l_imageURL!).validate().response(){
            (_,_,imgData, p_error) in
            
           if p_error == nil
           {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
            {
                if imgData?.length > 0
                {
                  if self.m_Story!.m_id == l_id
                  {
                    if self.m_Story!.m_image == nil
                    {
                      self.m_Story!.m_image = imgData

                      dispatch_async(dispatch_get_main_queue())
                      {
                          self.imageView.image = UIImage(data: self.m_Story!.m_image!)
                      }
                      
                    }
                  }
                  else
                  {
                    print("***********Doi vao day: current id: \(self.m_Story!.m_id) and old id: \(l_id)")
                    for l_story in FSCore.ShareInstance.m_ArrayStory
                    {
                      if l_story.m_id == l_id
                      {
                        if l_story.m_image == nil
                        {
                          l_story.m_image = imgData
                          
                        }
                        
                        break
                      }
                    }
                    
                  }
                  
                }
            }

           }
           else
           {
              print("Load image fail: \(self.m_Story?.m_imageurl)")
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

class HomeViewLoadingCell: UICollectionReusableView
{
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
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

