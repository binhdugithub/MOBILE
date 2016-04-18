//
//  ViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/16/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    var m_view_header: UIView!
    var m_view_subheader: UIView!
    var m_view_body: UIView!
    var m_view_footer: UIView!
    
    var m_btn_speaker: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_level: UILabel!
    
    var m_imgv_logo: UIImageView!
    var m_btn_more: UIButton!
    var m_btn_start: UIButton!
    
    var m_view_3btn_social: UIView!
    var m_btn_fb: UIButton!
    var m_btn_tw: UIButton!
    var m_btn_rate: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SetupView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool)
    {
        HideSocialBtn()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.ShowSocialBtn()
    }
    
    
    func ShowSocialBtn() -> Void
    {
        var l_frm = m_view_3btn_social.frame
        l_frm.origin.x = m_view_body.frame.size.width - m_view_3btn_social.frame.size.width + 10
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        self.m_view_3btn_social.frame = l_frm
        UIView.commitAnimations()
    
    }
    
    
    func HideSocialBtn() -> Void
    {
        var l_frm = m_view_3btn_social.frame
        l_frm.origin.x = m_view_body.frame.size.width + 10
    
        self.m_view_3btn_social.frame = l_frm
    }
    
    func SetupView() -> Void
    {
        //
        //header view
        //
        var l_view_header_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_header_frm.size.width = SCREEN_WIDTH
        l_view_header_frm.size.height = ViewDesign.ShareInstance.HEIGHT_HEADER
        l_view_header_frm.origin = CGPointMake(0, 0)
        m_view_header = UIView(frame: l_view_header_frm)
        m_view_header.backgroundColor = ViewDesign.ShareInstance.COLOR_HEADER_BG
        
        //speaker 
        var l_btn_speaker_frm = CGRectMake(0, 0, 0, 0)
        l_btn_speaker_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        l_btn_speaker_frm.size.width = l_btn_speaker_frm.size.height
        l_btn_speaker_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_speaker_frm.size.height)
        l_btn_speaker_frm.origin.x = 1.0/2 * l_btn_speaker_frm.size.width
        m_btn_speaker = UIButton(frame: l_btn_speaker_frm)
        m_btn_speaker.setImage(UIImage(named: "btn_unmute"), forState: .Normal)
        
        //ads
