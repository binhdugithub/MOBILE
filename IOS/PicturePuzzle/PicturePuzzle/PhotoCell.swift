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
    var m_imgview_congratulation: UIImageView!
    
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
        
        
        
        self.contentView.addSubview(self.m_imgview_photo)
        self.contentView.addSubview(self.m_view_congratulation)
    }//end SetupView
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        //self.m_imgView.image = nil
    }
    
    
    func SetPhoto(p_photo:  Photo)
    {
        let l_img = UIImage(named: p_photo.m_name)
        m_imgview_photo.image = l_img
        
        if p_photo.m_completed == false
        {
            self.m_view_congratulation.frame = m_imgview_photo.frame
        }
        else
        {
            //self.m_view_congratulation.hidden = true
            var l_frm = CGRectMake(0, 0, 0, 0)
            l_frm.size.width = self.bounds.width
            l_frm.size.height = 1.0/5 * self.bounds.height
            l_frm.origin.x = 0
            l_frm.origin.y = self.bounds.height - l_frm.size.height

            self.m_view_congratulation.frame = l_frm
        }
    }

}
