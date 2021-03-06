//
//  BHAlbumPhotoCellCollectionViewCell.swift
//  MyCollectionLayout
//
//  Created by Nguyen The Binh on 4/6/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit


class MoreCell: UICollectionViewCell
{
    var m_imgview_photo: UIImageView!
    var m_lbl_name: UILabel!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.SetupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupView() -> Void
    {
        self.backgroundColor = ViewDesign.ShareInstance.COLOR_CELL_BG
        self.layer.borderColor = ViewDesign.ShareInstance.COLOR_IMGV_BORDER.CGColor
        self.layer.borderWidth = 1.0;
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowRadius = 3.0;
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        self.layer.shadowOpacity = 0.5;
        // make sure we rasterize nicely for retina
        self.layer.rasterizationScale = UIScreen.mainScreen().scale;
        self.layer.shouldRasterize = true;
        
        let l_space = 1.0/8 * self.bounds.width
        self.m_imgview_photo = UIImageView(frame: CGRectMake(l_space, l_space, self.bounds.width - 2 * l_space, self.bounds.width - 2 * l_space))
        self.m_imgview_photo.contentMode = .ScaleAspectFill
        self.m_imgview_photo.clipsToBounds = true;
        self.m_imgview_photo.layer.borderColor = ViewDesign.ShareInstance.COLOR_IMGV_BORDER.CGColor
        self.m_imgview_photo.layer.borderWidth = 1.0;
        self.m_imgview_photo.layer.shadowColor = UIColor.blackColor().CGColor;
        self.m_imgview_photo.layer.shadowRadius = 3.0;
        self.m_imgview_photo.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        self.m_imgview_photo.layer.shadowOpacity = 0.5;
        
        //name 
        var l_name_frm = CGRectMake(0, 0, 0, 0)
        l_name_frm.size.width = self.bounds.width - 10
        l_name_frm.size.height = self.bounds.height - l_space - m_imgview_photo.frame.size.height
        l_name_frm.origin.x = 5
        l_name_frm.origin.y = m_imgview_photo.frame.origin.y + m_imgview_photo.frame.size.height
        m_lbl_name = UILabel(frame: l_name_frm)
        m_lbl_name.textColor = ViewDesign.ShareInstance.COLOR_TEXT_COIN
        m_lbl_name.textAlignment = .Center
        m_lbl_name.font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN)!
        m_lbl_name.numberOfLines = 2
        //add
        self.contentView.addSubview(self.m_imgview_photo)
        self.contentView.addSubview(self.m_lbl_name)
        
    }//end SetupView
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        //self.m_imgView.image = nil
    }
    
    
    func SetApp(p_app:  App!)
    {

        if let l_app = p_app
        {
            m_lbl_name.text = p_app.m_name
            
            if let l_image = l_app.m_imgdata
            {
                m_imgview_photo.image = UIImage(data: l_image)
            }
            else
            {
                let l_imageURL = l_app.m_imgurl
                
                let url = NSURL(string:l_imageURL)
                let task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(url!)
                { (data, response, error) -> Void in
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
                    {
                        
                        if error == nil
                        {
                            if data != nil
                            {
                                dispatch_async(dispatch_get_main_queue())
                                {
                                    self.m_imgview_photo.image = UIImage(data: data!)
                                }
                            }
                        }
                        else
                        {
                            print("Error:\(error!.localizedDescription)");
                        }
                        
                        
                    }
                    
                    
                }
                // Start the task.
                task.resume()

            }

        }//end didset
    }//end SetApp
    
}