//        var l_btn_ads_frm = CGRectMake(0, 0, 0, 0)
//        l_btn_ads_frm.size.height = 3.0/4 * m_view_header.frame.size.height
//        l_btn_ads_frm.size.width = l_btn_ads_frm.size.height
//        l_btn_ads_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_ads_frm.size.height)
//        l_btn_ads_frm.origin.x = m_btn_speaker.frame.origin.x + m_btn_speaker.frame.size.width + 1.0/2 * m_btn_speaker.frame.size.width
//        m_btn_ads = UIButton(frame: l_btn_ads_frm)
//        m_btn_ads.setImage(UIImage(named: "btn_mute"), forState: .Normal)
        
        //level
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font: UIFont = UIFont.systemFontOfSize(30)
        l_lbl_level_frm.size.width = WidthForText("PICTURE PUZZLE", p_font: l_font, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_speaker.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_level = UILabel(frame: l_lbl_level_frm)
        m_lbl_level.textColor = UIColor.init(white: 1, alpha: 0.9)
        m_lbl_level.textAlignment = .Center
        m_lbl_level.text = "PICTURE PUZZLE"
        
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
        l_view_subheader_frm.origin = CGPointMake(0, 0)
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
//        //footer view
//        var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
//        l_view_footer_frm.size.width = SCREEN_WIDTH
//        l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
//        l_view_footer_frm.origin.x = 0
//        l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
//        m_view_footer = UIView(frame: l_view_footer_frm)
//        m_view_footer.backgroundColor = ViewDesign.ShareInstance.COLOR_FOOTER_BG
        
        //
        //body view
        //
        var l_view_body_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_body_frm.size.width = SCREEN_WIDTH
        l_view_body_frm.size.height = SCREEN_HEIGHT - m_view_header.frame.size.height
        l_view_body_frm.origin.x = 0
        l_view_body_frm.origin.y = m_view_header.frame.origin.y + m_view_header.frame.size.height
        m_view_body = UIView(frame: l_view_body_frm)
        m_view_body.backgroundColor = ViewDesign.ShareInstance.COLOR_BODY_BG
        
        //image view logo
        var l_imgv_logo_frm = CGRectMake(0, 0, 0, 0)
        l_imgv_logo_frm.size.width = 2.0/5 * m_view_body.frame.size.width
        l_imgv_logo_frm.size.height = l_imgv_logo_frm.size.width
        l_imgv_logo_frm.origin.x = 0.5 * (m_view_body.frame.size.width - l_imgv_logo_frm.size.width)
        l_imgv_logo_frm.origin.y = 0.5 * l_imgv_logo_frm.size.height
        m_imgv_logo = UIImageView(frame: l_imgv_logo_frm)
        m_imgv_logo.backgroundColor = UIColor.blackColor()
        m_imgv_logo.layer.cornerRadius = 0.05 * l_imgv_logo_frm.size.height
        m_imgv_logo.layer.borderWidth = 0.05 * l_imgv_logo_frm.size.height
        m_imgv_logo.layer.borderColor = UIColor.whiteColor().CGColor
//        m_imgv_logo.layer.shadowOffset = CGSize(width: 100, height: 100)
//        m_imgv_logo.layer.shadowRadius = 100
//        m_imgv_logo.layer.shadowColor = UIColor.whiteColor().CGColor
        
        //3 social button
        var l_view_3btn_social = CGRectMake(0, 0, 0, 0)
        l_view_3btn_social.size.height = 3 * ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL + 2.0/5 * ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL
        l_view_3btn_social.size.width = 3 * ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL
        l_view_3btn_social.origin.x = m_view_body.frame.size.width + l_view_3btn_social.size.width + 10
        l_view_3btn_social.origin.y = 1.0/2 * (m_view_body.frame.size.height - l_view_3btn_social.size.height)
        m_view_3btn_social = UIView(frame: l_view_3btn_social)
        
        //fb 
        var l_btn_fb_frm = CGRectMake(0, 0, 0, 0)
        l_btn_fb_frm.size.height = ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL
        l_btn_fb_frm.size.width = 3 * l_btn_fb_frm.size.height
        l_btn_fb_frm.origin.x = 0
        l_btn_fb_frm.origin.y = 0
        m_btn_fb = UIButton(frame: l_btn_fb_frm)
        m_btn_fb.setImage(UIImage(named: "btn_fb"), forState: .Normal)
        m_btn_fb.setImage(UIImage(named: "btn_fb_pressed"), forState: .Highlighted)
        
        //tw
        var l_btn_tw_frm = CGRectMake(0, 0, 0, 0)
        l_btn_tw_frm.size.height = ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL
        l_btn_tw_frm.size.width = 3 * l_btn_fb_frm.size.height
        l_btn_tw_frm.origin.x = 0
        l_btn_tw_frm.origin.y = m_btn_fb.frame.origin.y + m_btn_fb.frame.size.height + 1.0/5 * m_btn_fb.frame.size.height
        m_btn_tw = UIButton(frame: l_btn_tw_frm)
        m_btn_tw.setImage(UIImage(named: "btn_tw"), forState: .Normal)
        m_btn_tw.setImage(UIImage(named: "btn_tw_pressed"), forState: .Highlighted)
        
        //rate
        var l_btn_rate_frm = CGRectMake(0, 0, 0, 0)
        l_btn_rate_frm.size.height = ViewDesign.ShareInstance.HEIGHT_BTN_SOCIAL
        l_btn_rate_frm.size.width = 3 * l_btn_fb_frm.size.height
        l_btn_rate_frm.origin.x = 0
        l_btn_rate_frm.origin.y = m_btn_tw.frame.origin.y + m_btn_tw.frame.size.height + 1.0/5 * m_btn_tw.frame.size.height
        m_btn_rate = UIButton(frame: l_btn_rate_frm)
        m_btn_rate.setImage(UIImage(named: "btn_rate"), forState: .Normal)
        m_btn_rate.setImage(UIImage(named: "btn_rate_pressed"), forState: .Highlighted)
        
        //More game
        var l_btn_more_frm = CGRectMake(0, 0, 0, 0)
        l_btn_more_frm.size.width = 1.0/2 * m_view_body.frame.size.width
        l_btn_more_frm.size.height = 1.0/4 * l_btn_more_frm.size.width
        l_btn_more_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_btn_more_frm.size.width)
        l_btn_more_frm.origin.y = m_view_3btn_social.frame.origin.y + m_view_3btn_social.frame.size.height + m_btn_rate.frame.size.height
        m_btn_more = UIButton(frame: l_btn_more_frm)
        m_btn_more.layer.cornerRadius = 0.5 * l_btn_more_frm.size.height
        m_btn_more.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_more.layer.borderWidth = 0.05 * l_btn_more_frm.size.height
        m_btn_more.clipsToBounds = true
        m_btn_more.backgroundColor = UIColor.blackColor()
        m_btn_more.setTitle("More Free", forState: .Normal)
        
        
        //Start game
        var l_btn_start_frm = CGRectMake(0, 0, 0, 0)
        l_btn_start_frm.size.width = 1.0/2 * m_view_body.frame.size.width
        l_btn_start_frm.size.height = 1.0/4 * l_btn_start_frm.size.width
        l_btn_start_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_btn_start_frm.size.width)
        l_btn_start_frm.origin.y = m_btn_more.frame.origin.y + m_btn_more.frame.size.height + m_btn_rate.frame.size.height
        if IS_IPAD
        {
            l_btn_start_frm.origin.y = m_btn_more.frame.origin.y + m_btn_more.frame.size.height + m_btn_rate.frame.size.height
        }
        m_btn_start = UIButton(frame: l_btn_start_frm)
        m_btn_start.layer.cornerRadius = 0.5 * l_btn_start_frm.size.height
        m_btn_start.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_start.layer.borderWidth = 0.05 * l_btn_start_frm.size.height
        m_btn_start.clipsToBounds = true
        m_btn_start.backgroundColor = UIColor.blackColor()
        m_btn_start.setTitle("Start", forState: .Normal)
        m_btn_start.addTarget(self, action: #selector(HomeViewController.StartClick(_:)), forControlEvents: .TouchUpInside)
        
        //
        //self add
        //
        m_view_header.addSubview(m_btn_speaker)
        //m_view_header.addSubview(m_btn_ads)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_level)
        
        m_view_body.addSubview(m_view_subheader)
        m_view_3btn_social.addSubview(m_btn_fb)
        m_view_3btn_social.addSubview(m_btn_tw)
        m_view_3btn_social.addSubview(m_btn_rate)
        m_view_body.addSubview(m_view_3btn_social)
        m_view_body.addSubview(m_btn_more)
        m_view_body.addSubview(m_btn_start)
        m_view_body.addSubview(m_imgv_logo)
        
        self.view.addSubview(m_view_header)
        self.view.addSubview(m_view_body)
        //self.view.addSubview(m_view_footer)
    }
    
    func StartClick(sender: UIButton)
    {
        self.performSegueWithIdentifier("segue_home_to_listphoto", sender: self)
    }

}

