

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
    
    var m_lbl_title: UILabel!
    var m_btn_speaker: UIButton!
    
    var m_lbl_coin: UILabel!
    var m_btn_coin: UIButton!
    
    
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
        //productIDs.append("com.cusiki.picturepuzzleanimal_get100coin")
        //requestProductInfo()
        
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
        self.AnimationGUI()
    }
    
    
    func AnimationGUI() -> Void
    {
        var l_frm = m_view_3btn_social.frame
        l_frm.origin.x = m_view_body.frame.size.width - m_view_3btn_social.frame.size.width + 10
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        self.m_view_3btn_social.frame = l_frm
        UIView.commitAnimations()
    
        m_btn_more.pulseToSize(1.2, p_duration: 0.5, p_repeat: true)
    }
    
    
    func HideSocialBtn() -> Void
    {
        var l_frm = m_view_3btn_social.frame
        l_frm.origin.x = m_view_body.frame.size.width + 10
    
        self.m_view_3btn_social.frame = l_frm
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
        
        //speaker 
        var l_btn_speaker_frm = CGRectMake(0, 0, 0, 0)
        l_btn_speaker_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        l_btn_speaker_frm.size.width = l_btn_speaker_frm.size.height
        l_btn_speaker_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_speaker_frm.size.height)
        l_btn_speaker_frm.origin.x = 1.0/3 * l_btn_speaker_frm.size.width
        m_btn_speaker = UIButton(frame: l_btn_speaker_frm)
        m_btn_speaker.setImage(UIImage(named: "btn_unmute"), forState: .Normal)
        m_btn_speaker.addTarget(self, action: #selector(HomeViewController.SpeakerClick(_:)), forControlEvents: .TouchUpInside)

        //title
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font_title: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[6], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)!
        l_lbl_level_frm.size.width = WidthForText("PICTURE PUZZLE", p_font: l_font_title, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_speaker.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_title = UILabel(frame: l_lbl_level_frm)
        m_lbl_title.textColor = UIColor.whiteColor()
        m_lbl_title.textAlignment = .Center
        m_lbl_title.text = "PICTURE PUZZLE"
        m_lbl_title.font = l_font_title
        
        //coins
        var l_btn_coin_frm = m_btn_speaker.frame
        l_btn_coin_frm.size.height = 0.5 * l_btn_coin_frm.size.height
        l_btn_coin_frm.size.width = 2.5 * l_btn_coin_frm.size.height
        l_btn_coin_frm.origin.x = m_view_header.frame.size.width - l_btn_coin_frm.size.width - 1.0/4 * l_btn_coin_frm.size.width
        l_btn_coin_frm.origin.y = m_btn_speaker.frame.origin.y + m_btn_speaker.frame.size.height - l_btn_coin_frm.size.height
        m_btn_coin = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.addTarget(self, action: #selector(HomeViewController.CoinClick(_:)), forControlEvents: .TouchUpInside)
        m_btn_coin.backgroundColor = UIColor.clearColor()
        m_btn_coin.setBackgroundImage(UIImage(named: "btn_coin"), forState: .Normal)
       
        //title coin
        var l_lbl_coin_frm = m_btn_coin.frame
        let l_font_coin: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN)!
        l_lbl_coin_frm.size.width = WidthForText(String(PPCore.ShareInstance.m_coin), p_font: l_font_coin, p_heigh: l_lbl_coin_frm.size.height)
        l_lbl_coin_frm.origin.x = m_btn_coin.frame.origin.x + 0.6 * m_btn_coin.frame.size.width - l_lbl_coin_frm.size.width
        
        m_lbl_coin = UILabel(frame: l_lbl_coin_frm)
        m_lbl_coin.textAlignment = .Right
        m_lbl_coin.font = l_font_coin
        m_lbl_coin.textColor = ViewDesign.ShareInstance.COLOR_COIN_TITLE
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = SCREEN_WIDTH
        l_view_subheader_frm.size.height = ViewDesign.ShareInstance.HEIGHT_SUBHEADER
        l_view_subheader_frm.origin = CGPointMake(0, 0)
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
        //
        //body view
        //
        var l_view_body_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_body_frm.size.width = SCREEN_WIDTH
        l_view_body_frm.size.height = SCREEN_HEIGHT - m_view_header.frame.size.height
        l_view_body_frm.origin.x = 0
        l_view_body_frm.origin.y = m_view_header.frame.origin.y + m_view_header.frame.size.height
        m_view_body = UIView(frame: l_view_body_frm)
        m_view_body.backgroundColor = UIColor.clearColor()//ViewDesign.ShareInstance.COLOR_BODY_BG
        
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
        l_btn_more_frm.size.width = 3.0/5 * m_view_body.frame.size.width
        l_btn_more_frm.size.height = 1.0/5 * l_btn_more_frm.size.width
        l_btn_more_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_btn_more_frm.size.width)
        l_btn_more_frm.origin.y = m_view_3btn_social.frame.origin.y + m_view_3btn_social.frame.size.height + m_btn_rate.frame.size.height
        m_btn_more = UIButton(frame: l_btn_more_frm)
        m_btn_more.layer.cornerRadius = 0.5 * l_btn_more_frm.size.height
        m_btn_more.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_more.layer.borderWidth = 0.05 * l_btn_more_frm.size.height
        m_btn_more.clipsToBounds = true
        m_btn_more.backgroundColor = ViewDesign.ShareInstance.COLOR_HEADER_BG
        m_btn_more.setTitle("More Free", forState: .Normal)
        m_btn_more.titleLabel?.font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[6], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)!
        
        //Start game
        var l_btn_start_frm = m_btn_more.frame
        l_btn_start_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_btn_start_frm.size.width)
        l_btn_start_frm.origin.y = m_btn_more.frame.origin.y + m_btn_more.frame.size.height + m_btn_rate.frame.size.height
        m_btn_start = UIButton(frame: l_btn_start_frm)
        m_btn_start.layer.cornerRadius = 0.5 * l_btn_start_frm.size.height
        m_btn_start.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_start.layer.borderWidth = 0.05 * l_btn_start_frm.size.height
        m_btn_start.clipsToBounds = true
        m_btn_start.backgroundColor = ViewDesign.ShareInstance.COLOR_HEADER_BG
        m_btn_start.setTitle("Start", forState: .Normal)
        m_btn_start.addTarget(self, action: #selector(HomeViewController.StartClick(_:)), forControlEvents: .TouchUpInside)
        m_btn_start.titleLabel?.font = m_btn_more.titleLabel?.font
        //
        //self add
        //
        m_view_header.addSubview(m_btn_speaker)
        //m_view_header.addSubview(m_btn_ads)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_coin)
        m_view_header.addSubview(m_lbl_title)
        
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
    }
    
    func StartClick(sender: UIButton)
    {
        self.performSegueWithIdentifier("segue_home_to_listphoto", sender: self)
        SoundController.ShareInstance.PlayClick()
    }
    
    func CoinClick(sender: UIButton)
    {
        print("Coin click")
        SoundController.ShareInstance.PlayClick()
        
        //view purchase background
        var l_frm = self.view.frame
        l_frm.origin = CGPointMake(0, 0)
        let l_view = UIView(frame: l_frm)
        l_view.backgroundColor = UIColor.init(white: 0.2, alpha: 0.8)
        
        //view purchase
        var l_view_purchase_frm = CGRectMake(0, 0, 0, 0)
        l_view_purchase_frm.size.width = ViewDesign.ShareInstance.WIDTH_PURCHASE
        l_view_purchase_frm.size.height = 1.5 * l_view_purchase_frm.size.width
        l_view_purchase_frm.origin.x = 0.5 * (SCREEN_WIDTH - l_view_purchase_frm.size.width)
        l_view_purchase_frm.origin.y = 0.5 * (SCREEN_HEIGHT - l_view_purchase_frm.size.height)
        let l_view_purchase = UIView(frame: l_view_purchase_frm)
        l_view_purchase.backgroundColor = UIColor.darkGrayColor()
        l_view_purchase.layer.borderColor = UIColor.whiteColor().CGColor
        l_view_purchase.layer.borderWidth = 1.0/50 * l_view_purchase_frm.size.width
        l_view_purchase.layer.cornerRadius = l_view_purchase.layer.borderWidth
        
        //label bonus
        var l_lbl_bonus_frm = l_view_purchase.frame
        let l_font = m_lbl_coin.font
        l_lbl_bonus_frm.size.width = l_lbl_bonus_frm.size.width - 2 * l_view_purchase.layer.borderWidth
        l_lbl_bonus_frm.size.height = HeightForText("Bonus! Make any purchase and deactivate the ads!", p_font: l_font, p_width: l_lbl_bonus_frm.size.width)
        l_lbl_bonus_frm.origin = CGPointMake(l_view_purchase.layer.borderWidth, 2 * l_view_purchase.layer.borderWidth)
        let l_lbl_bonus = UILabel(frame: l_lbl_bonus_frm)
        l_lbl_bonus.text = "Bonus! Make any purchase and deactivate the ads!"
        l_lbl_bonus.numberOfLines = 0
        l_lbl_bonus.lineBreakMode = .ByWordWrapping
        l_lbl_bonus.textAlignment = .Center
        l_lbl_bonus.font = l_font
        l_lbl_bonus.textColor = UIColor.whiteColor()
        
        //close 
        var l_btn_close_frm = CGRectMake(0, 0, 0, 0)
        l_btn_close_frm.size.width = 1.0/6 * l_view_purchase.frame.size.width
        l_btn_close_frm.size.height = l_btn_close_frm.size.width
        l_btn_close_frm.origin.x = 0.5 * (l_view_purchase.frame.size.width - l_btn_close_frm.size.width)
        l_btn_close_frm.origin.y = l_view_purchase.frame.size.height - 1.5 * l_btn_close_frm.size.height
        let m_btn_closepurchase = UIButton(frame: l_btn_close_frm)
        m_btn_closepurchase.backgroundColor = UIColor.redColor()
        m_btn_closepurchase.setTitle("x", forState: .Normal)
        m_btn_closepurchase.setTitleColor(UIColor.blackColor(), forState: .Normal)
        m_btn_closepurchase.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
        m_btn_closepurchase.layer.cornerRadius = 0.5 * l_btn_close_frm.size.width
        m_btn_closepurchase.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_closepurchase.layer.borderWidth = 1.0/40 * l_btn_close_frm.size.width
        m_btn_closepurchase.addTarget(self, action: #selector(HomeViewController.CloseClick(_:)), forControlEvents: .TouchUpInside)
        

        //100
        let l_h = m_btn_closepurchase.frame.origin.y - l_lbl_bonus.frame.origin.y - l_lbl_bonus.frame.size.height
        let l_btn_purchase_h = l_h * 1.0 / 5.75
        
        
        var l_btn_frm = CGRectMake(0, 0, 0, 0)
        l_btn_frm.size.height = l_btn_purchase_h
        l_btn_frm.size.width = 3 * l_btn_frm.size.height
        l_btn_frm.origin.x = 0.5 * (l_view_purchase.frame.size.width - l_btn_frm.size.width)
        l_btn_frm.origin.y = l_lbl_bonus.frame.origin.y + l_lbl_bonus.frame.size.height + 0.5 * l_btn_frm.size.height
        let l_btn_100 = UIButton(frame: l_btn_frm)
        l_btn_100.setImage(UIImage(named: "100"), forState: .Normal)
        
        //300
        l_btn_frm.origin.y = l_btn_100.frame.origin.y + 1.25 * l_btn_100.frame.size.height
        let l_btn_300 = UIButton(frame: l_btn_frm)
        l_btn_300.setImage(UIImage(named: "300"), forState: .Normal)
        //400
        l_btn_frm.origin.y = l_btn_300.frame.origin.y + 1.25 * l_btn_300.frame.size.height
        let l_btn_400 = UIButton(frame: l_btn_frm)
        l_btn_400.setImage(UIImage(named: "400"), forState: .Normal)
        //600
        l_btn_frm.origin.y = l_btn_400.frame.origin.y + 1.25 * l_btn_400.frame.size.height
        let l_btn_600 = UIButton(frame: l_btn_frm)
        l_btn_600.setImage(UIImage(named: "600"), forState: .Normal)
        
        
        l_view_purchase.addSubview(l_btn_100)
        l_view_purchase.addSubview(l_btn_300)
        l_view_purchase.addSubview(l_btn_400)
        l_view_purchase.addSubview(l_btn_600)
        l_view_purchase.addSubview(m_btn_closepurchase)
        l_view_purchase.addSubview(l_lbl_bonus)
        
        
        l_view.addSubview(l_view_purchase)
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.view.addSubview(l_view)
        })
    }
    
    func CloseClick(sender: UIButton)
    {
        UIView.animateWithDuration(0.5, animations: {
            sender.superview?.superview?.removeFromSuperview()
        })
        
    }
    func SpeakerClick(sender: UIButton)
    {
        print("speaker click")
        SoundController.ShareInstance.PlayClick()
        SoundController.ShareInstance.ChangeMute()
        if SoundController.ShareInstance.m_ismuted == true
        {
            m_btn_speaker.setImage(UIImage(named: "btn_mute"), forState: .Normal)
        }
        else
        {
            m_btn_speaker.setImage(UIImage(named: "btn_unmute"), forState: .Normal)
        }
        
    }

    
}

