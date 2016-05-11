//
//  BHAlbumPhotoCellCollectionViewCell.swift
//  MyCollectionLayout
//
//  Created by Nguyen The Binh on 4/6/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit
import Alamofire


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
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 1)
        self.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
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
        
        //name 
        var l_name_frm = CGRectMake(0, 0, 0, 0)
        l_name_frm.size.width = self.bounds.width - 10
        l_name_frm.size.height = self.bounds.height - l_space - m_imgview_photo.frame.size.height
        l_name_frm.origin.x = 5
        l_name_frm.origin.y = m_imgview_photo.frame.origin.y + m_imgview_photo.frame.size.height
        m_lbl_name = UILabel(frame: l_name_frm)
        m_lbl_name.textColor = UIColor.whiteColor()
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
                
                Alamofire.request(.GET, l_imageURL).validate().response(){
                    (_,_,imgData, p_error) in
                    
                    if p_error == nil
                    {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
                        {
                            if imgData?.length > 0
                            {
                                
                                dispatch_async(dispatch_get_main_queue())
                                {
                                    self.m_imgview_photo.image = UIImage(data: imgData!)
                                }
                        
                            }
                        }
                        
                    }
                }//end Alamofire
                //m_ActivityIndicator.startAnimating()
            }

        }//end didset
    }//end SetApp
    
}
