//
//  PlayViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/18/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController
{
    //header
    var m_view_header: UIView!
    var m_view_subheader: UIView!
    var m_view_footer: UIView!
    
    var m_btn_home: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_level: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SetupView()
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    
    func SetupView() -> Void
    {
        self.view.backgroundColor = UIColor.clearColor()
        //
        //header view
        //
        var l_view_header_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_header_frm.size.width = SCREEN_WIDTH
        l_view_header_frm.size.height = ViewDesign.ShareInstance.HEIGHT_HEADER
        l_view_header_frm.origin = CGPointMake(0, 0)
        m_view_header = UIView(frame: l_view_header_frm)
        m_view_header.backgroundColor = ViewDesign.ShareInstance.COLOR_HEADER_BG
        
        //home
        var l_btn_home_frm = CGRectMake(0, 0, 0, 0)
        l_btn_home_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        l_btn_home_frm.size.width = l_btn_home_frm.size.height
        l_btn_home_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_home_frm.size.height)
        l_btn_home_frm.origin.x = 1.0/2 * l_btn_home_frm.size.width
        m_btn_home = UIButton(frame: l_btn_home_frm)
        m_btn_home.setImage(UIImage(named: "btn_back"), forState: .Normal)
        m_btn_home.addTarget(self, action: #selector(PlayViewController.BackClick(_:)), forControlEvents: .TouchUpInside)
        
        //ads
        //        var l_btn_ads_frm = CGRectMake(0, 0, 0, 0)
        //        l_btn_ads_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        //        l_btn_ads_frm.size.width = l_btn_ads_frm.size.height
        //        l_btn_ads_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_ads_frm.size.height)
        //        l_btn_ads_frm.origin.x = m_btn_home.frame.origin.x + m_btn_home.frame.size.width + 1.0/2 * m_btn_home.frame.size.width
        //        m_btn_ads = UIButton(frame: l_btn_ads_frm)
        //        m_btn_ads.setImage(UIImage(named: "btn_mute"), forState: .Normal)
        
        //level
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font: UIFont = UIFont.systemFontOfSize(30)
        l_lbl_level_frm.size.width = WidthForText("LEVEL 10", p_font: l_font, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_home.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_level = UILabel(frame: l_lbl_level_frm)
        m_lbl_level.textColor = UIColor.init(white: 1, alpha: 0.9)
        m_lbl_level.textAlignment = .Center
        m_lbl_level.text = "LEVEL 10"
        
        //coins
        var l_btn_coin_frm = CGRectMake(0, 0, 0, 0)
        l_btn_coin_frm.size.height = 1.0/2 * m_view_header.frame.size.height
        l_btn_coin_frm.size.width = 3 * l_btn_coin_frm.size.height
        l_btn_coin_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_coin_frm.size.height)
        l_btn_coin_frm.origin.x = m_view_header.frame.size.width - l_btn_coin_frm.size.width - 1.0/3 * l_btn_coin_frm.size.width
        m_btn_coin = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.setImage(UIImage(named: "btn_coin"), forState: .Normal)
        
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = SCREEN_WIDTH
        l_view_subheader_frm.size.height = 2
        l_view_subheader_frm.origin = CGPointMake(0, m_view_header.frame.size.height)
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
        
        //footer view
        var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_footer_frm.size.width = SCREEN_WIDTH
        l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
        l_view_footer_frm.origin.x = 0
        l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
        m_view_footer = UIView(frame: l_view_footer_frm)
        m_view_footer.backgroundColor = ViewDesign.ShareInstance.COLOR_FOOTER_BG
        
        //
        //self add
        //
        m_view_header.addSubview(m_btn_home)
        //m_view_header.addSubview(m_btn_ads)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_level)
        
        self.view.addSubview(m_view_header)
        self.view.addSubview(m_view_subheader)
        self.view.addSubview(m_view_footer)
    }
    
    func BackClick(sender: UIButton)
    {
        if let l_navController = self.navigationController
        {
            for controller in l_navController.viewControllers
            {
                if controller.isKindOfClass(ListPhotoCollectionViewController)
                {
                    let ListPhotoView = controller as! ListPhotoCollectionViewController
                    l_navController.popToViewController(ListPhotoView, animated: true)
                }
            }
            
        }
    }

}
