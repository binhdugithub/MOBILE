//
//  BHAlbumPhotoCellCollectionViewCell.swift
//  MyCollectionLayout
//
//  Created by Nguyen The Binh on 4/6/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell
{
    var m_imgview_photo: UIImageView!
    var m_view_congratulation: UIView!
    var m_imgview_lock: UIImageView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.SetupView()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.SetupView()
    }
    
    func SetupView() -> Void
    {
        self.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        self.layer.borderColor = UIColor.whiteColor().CGColor;
        self.layer.borderWidth = 2.0;
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowRadius = 3.0;
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        self.layer.shadowOpacity = 0.5;
        // make sure we rasterize nicely for retina
        self.layer.rasterizationScale = UIScreen.mainScreen().scale;
        self.layer.shouldRasterize = true;
        
        self.m_imgview_photo = UIImageView(frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height))
        self.m_imgview_photo.contentMode = .ScaleAspectFill
        self.m_imgview_photo.clipsToBounds = true;
        
        //viw congratulation
        self.m_view_congratulation = UIView(frame: self.m_imgview_photo.frame)
        self.m_view_congratulation.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        
        //imgv lock
        var l_frm = CGRectMake(0,0 , 0, 0)
        l_frm.size.width = 1.0/4 * self.contentView.frame.size.width
        l_frm.size.height = l_frm.size.width
        l_frm.origin.x = self.contentView.frame.size.width - l_frm.size.width
        l_frm.origin.y = self.contentView.frame.size.height - l_frm.size.height
        m_imgview_lock = UIImageView(frame: l_frm)
        
        
        self.contentView.addSubview(self.m_imgview_photo)
        self.contentView.addSubview(self.m_imgview_lock)
        //self.contentView.addSubview(self.m_view_congratulation)
    }//end SetupView
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        //self.m_imgView.image = nil
    }
    
    
    func SetPhoto(p_photo:  Photo)
    {
        let l_img = UIImage(named: p_photo.m_name)
        self.m_imgview_photo.image = l_img
        
        if p_photo.m_completed == PHOTO_STATUS.PHOTO_LOCK
        {
            self.m_imgview_lock.image = UIImage(named: "img_lock")
            self.m_imgview_photo.alpha = 0.5
        }
        else if p_photo.m_completed == PHOTO_STATUS.PHOTO_NOT_COMPLETED
        {
            self.m_imgview_photo.alpha = 1
            self.m_imgview_lock.image = nil
        }
        else
        {
            self.m_imgview_photo.alpha = 1
            self.m_imgview_lock.image = UIImage(named: "img_favorite")
        }
    }

}
