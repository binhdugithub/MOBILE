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
    var m_imgview_lock: UIImageView!
    var m_btn_coin: UIButton!
    //var m_is_clicked: Bool! = false

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
        self.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        self.layer.borderColor = ViewDesign.ShareInstance.COLOR_IMGV_BORDER.CGColor
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
        
        //imgv lock
        var l_frm = CGRectMake(0,0 , 0, 0)
        l_frm.size.width = 1.0/5 * self.contentView.frame.size.width
        l_frm.size.height = l_frm.size.width
        l_frm.origin.x = self.contentView.frame.size.width - l_frm.size.width
        l_frm.origin.y = self.contentView.frame.size.height - l_frm.size.height
        m_imgview_lock = UIImageView(frame: l_frm)
        
        //btn coin
        var l_btn_coin_frm = m_imgview_photo.frame
        l_btn_coin_frm.size.height = 1.0/3 * l_btn_coin_frm.size.width
        l_btn_coin_frm.origin.x = 0
        l_btn_coin_frm.origin.y = m_imgview_photo.frame.size.height - l_btn_coin_frm.size.height
        m_btn_coin  = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.setImage(UIImage(named: "btn_openphoto"), forState: .Normal)
        m_btn_coin.hidden = true
        
        //add
        self.contentView.addSubview(self.m_imgview_photo)
        self.contentView.addSubview(self.m_imgview_lock)
        self.contentView.addSubview(m_btn_coin)
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
            self.m_imgview_photo.alpha = 0.4
            self.m_imgview_lock.image = UIImage(named: "img_lock")
            self.m_imgview_lock.hidden = false
            m_imgview_lock.frame.origin.x = 0.5 * (self.contentView.frame.size.width - m_imgview_lock.frame.size.width)
            m_imgview_lock.frame.origin.y = 0.5 * (self.contentView.frame.size.height - m_imgview_lock.frame.size.height)
            
            
        }
        else if p_photo.m_completed == PHOTO_STATUS.PHOTO_NOT_COMPLETED
        {
            self.m_imgview_photo.alpha = 1
            self.m_imgview_lock.image = nil
        }
        else
        {
            m_imgview_lock.frame.origin.x = self.contentView.frame.size.width - m_imgview_lock.frame.size.width
            m_imgview_lock.frame.origin.y = self.contentView.frame.size.height - m_imgview_lock.frame.size.height
            
            self.m_imgview_photo.alpha = 1
            self.m_imgview_lock.image = UIImage(named: "img_favorite")
        }
        
        if (p_photo.m_is_choosing == true)
        {
            self.m_imgview_lock.hidden = true
            self.m_imgview_photo.alpha = 1
            UIView.animateWithDuration(0.5, animations: {
                self.m_btn_coin.hidden = false
                self.m_btn_coin.tag = p_photo.m_id
            })
            
            self.m_btn_coin.Shake()
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: {
                self.m_btn_coin.hidden = true
                self.m_btn_coin.tag = -1
            })
        }
    }
    
}
