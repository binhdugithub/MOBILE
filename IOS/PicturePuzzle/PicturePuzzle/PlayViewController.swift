//
//  PlayViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/18/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit


let NUMBER_V_ITEM = 5
let NUMBER_H_ITEM = 5
let MAX_TIME = 6
let COIN_BONUS = 10
let COIN_HINT_ONE = 10
let COIN_HINT_FULL = 20
let COIN_GAME_WIN    = 100
let COIN_GAME_OVER    = 50
let COIN_OPEN_PHOTO = 20

enum STATUSGAME
{
    case LOADING
    case PREPAREPLAY
    case PLAYING
    case PAUSE
    case GAMEOVER
}

class PlayViewController: UIViewController
{
    //GUI
    var m_view_header: UIView!
    var m_view_body: UIView!
    var m_view_subheader: UIView!
    var m_view_footer: UIView!
    var m_btn_back: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_title: UILabel!
    var m_lbl_coin: UILabel!
    var m_view_tiles_photo: UIView!
    var m_imgv_hintfull_photo: UIImageView!
    var m_imgv_full_photo: UIImageView!
    var m_btn_hint_one: UIButton!
    var m_btn_hint_full: UIButton!
    var m_btn_bonus_ads: UIButton!
    var m_btn_play: UIButton!
    var m_circle_time: KDCircularProgress!
    var m_timer: NSTimer!
    
    //variable 
    var m_array_tiles: [UIImageView]!
    var m_array_coins: [UIImageView]!
    var m_photo_img: UIImage!
    var m_status_game: STATUSGAME!
    var m_current_time: Int!
    var m_lock: NSLock!
    var m_touched_frm: CGRect!
    var m_number_hintone: Int! = 0
    var m_number_hintfull: Int! = 0
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.m_array_tiles = [UIImageView]()
        self.m_array_coins = [UIImageView]()
        self.m_lock = NSLock()
        m_current_time = 0
        m_status_game = STATUSGAME.LOADING
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.m_array_tiles = [UIImageView]()
        self.m_array_coins = [UIImageView]()
        self.m_lock = NSLock()
        m_current_time = 0
        m_status_game = STATUSGAME.LOADING
        
        SetupView()
        GADMasterViewController.ShareInstance.ShowBannerView(self, p_ads_b: self.m_view_footer)
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if m_status_game == STATUSGAME.LOADING
        {
            ShowUIAnimation()
            ShowRandomPlitPhoto()
            
            m_btn_hint_one.enabled = false
            m_btn_hint_full.enabled = false
            
            m_status_game = STATUSGAME.PREPAREPLAY
        }
    }
    
    func ClearAllView() -> Void
    {
        m_view_header.removeFromSuperview()
        m_view_body.removeFromSuperview()
        m_view_footer.removeFromSuperview()
    }
    
    func CollectionTiles2Center() -> Void
    {
        for l_imgv in self.m_array_tiles
        {
            l_imgv.frame.origin.x = 0.5 * (self.m_view_tiles_photo.frame.size.width - l_imgv.frame.size.width)
            l_imgv.frame.origin.y = 0.5 * (self.m_view_tiles_photo.frame.size.height - l_imgv.frame.size.height)
        }
    }
    
    func HideControl() -> Void
    {
        UIView.animateWithDuration(0.4, animations: {
            self.m_btn_hint_one.frame.origin.x = 0 - self.m_btn_hint_one.frame.size.width
            self.m_btn_bonus_ads.frame.origin.x = self.m_btn_hint_one.frame.origin.x
            self.m_btn_hint_full.frame.origin.x = self.m_view_body.frame.size.width + self.m_btn_hint_full.frame.size.width
            self.m_circle_time.frame.origin.y = 0 - self.m_view_header.frame.size.height - self.m_circle_time.frame.size.height
        })
        
    }
    
    func ShowUIAnimation() -> Void
    {
        UIView.animateWithDuration(0.4, animations: {
            self.m_btn_hint_one.frame.origin.x = 0
            self.m_btn_bonus_ads.frame.origin.x = self.m_btn_hint_one.frame.origin.x
            self.m_btn_hint_full.frame.origin.x = self.m_view_body.frame.size.width - self.m_btn_hint_full.frame.size.width
            self.m_circle_time.frame.origin.y = self.m_btn_hint_one.frame.origin.y + self.m_btn_hint_one.frame.size.height - self.m_circle_time.frame.size.height
    
            self.m_btn_play.hidden = false
            self.m_btn_play.frame.origin.x = 0
            self.m_view_tiles_photo.bringSubviewToFront(self.m_btn_play)
        })
        
        
    }
    
    func ShowRandomPlitPhoto() -> Void
    {
        let l_size: Int = (NUMBER_V_ITEM * NUMBER_H_ITEM)
        let imgWidth: CGFloat = m_array_tiles[0].frame.size.width
        let imgheight = imgWidth
    
        m_photo_img = UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_name)!.ResizeImage(m_view_tiles_photo.frame.size)
        
        for i in 0..<l_size
        {
            let l_imageView: UIImageView = m_array_tiles[i]
            let frm = CGRectMake(CGFloat(i % NUMBER_H_ITEM) * imgWidth, CGFloat(i / NUMBER_V_ITEM) * imgheight, imgWidth, imgheight);
            let l_imgRef = CGImageCreateWithImageInRect(m_photo_img.CGImage, frm)
            if l_imgRef != nil
            {
                let l_tile = UIImage(CGImage: l_imgRef!)
                
                l_imageView.image = l_tile
                l_imageView.tag = i
            }
            else
            {
                print("You have to xem xet lai")
            }
            
        }
        
        for i in 0..<l_size
        {
            let j = Int(arc4random_uniform(UInt32(l_size - i))) + i
            (m_array_tiles[i], m_array_tiles[j]) = (m_array_tiles[j], m_array_tiles[i])
        }
        
        for i in 0..<l_size
        {
            let MyImgView: UIImageView = m_array_tiles[i]
            var l_frm: CGRect = MyImgView.frame
            let l_x: CGFloat = CGFloat(i % NUMBER_H_ITEM) * l_frm.size.width
            let l_y: CGFloat = CGFloat(i / NUMBER_V_ITEM) * l_frm.size.height
            l_frm.origin.x = l_x
            l_frm.origin.y = l_y
            
            UIView.animateWithDuration(0.2, animations: {
                MyImgView.frame = l_frm
                MyImgView.Rotation360Degree(0.2)
            })
            
            
            let l_imgv_coin = UIImageView(frame: l_frm)
            l_imgv_coin.image = UIImage(named: "img_wincoin")
            l_imgv_coin.hidden = true
            m_array_coins.append(l_imgv_coin)
            m_view_tiles_photo.addSubview(l_imgv_coin)
            
        }
    }
    
    func ShowFullPhoto() -> Void
    {
        var l_frm = m_view_tiles_photo.frame
        l_frm.origin = CGPointMake(0, 0)
        self.m_imgv_full_photo.hidden = false
        m_view_tiles_photo.bringSubviewToFront(m_imgv_full_photo)
        UIView.animateWithDuration(0.5, animations: {
            self.m_imgv_full_photo.frame = l_frm
            self.m_imgv_full_photo.Rotation360Degree(1)
        })
    }
    
    func UIGetWinCoin() -> Void
    {
       
        var l_frm = m_btn_coin.frame
        l_frm.size.width = 0
        l_frm.size.height = l_frm.size.width
        l_frm.origin.x = l_frm.origin.x + 2.0/3 * m_btn_coin.frame.size.width - (m_view_header.frame.size.width - m_view_tiles_photo.frame.size.width) * 0.5
        l_frm.origin.y = 0 - l_frm.origin.y - m_view_tiles_photo.frame.origin.y
        
        for l_imgv in m_array_coins
        {
            l_imgv.hidden = false
            UIView.animateWithDuration(1, animations: {
                l_imgv.frame = l_frm
                l_imgv.Rotation360Degree(0.5)
            })
            
            //l_imgv.hidden = true
        }
    }
    
    func InitImgvLock(p_view: UIButton, p_level: Int) -> Void
    {
        //imgv lock
        var l_frm = CGRectMake(0,0 , 0, 0)
        l_frm.size.width = 1.0/4 * p_view.frame.size.width
        l_frm.size.height = l_frm.size.width
        l_frm.origin.x = p_view.frame.size.width - l_frm.size.width
        l_frm.origin.y = p_view.frame.size.height - l_frm.size.height
        let l_imgview_lock = UIImageView(frame: l_frm)
        
        if PPCore.ShareInstance.m_ArrayPhoto[p_level].m_completed == PHOTO_STATUS.PHOTO_LOCK
        {
            l_imgview_lock.image = UIImage(named: "img_lock")
            p_view.alpha = 0.5
        }
        else if PPCore.ShareInstance.m_ArrayPhoto[p_level].m_completed == PHOTO_STATUS.PHOTO_NOT_COMPLETED
        {
            l_imgview_lock.alpha = 1
            l_imgview_lock.image = nil
        }
        else
        {
            l_imgview_lock.alpha = 1
            l_imgview_lock.image = UIImage(named: "img_favorite")
        }
        
        p_view.addSubview(l_imgview_lock)
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
        var l_btn_x_frm = CGRectMake(0, 0, 0, 0)
        l_btn_x_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        l_btn_x_frm.size.width = l_btn_x_frm.size.height
        l_btn_x_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_x_frm.size.height)
        l_btn_x_frm.origin.x = 1.0/3 * l_btn_x_frm.size.width
        m_btn_back = UIButton(frame: l_btn_x_frm)
        m_btn_back.setImage(UIImage(named: "btn_back"), forState: .Normal)
        m_btn_back.addTarget(self, action: #selector(PlayViewController.BackClick(_:)), forControlEvents: .TouchUpInside)
        
        //title
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font_title: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[6], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)!
        l_lbl_level_frm.size.width = WidthForText("PICTURE PUZZLE", p_font: l_font_title, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_back.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_title = UILabel(frame: l_lbl_level_frm)
        m_lbl_title.textColor = UIColor.whiteColor()
        m_lbl_title.textAlignment = .Center
        m_lbl_title.text = "PICTURE PUZZLE"
        m_lbl_title.font = l_font_title
        
        //coins
        var l_btn_coin_frm = m_btn_back.frame
        l_btn_coin_frm.size.height = 0.5 * l_btn_coin_frm.size.height
        l_btn_coin_frm.size.width = 2.5 * l_btn_coin_frm.size.height
        l_btn_coin_frm.origin.x = m_view_header.frame.size.width - l_btn_coin_frm.size.width - 1.0/4 * l_btn_coin_frm.size.width
        l_btn_coin_frm.origin.y = m_btn_back.frame.origin.y + m_btn_back.frame.size.height - l_btn_coin_frm.size.height
        m_btn_coin = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.addTarget(self, action: #selector(PlayViewController.CoinClick(_:)), forControlEvents: .TouchUpInside)
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
        
        //
        //footer view
        //
        var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_footer_frm.size.width = SCREEN_WIDTH
        l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
        l_view_footer_frm.origin.x = 0
        l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
        m_view_footer = UIView(frame: l_view_footer_frm)
        m_view_footer.backgroundColor = UIColor.clearColor()
        
        
        let l_lbl_copyright = UILabel.init(frame: l_view_footer_frm)
        l_lbl_copyright.frame.origin.x = 0
        l_lbl_copyright.frame.origin.y = 0
        l_lbl_copyright.textColor = UIColor.blackColor()
        l_lbl_copyright.text = TEXT_COPYRIGHT
        l_lbl_copyright.textAlignment = .Center
        l_lbl_copyright.font = UIFont.systemFontOfSize(CGFloat(ViewDesign.ShareInstance.FONT_SIZE_COPYRIGHT))
        m_view_footer.addSubview(l_lbl_copyright)
        
        //
        //body view
        //
        var l_view_body_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_body_frm.size.width = SCREEN_WIDTH
        l_view_body_frm.size.height = SCREEN_HEIGHT - m_view_header.frame.size.height - m_view_footer.frame.size.height
        l_view_body_frm.origin.x = 0
        l_view_body_frm.origin.y = m_view_header.frame.origin.y + m_view_header.frame.size.height
        m_view_body = UIView(frame: l_view_body_frm)
        m_view_body.backgroundColor = UIColor.clearColor()//ViewDesign.ShareInstance.COLOR_BODY_BG
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = SCREEN_WIDTH
        l_view_subheader_frm.size.height = ViewDesign.ShareInstance.HEIGHT_SUBHEADER
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
        //view tile photo
        var l_view_tiles_photo_frm = CGRectMake(0, 0, 0, 0)
        l_view_tiles_photo_frm.size.width = ViewDesign.ShareInstance.WIDTH_VIEW_PHOTO
        l_view_tiles_photo_frm.size.height = l_view_tiles_photo_frm.size.width
        l_view_tiles_photo_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_view_tiles_photo_frm.size.width)
        l_view_tiles_photo_frm.origin.y = 0
        m_view_tiles_photo = UIView(frame: l_view_tiles_photo_frm)
        m_view_tiles_photo.backgroundColor = UIColor.darkGrayColor()//ViewDesign.ShareInstance.COLOR_HEADER_BG
        
        let l_size: Int = NUMBER_V_ITEM * NUMBER_H_ITEM;
        let imgViewWidth: CGFloat = m_view_tiles_photo.frame.size.width / CGFloat(NUMBER_H_ITEM);
        let imgViewHeight:CGFloat = m_view_tiles_photo.frame.size.height / CGFloat(NUMBER_V_ITEM);
        var l_view_control_heigth = imgViewHeight + m_view_tiles_photo.frame.origin.x
        if IS_IPAD || IS_IPHONE_4_OR_LESS
        {
            l_view_control_heigth = 3.0/4 * imgViewHeight + m_view_tiles_photo.frame.origin.x
        }
        
        m_view_tiles_photo.frame.origin.y = m_view_subheader.frame.size.height + l_view_control_heigth + 0.5 * (m_view_body.frame.size.height - l_view_control_heigth -  m_view_tiles_photo.frame.size.height - m_view_subheader.frame.size.height)
       
        //view hint full photo
        m_imgv_hintfull_photo = UIImageView(frame: m_view_tiles_photo.frame)
        m_imgv_hintfull_photo.image = UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_name)
        m_imgv_hintfull_photo.hidden = true
        
        //view full photo
        var l_imgv_full_photo_frm = CGRectMake(0, 0, 0, 0)
        l_imgv_full_photo_frm.origin.x = 1.0/2 * (m_view_tiles_photo.frame.size.width)
        l_imgv_full_photo_frm.origin.y = 1.0/2 * (m_view_tiles_photo.frame.size.height)
        m_imgv_full_photo = UIImageView(frame: l_imgv_full_photo_frm)
        m_imgv_full_photo.image = UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_name)
        m_imgv_full_photo.hidden = true
        m_imgv_full_photo.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
        m_imgv_full_photo.layer.borderWidth = 2.0;
        m_imgv_full_photo.layer.shadowColor = UIColor.blackColor().CGColor;
        m_imgv_full_photo.layer.shadowRadius = 3.0;
        m_imgv_full_photo.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        m_imgv_full_photo.layer.shadowOpacity = 0.5;
        m_imgv_full_photo.layer.rasterizationScale = UIScreen.mainScreen().scale;
        m_imgv_full_photo.layer.shouldRasterize = true;
        
        //tiles uiimageview
        for _ in 0..<l_size
        {
            var frmImgView: CGRect = CGRectMake(0, 0, 0, 0)
            frmImgView.size.width = imgViewWidth;
            frmImgView.size.height = imgViewHeight;
            frmImgView.origin.x = 0.5 * (self.m_view_tiles_photo.frame.size.width - frmImgView.size.width)
            frmImgView.origin.y = 0.5 * (self.m_view_tiles_photo.frame.size.height - frmImgView.size.height)
            let l_ImgView = UIImageView(frame: frmImgView)
            l_ImgView.layer.borderWidth = 1
            l_ImgView.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
            l_ImgView.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
            l_ImgView.userInteractionEnabled = true;
            l_ImgView.multipleTouchEnabled = false;
            let l_Pan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PlayViewController.HandlePan(_:)))
            l_ImgView.addGestureRecognizer(l_Pan)
            
            self.m_array_tiles.append(l_ImgView)
            self.m_view_tiles_photo.addSubview(l_ImgView)
        }
        
        //play
        var l_replay_frm = self.m_array_tiles[0].frame
        l_replay_frm.size.width = m_view_tiles_photo.frame.size.width
        l_replay_frm.origin.x = 0 - l_replay_frm.size.width
        l_replay_frm.origin.y = 0.5 * (m_view_tiles_photo.frame.size.height - l_replay_frm.size.height)
        m_btn_play = UIButton(frame: l_replay_frm)
         m_btn_play.setTitle("Tap to play !!!", forState: .Normal)
        m_btn_play.titleLabel?.font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[0], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)
        m_btn_play.backgroundColor = UIColor.init(white: 0.5, alpha: 0.8)
        m_btn_play.addTarget(self, action: #selector(PlayViewController.PlayClick(_:)), forControlEvents: .TouchUpInside)
        self.m_view_tiles_photo.addSubview(m_btn_play)

        //hint one
        var l_btn_hint_one_frm = CGRectMake(0, 0, 0, 0)
        l_btn_hint_one_frm.size.width = l_view_control_heigth
        l_btn_hint_one_frm.size.height = 1.0/3 * l_btn_hint_one_frm.size.width
        let l_space_y = 0.3 * l_btn_hint_one_frm.size.height
        
        l_btn_hint_one_frm.origin.x = 0 - l_btn_hint_one_frm.size.width
        l_btn_hint_one_frm.origin.y = m_view_subheader.frame.origin.y + m_view_subheader.frame.size.height + l_view_control_heigth - l_btn_hint_one_frm.size.height
        m_btn_hint_one = UIButton(frame: l_btn_hint_one_frm)
        m_btn_hint_one.setImage(UIImage(named: "btn_hintone"), forState: UIControlState.Normal)
        m_btn_hint_one.addTarget(self, action: #selector(PlayViewController.HintOneClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
         //bonus ads
        var l_btn_bonus_ads_frm = m_btn_hint_one.frame
        l_btn_bonus_ads_frm.origin.y = m_btn_hint_one.frame.origin.y - l_space_y - l_btn_bonus_ads_frm.size.height
        m_btn_bonus_ads = UIButton(frame: l_btn_bonus_ads_frm)
        m_btn_bonus_ads.setImage(UIImage(named: "btn_bonus"), forState: UIControlState.Normal)
        m_btn_bonus_ads.addTarget(self, action: #selector(PlayViewController.BonusAdsClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //hint full
        var l_btn_hint_full_frm = m_btn_hint_one.frame
        l_btn_hint_full_frm.origin.x = m_view_body.frame.size.width
        m_btn_hint_full = UIButton(frame: l_btn_hint_full_frm)
        m_btn_hint_full.setImage(UIImage(named: "btn_hintfull"), forState: UIControlState.Normal)
        m_btn_hint_full.addTarget(self, action: #selector(PlayViewController.HintFullClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //circle time
        var l_circle_time_frm = m_btn_hint_full.frame
        l_circle_time_frm.size.width = 3.0/4 * imgViewWidth
        l_circle_time_frm.size.height = l_circle_time_frm.size.width
        l_circle_time_frm.origin.x = 0.5 * (m_view_body.frame.size.width - l_circle_time_frm.size.width)
        l_circle_time_frm.origin.y = 0 - self.m_view_header.frame.size.height - l_circle_time_frm.size.height
        m_circle_time = KDCircularProgress(frame: l_circle_time_frm)
        m_circle_time.startAngle = -90
        m_circle_time.trackColor = UIColor.init(white: 1, alpha: 1)
        m_circle_time.setColors(ViewDesign.ShareInstance.COLOR_HEADER_BG, ViewDesign.ShareInstance.COLOR_SUBHEADER_BG)
        
        //
        //self add
        //
        m_view_header.addSubview(m_btn_back)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_title)
        m_view_header.addSubview(m_lbl_coin)
        
        
        self.view.addSubview(m_view_header)
        self.view.addSubview(m_view_body)
        self.view.addSubview(m_view_footer)
        
        m_view_body.addSubview(m_view_subheader)
        m_view_body.addSubview(m_view_tiles_photo)
        m_view_body.addSubview(m_imgv_hintfull_photo)
        m_view_tiles_photo.addSubview(m_imgv_full_photo)
        m_view_body.addSubview(m_btn_bonus_ads)
        m_view_body.addSubview(m_btn_hint_one)
        m_view_body.addSubview(m_btn_hint_full)
        m_view_body.addSubview(m_circle_time)
        
        
    }
    
    func StartGame() -> Void
    {
        self.m_status_game = STATUSGAME.PLAYING
        m_current_time = 0
        if self.m_timer != nil
        {
            self.m_timer.invalidate()
        }
        self.m_timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayViewController.HandleTimer), userInfo: nil, repeats: true)
        //self.m_btn_bonus_ads.enabled = false
    }
    
    func HandlePan(sender: UIPanGestureRecognizer) -> Void
    {
        objc_sync_enter(self)
        
        if m_status_game != STATUSGAME.PLAYING || sender.view?.tag < 0
        {
            return
        }
        
        switch (sender.state)
        {
        case .Began:
            if sender.numberOfTouches() == 1
            {
                //SoundController.ShareInstance.PlaySwap()
                self.m_touched_frm = sender.view?.frame
                sender.view?.layer.borderColor = ViewDesign.ShareInstance.COLOR_HEADER_BG.CGColor
                
                for l_ImgView in self.m_array_tiles
                {
                    if (l_ImgView.tag != sender.view!.tag)
                    {
                        l_ImgView.userInteractionEnabled = false
                    }
                }
            }
            
            break
            
        case .Changed:
            
            let l_translatetion = sender.translationInView(self.m_view_tiles_photo)
            if let l_view = sender.view
            {
                self.m_view_tiles_photo.bringSubviewToFront((sender.view)!)
                l_view.center = CGPoint(x: l_view.center.x + l_translatetion.x, y: l_view.center.y + l_translatetion.y)
                sender.setTranslation(CGPointZero, inView: self.m_view_tiles_photo)
                
                var l_area: CGFloat = 0;
                var l_destination: UIImageView!
                for l_tempIcon in self.m_array_tiles
                {
                    if l_tempIcon.tag == -1
                    {
                        continue
                    }
                    
                    if l_tempIcon.tag != sender.view?.tag
                    {
                        let frm1 = sender.view!.frame
                        let frm2 = l_tempIcon.frame
                        
                        let frmIntersection = CGRectIntersection(frm1, frm2);
                        let l_tempArea = CGRectGetWidth(frmIntersection) * CGRectGetHeight(frmIntersection);
                        if (l_tempArea > l_area)
                        {
                            l_area = l_tempArea
                            l_destination = l_tempIcon
                            self.m_view_tiles_photo.bringSubviewToFront(l_destination)
                            self.m_view_tiles_photo.bringSubviewToFront(sender.view!)
                        }
                    }
                    
                }
                
                if l_destination != nil
                {
                    for l_tempIcon in self.m_array_tiles
                    {
                        if l_tempIcon.tag == -1
                        {
                            continue
                        }
                        
                        l_tempIcon.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
                    }
                    
                    l_destination.layer.borderColor = ViewDesign.ShareInstance.COLOR_HEADER_BG.CGColor
                    sender.view?.layer.borderColor  = ViewDesign.ShareInstance.COLOR_HEADER_BG.CGColor
                }
    
            }
            
    
            break;
            
        case .Ended:
                
            var l_area: CGFloat = 0;
            var l_destination: UIImageView!
            for l_tempIcon in self.m_array_tiles
            {
                if l_tempIcon.tag == -1
                {
                    continue
                }
                
                l_tempIcon.userInteractionEnabled = true
                if l_tempIcon.tag != sender.view?.tag
                {
                    let frm1 = sender.view!.frame
                    let frm2 = l_tempIcon.frame
                    
                    let frmIntersection = CGRectIntersection(frm1, frm2)
                    let l_tempArea = CGRectGetWidth(frmIntersection) * CGRectGetHeight(frmIntersection)
                    if (l_tempArea > l_area)
                    {
                        l_area = l_tempArea
                        l_destination = l_tempIcon
                        self.m_view_tiles_photo.bringSubviewToFront(l_destination)
                        self.m_view_tiles_photo.bringSubviewToFront(sender.view!)
                        
                    }
                }
                
            }
            
            if l_destination != nil
            {
                SoundController.ShareInstance.PlaySwap()
                let l_sender_index = self.m_array_tiles.indexOf(sender.view as! UIImageView)
                let l_dest_index = self.m_array_tiles.indexOf(l_destination)
                if l_sender_index != nil && l_dest_index != nil
                {
                    UIView.animateWithDuration(0.3, animations:{
                        sender.view?.frame = l_destination.frame
                        l_destination.frame = self.m_touched_frm
                        l_destination.Rotation360Degree(0.2)
                        (self.m_array_tiles[l_dest_index!], self.m_array_tiles[l_sender_index!]) = (self.m_array_tiles[l_sender_index!], self.m_array_tiles[l_dest_index!])
                        
                    })
                   
                }
                
            }
            else
            {
                
                UIView.animateWithDuration(0.3, animations:{
                    sender.view?.frame = self.m_touched_frm
                })
            }
            
            if IsCompleted()
            {
                print("completed")
                if (m_current_time < MAX_TIME)
                {
                    self.GameWin()
                }
                else
                {
                    self.GameOver()
                }
            }
            
            break;
            
        default:
            print("Default")
            break;

        }//end switch(sender.state)
        
         objc_sync_exit(self)
    }
    
    
    func IsCompleted() -> Bool
    {
        for i in 0..<m_array_tiles.count
        {
            if self.m_array_tiles[i].tag == -1
            {
                continue
            }
            
            if m_array_tiles[i].tag != i
            {
                //print("tag: \(m_array_tiles[i].tag) and i: \(i)")
                return false
            }
        }
        
        return true
    }
    
    func ShowGameEnd(p_iswin: Bool)
    {
        m_view_footer.hidden = true
        var l_view_gameend: UIView!
        var l_imgv_pre: UIButton!
        var l_imgv_replay: UIButton!
        var l_imgv_next: UIButton!
        var l_lbl_pre: UILabel!
        var m_lbl_replay: UILabel!
        var l_lbl_next: UILabel!
        l_view_gameend = UIView(frame: self.view.frame)
        l_view_gameend.backgroundColor = ViewDesign.ShareInstance.COLOR_BG_WIN
        
        //view result
        self.m_view_tiles_photo.frame.origin.y = self.m_view_tiles_photo.frame.origin.x
        l_view_gameend.addSubview(m_view_tiles_photo)
        
        //congrat
        let l_imgv_congrat_frm = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 0.5)
        let l_imgv_congrat = UIImageView(frame: l_imgv_congrat_frm)
        var l_bg_win = UIImage(named: "bg_win")
        l_bg_win = l_bg_win?.ResizeImage(l_imgv_congrat.frame.size)
        l_imgv_congrat.image = l_bg_win
        //l_view_gameend.addSubview(l_imgv_congrat)
        
        //label hine one
        var l_font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN)!
        var l_frm = CGRectMake(0, 0, 0, 0)
        l_frm.size.width = WidthForText("Hint full:    ", p_font: l_font, p_heigh: 10000)
        l_frm.size.height = HeightForText("Hint full:    ", p_font: l_font, p_width: l_frm.size.width)
        l_frm.origin.x = 0.5 * (l_view_gameend.frame.size.width - 2 * l_frm.size.width)
        l_frm.origin.y =  m_view_tiles_photo.frame.origin.y + m_view_tiles_photo.frame.size.height + 0.5 * m_array_tiles[0].frame.size.height
        let l_lbl_hintone = UILabel(frame: l_frm)
        l_lbl_hintone.font = l_font
        l_lbl_hintone.text = "Hint one:"
        l_lbl_hintone.textAlignment = .Left
        l_lbl_hintone.textColor = UIColor.whiteColor()
        
        let l_1 = UILabel(frame: l_frm)
        l_1.frame.origin.x = l_lbl_hintone.frame.origin.x + l_lbl_hintone.frame.size.width
        l_1.textAlignment = .Right
        l_1.textColor = UIColor.redColor()
        l_1.font = l_lbl_hintone.font
        l_1.text = String(m_number_hintone)
        
        //label hint full
        l_frm.origin.y = l_lbl_hintone.frame.origin.y + l_lbl_hintone.frame.size.height * 2
        let l_lbl_hintfull = UILabel(frame: l_frm)
        l_lbl_hintfull.font = l_lbl_hintone.font
        l_lbl_hintfull.textAlignment = .Left
        l_lbl_hintfull.textColor = l_lbl_hintone.textColor
        l_lbl_hintfull.text = "Hint full:"
        
        let l_2 = UILabel(frame: l_frm)
        l_2.frame.origin.x = l_lbl_hintone.frame.origin.x + l_lbl_hintone.frame.size.width
        l_2.textAlignment = .Right
        l_2.textColor = UIColor.redColor()
        l_2.font = l_lbl_hintone.font
        l_2.text = (m_number_hintfull > 0 ? "yes" : "no")
        
        //label corrected
        
        l_frm.origin.y = l_lbl_hintfull.frame.origin.y + l_lbl_hintfull.frame.size.height * 2
        let l_lbl_corrected = UILabel(frame: l_frm)
        l_lbl_corrected.font = l_lbl_hintone.font
        l_lbl_corrected.textAlignment = .Left
        l_lbl_corrected.textColor = l_lbl_hintone.textColor
        l_lbl_corrected.text = "Corrected:"
        
        
        var l_count = 0
        for (l_index, l_tile) in m_array_tiles.enumerate()
        {
            if l_tile.tag == l_index || l_tile.tag == -1
            {
                l_count = l_count + 1
            }
        }
        let l_3 = UILabel(frame: l_frm)
        l_3.frame.origin.x = l_lbl_hintone.frame.origin.x + l_lbl_hintone.frame.size.width
        l_3.textAlignment = .Right
        l_3.textColor = UIColor.redColor()
        l_3.font = l_lbl_hintone.font
        l_3.text = String(l_count)
        
        
        //pre
        var l_imgv_pre_frm = CGRectMake(0, 0, 0, 0)
        l_imgv_pre_frm.size.width = ViewDesign.ShareInstance.WIDTH_BTN_NEXT
        l_imgv_pre_frm.size.height = l_imgv_pre_frm.size.width
        l_imgv_pre_frm.origin.x = 0.5 * l_imgv_pre_frm.size.width
        l_imgv_pre_frm.origin.y = l_lbl_corrected.frame.origin.y + l_lbl_corrected.frame.size.height + 0.5 * (l_view_gameend.frame.size.height - l_imgv_pre_frm.size.height - l_lbl_corrected.frame.origin.y - l_lbl_corrected.frame.size.height)
        l_imgv_pre = UIButton(frame: l_imgv_pre_frm)
        
        l_imgv_pre.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
        l_imgv_pre.layer.borderWidth = 2.0;
        l_imgv_pre.layer.shadowColor = UIColor.blackColor().CGColor;
        l_imgv_pre.layer.shadowRadius = 3.0;
        l_imgv_pre.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        l_imgv_pre.layer.shadowOpacity = 0.5;
        l_imgv_pre.layer.rasterizationScale = UIScreen.mainScreen().scale;
        l_imgv_pre.layer.shouldRasterize = true;
        
        var l_level = PPCore.ShareInstance.m_level - 1
        if l_level >= 0
        {
            l_imgv_pre.setImage(UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[l_level].m_name), forState: .Normal)
            l_imgv_pre.addTarget(self, action: #selector(PlayViewController.XClick(_:)), forControlEvents: .TouchUpInside)
            l_imgv_pre.tag = l_level
            self.InitImgvLock(l_imgv_pre, p_level: l_level)
        }
        
        l_font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_NEXT)!
        var l_lbl_pre_frm = l_imgv_pre.frame
        l_lbl_pre_frm.size.height = HeightForText("Pre", p_font: l_font, p_width: l_lbl_pre_frm.size.width)
        l_lbl_pre_frm.origin.y  = l_imgv_pre.frame.origin.y + l_imgv_pre.frame.size.height
        l_lbl_pre = UILabel(frame: l_lbl_pre_frm)
        l_lbl_pre.font = l_font
        l_lbl_pre.textColor = UIColor.whiteColor()
        l_lbl_pre.text = "Pre"
        l_lbl_pre.textAlignment = .Center
        
        
        //replay
        var l_imgv_replay_frm = l_imgv_pre.frame
        l_imgv_replay_frm.origin.x = l_imgv_pre.frame.origin.x + l_imgv_pre.frame.size.width + 0.5 * l_imgv_pre.frame.size.width
        l_imgv_replay = UIButton(frame: l_imgv_replay_frm)
        
        l_imgv_replay.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
        l_imgv_replay.layer.borderWidth = 2.0;
        l_imgv_replay.layer.shadowColor = UIColor.blackColor().CGColor;
        l_imgv_replay.layer.shadowRadius = 3.0;
        l_imgv_replay.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        l_imgv_replay.layer.shadowOpacity = 0.5;
        l_imgv_replay.layer.rasterizationScale = UIScreen.mainScreen().scale;
        l_imgv_replay.layer.shouldRasterize = true;
        l_imgv_replay.setImage(UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_name), forState: .Normal)
        l_imgv_replay.addTarget(self, action: #selector(PlayViewController.XClick(_:)), forControlEvents: .TouchUpInside)
        l_imgv_replay.tag = PPCore.ShareInstance.m_level
        self.InitImgvLock(l_imgv_replay, p_level: PPCore.ShareInstance.m_level)
        
        var l_lbl_replay_frm = l_imgv_replay.frame
        l_lbl_replay_frm.size.height = HeightForText("Replay", p_font: l_font, p_width: l_lbl_pre_frm.size.width)
        l_lbl_replay_frm.origin.y  = l_imgv_replay.frame.origin.y + l_imgv_replay.frame.size.height
        m_lbl_replay = UILabel(frame: l_lbl_replay_frm)
        m_lbl_replay.font = l_font
        m_lbl_replay.textColor = UIColor.whiteColor()
        m_lbl_replay.text = "Replay"
        m_lbl_replay.textAlignment = .Center
        
        //next
        var l_imgv_next_frm = l_imgv_replay.frame
        l_imgv_next_frm.origin.x = l_imgv_replay.frame.origin.x + l_imgv_replay.frame.size.width + 0.5 * l_imgv_replay.frame.size.width
        l_imgv_next = UIButton(frame: l_imgv_next_frm)
        l_imgv_next.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
        l_imgv_next.layer.borderWidth = 2.0;
        l_imgv_next.layer.shadowColor = UIColor.blackColor().CGColor;
        l_imgv_next.layer.shadowRadius = 3.0;
        l_imgv_next.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        l_imgv_next.layer.shadowOpacity = 0.5;
        l_imgv_next.layer.rasterizationScale = UIScreen.mainScreen().scale;
        l_imgv_next.layer.shouldRasterize = true;
        l_level = PPCore.ShareInstance.m_level + 1
        if l_level <= PPCore.ShareInstance.m_ArrayPhoto.count
        {
            l_imgv_next.setImage(UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[l_level].m_name), forState: .Normal)
            l_imgv_next.addTarget(self, action: #selector(PlayViewController.XClick(_:)), forControlEvents: .TouchUpInside)
            l_imgv_next.tag = l_level
            self.InitImgvLock(l_imgv_next, p_level: l_level)
        }
        
        var l_lbl_next_frm = l_imgv_next.frame
        l_lbl_next_frm.size.height = HeightForText("Next", p_font: l_font, p_width: l_lbl_pre_frm.size.width)
        l_lbl_next_frm.origin.y  = l_imgv_next.frame.origin.y + l_imgv_next.frame.size.height
        l_lbl_next = UILabel(frame: l_lbl_next_frm)
        l_lbl_next.font = l_font
        l_lbl_next.textColor = UIColor.whiteColor()
        l_lbl_next.text = "Next"
        l_lbl_next.textAlignment = .Center

        //view photo game end
        l_view_gameend.addSubview(l_lbl_hintone)
        l_view_gameend.addSubview(l_1)
        l_view_gameend.addSubview(l_lbl_hintfull)
        l_view_gameend.addSubview(l_2)
        l_view_gameend.addSubview(l_lbl_corrected)
        l_view_gameend.addSubview(l_3)
        
        l_view_gameend.addSubview(l_imgv_pre)
        l_view_gameend.addSubview(l_imgv_replay)
        l_view_gameend.addSubview(l_imgv_next)
        l_view_gameend.addSubview(l_lbl_pre)
        l_view_gameend.addSubview(m_lbl_replay)
        l_view_gameend.addSubview(l_lbl_next)

        l_imgv_pre.Shake()
        l_imgv_replay.Shake()
        l_imgv_next.Shake()
        
        self.view.addSubview(l_view_gameend)
    }
    
    func GameOver() -> Void
    {
        print("Game over")
        SoundController.ShareInstance.PlayGameOver()
        self.m_status_game = STATUSGAME.GAMEOVER
        PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin - COIN_GAME_OVER
        Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
        self.StopTimer()
        self.ShowGameEnd(false)
    }
    
    func GameWin() -> Void
    {
        print("Game win")
        SoundController.ShareInstance.WinCoin()
        
        self.m_status_game = STATUSGAME.GAMEOVER
        PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + COIN_GAME_WIN
        Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        self.StopTimer()
        self.ShowFullPhoto()
        self.UIGetWinCoin()
        
        PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_completed = PHOTO_STATUS.PHOTO_COMPLETED
        Configuration.ShareInstance.WriteComplete(PPCore.ShareInstance.m_level, p_completed: PHOTO_STATUS.PHOTO_COMPLETED.rawValue)
        
        self.ShowGameEnd(false)
    }
    
    func StopTimer()
    {
        if self.m_timer != nil
        {
            self.m_timer.invalidate()
            self.m_timer = nil
        }
        else
        {
            print("Cannot stop timer cuz its nil")
        }
    }
    
    func BackClick(sender: UIButton)
    {
        SoundController.ShareInstance.PlayClick()
        if m_status_game == STATUSGAME.PLAYING
        {
            // Create the alert controller
            let alertController = UIAlertController(title: "Game is playing !", message: "If you back you will lose " + String(COIN_GAME_OVER) + " coins", preferredStyle: .Alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                self.StopTimer()
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin - COIN_GAME_OVER
                if let l_navController = self.navigationController
                {
                    for controller in l_navController.viewControllers
                    {
                        if controller.isKindOfClass(ListPhotoViewController)
                        {
                            let ListPhotoView = controller as! ListPhotoViewController
                            l_navController.popToViewController(ListPhotoView, animated: true)
                        }
                    }
                    
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            StopTimer()
            if let l_navController = self.navigationController
            {
                for controller in l_navController.viewControllers
                {
                    if controller.isKindOfClass(ListPhotoViewController)
                    {
                        let ListPhotoView = controller as! ListPhotoViewController
                        l_navController.popToViewController(ListPhotoView, animated: true)
                    }
                }
                
            }
    
        }
        
    }
    
    
    func BonusAdsClick(sender: UIButton)
    {
        print("BonusAdsClick")
        SoundController.ShareInstance.PlayClick()
        
        if(GADMasterViewController.ShareInstance.ShowInterstitialView(self) == true)
        {
            PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + COIN_BONUS
            m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        }
        else
        {
            ShowToast("Foor internet, try again !")
        }
        
    }
    
    func HintOneClick(sender: UIButton)
    {
        SoundController.ShareInstance.PlayClick()
        
        if m_status_game != STATUSGAME.PLAYING
        {
            return
        }
        
        if (PPCore.ShareInstance.m_coin < COIN_HINT_ONE)
        {
            ShowToast("You don't have enough coin!")
            return
        }

        
        PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin - COIN_HINT_ONE
        m_number_hintone = m_number_hintone + 1
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        

        var l_find: Int! = nil
        for i in 0..<m_array_tiles.count
        {
            if self.m_array_tiles[i].tag == -1
            {
                continue
            }
            
            if m_array_tiles[i].tag != i && l_find == nil
            {
                //print("Found first index fail: \(i)")
                l_find = i
            }
            
            if l_find != nil
            {
                if m_array_tiles[i].tag == l_find
                {
                    //print("Found correct object with index: \(l_find) at index: \(i)")
                    UIView.animateWithDuration(0.3, animations:{
                        
                        self.m_view_tiles_photo.bringSubviewToFront(self.m_array_tiles[l_find])
                        self.m_view_tiles_photo.bringSubviewToFront(self.m_array_tiles[i])
                        self.m_array_tiles[l_find].Rotation360Degree(0.3)
                        self.m_array_tiles[i].Rotation360Degree(0.3)
                        
                        let l_frame = self.m_array_tiles[i].frame
                        self.m_array_tiles[i].frame = self.m_array_tiles[l_find].frame
                        self.m_array_tiles[l_find].frame = l_frame
                        (self.m_array_tiles[l_find], self.m_array_tiles[i]) = (self.m_array_tiles[i], self.m_array_tiles[l_find])
                        
                    })
                    
                    if IsCompleted()
                    {
                        print("completed")
                        if (m_current_time < MAX_TIME)
                        {
                            self.GameWin()
                        }
                        else
                        {
                            self.GameOver()
                        }
                    }
                    
                    self.m_array_tiles[l_find].tag = -1
                    self.m_array_tiles[l_find].layer.borderColor = UIColor.redColor().CGColor
                }
               
            }//end l_fin != nil
        }//end for
        
    }
    
    func HintFullClick(sender: UIButton)
    {
        print("HintFullClick")
        SoundController.ShareInstance.PlayClick()
        
        if m_status_game == STATUSGAME.GAMEOVER
        {
            return
        }
        
        if (PPCore.ShareInstance.m_coin < COIN_HINT_ONE)
        {
            ShowToast("You don't have enough coin!")
            return
        }
        
        
        PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin - COIN_HINT_FULL
        m_number_hintfull = m_number_hintfull + 1
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
    
        
        if m_status_game == STATUSGAME.PREPAREPLAY
        {
            self.StartGame()
        }
        
        var l_imgv_hintfull_frm = m_btn_hint_full.frame
        l_imgv_hintfull_frm.size.height = l_imgv_hintfull_frm.size.width
        l_imgv_hintfull_frm.origin.y = m_view_subheader.frame.origin.y + m_view_subheader.frame.size.height
        
        
        UIView.animateWithDuration(0.5, animations:
        {
            self.m_imgv_hintfull_photo.hidden = false
            self.m_imgv_hintfull_photo.frame = l_imgv_hintfull_frm
            self.m_imgv_hintfull_photo.Rotation360Degree(0.5)
            self.m_view_body.bringSubviewToFront(self.m_imgv_hintfull_photo)
        })

    }
    
    func XClick(sender: UIButton)
    {
       
        if PPCore.ShareInstance.m_ArrayPhoto[sender.tag].m_completed != PHOTO_STATUS.PHOTO_LOCK
        {
            PPCore.ShareInstance.m_level = sender.tag
            sender.superview?.removeFromSuperview()
            self.ClearAllView()
            self.viewDidLoad()
            self.viewDidAppear(true)
        }
        else //if PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_completed == PHOTO_STATUS.PHOTO_LOCK
        {
            //btn coin
            var l_btn_coin_frm = sender.frame
            l_btn_coin_frm.size.height = 0.3 * l_btn_coin_frm.size.width
            l_btn_coin_frm.origin.x = 0
            l_btn_coin_frm.origin.y = sender.frame.size.height - l_btn_coin_frm.size.height
            let m_btn_coin  = UIButton(frame: l_btn_coin_frm)
            m_btn_coin.setImage(UIImage(named: "btn_openphoto"), forState: .Normal)
            m_btn_coin.tag = sender.tag
            m_btn_coin.addTarget(self, action: #selector(PlayViewController.OpenPhoto(_:)), forControlEvents: .TouchUpInside)
            sender.addSubview(m_btn_coin)
            
            m_btn_coin.Shake()
        }
    }
    
    func OpenPhoto(sender: UIButton)
    {
        SoundController.ShareInstance.PlayClick()
        if PPCore.ShareInstance.m_coin < COIN_OPEN_PHOTO
        {
            ShowToast("You don't have enough coin!")
            return
        }

        PPCore.ShareInstance.m_level = sender.tag
        PPCore.ShareInstance.m_array_indexpath_reload.append(NSIndexPath(forItem: PPCore.ShareInstance.m_level, inSection: 0))
        PPCore.ShareInstance.m_ArrayPhoto[PPCore.ShareInstance.m_level].m_completed = PHOTO_STATUS.PHOTO_NOT_COMPLETED
        
        sender.superview?.superview?.removeFromSuperview()
        self.ClearAllView()
        self.viewDidLoad()
        self.viewDidAppear(true)
        
    }
    
    
    func PlayClick(sender: UIButton)
    {
        if m_status_game == STATUSGAME.GAMEOVER
        {
            self.ClearAllView()
            self.viewDidLoad()
            self.viewDidAppear(true)
            
            self.StartGame()
            m_btn_play.hidden = true
            m_imgv_full_photo.hidden = true
            m_btn_hint_one.enabled = true
            m_btn_hint_full.enabled = true
        }
        else
        {
            self.StartGame()
            m_btn_play.hidden = true
            m_imgv_full_photo.hidden = true
            m_btn_hint_one.enabled = true
            m_btn_hint_full.enabled = true
        }
    }
    
    func OKClick(sender: UIButton)
    {
        SoundController.ShareInstance.PlayClick()
        m_btn_bonus_ads.enabled = true
        
        self.m_btn_play.frame.origin.x = 0 - m_btn_play.frame.size.width
        UIView.animateWithDuration(0.4, animations: {
            self.m_circle_time.frame.origin.y = self.m_btn_hint_one.frame.origin.y + self.m_btn_hint_one.frame.size.height - self.m_circle_time.frame.size.height
            
            self.m_btn_play.hidden = false
            self.m_btn_play.frame.origin.x = 0
            self.m_view_tiles_photo.bringSubviewToFront(self.m_btn_play)
        })
        
    }
    
    func HandleTimer()
    {
        if m_current_time != MAX_TIME
        {
            m_current_time = m_current_time + 1
            let newAngleValue = Double(360 * (Double(m_current_time) / Double(MAX_TIME)))
            m_circle_time.animateToAngle(newAngleValue, duration: 0.5, completion: nil)
        }
        else
        {
            StopTimer()
            if IsCompleted()
            {
                GameWin()
            }
            else
            {
                GameOver()
            }
        }
    }
    
    
    func ShowToast(p_title: String)
    {
        var l_frm = CGRectMake(0, 0, 0, 0)
        let l_font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN - 2)!
        
        l_frm.size.width = WidthForText(p_title, p_font: l_font, p_heigh: 1000)
        l_frm.size.width = l_frm.size.width + 0.25 * l_frm.size.width
        l_frm.size.height = HeightForText(p_title, p_font: l_font, p_width: 1000)
        l_frm.size.height = l_frm.size.height + 0.2 * l_frm.size.height
        l_frm.origin.x = 1.0/2 * (self.view.frame.size.width - l_frm.size.width)
        l_frm.origin.y = m_view_subheader.frame.size.height
        let toastLabel = UILabel(frame: l_frm)

        toastLabel.font = l_font
        toastLabel.backgroundColor = UIColor.blackColor()
        toastLabel.textColor = ViewDesign.ShareInstance.COLOR_COIN_TITLE
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.m_view_body.addSubview(toastLabel)
        toastLabel.text = p_title
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animateWithDuration(6.0, delay: 0.2, options: .CurveEaseOut, animations: {
            toastLabel.alpha = 0.0
            }, completion: { (finished: Bool) -> Void in
                toastLabel.removeFromSuperview()
        })
    }
}


extension PlayViewController
{
    func HandlePurchaseNotification(notification: NSNotification)
    {
        guard let productID = notification.object as? String else { return }
        
        for (_, product) in PPCore.ShareInstance.m_products.enumerate()
        {
            guard product.productIdentifier == productID else { continue }
            
            let l_price = Int(ceil(product.price.floatValue))
            switch l_price
            {
            case 2:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 200
                print("Buy ok 200 coin")
                break
            case 3:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 400
                print("Buy ok 400 coin")
                break
            case 4:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 600
                print("Buy ok 600 coin")
                break
            case 5:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 800
                print("Buy ok 800 coin")
                break
            default:
                print("Don't know this price")
                break
            }
            
            SoundController.ShareInstance.WinCoin()
            m_lbl_coin.Shake()
            m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
            m_lbl_coin.frame.size.width = WidthForText(String(PPCore.ShareInstance.m_coin), p_font: m_lbl_coin.font, p_heigh: m_lbl_coin.frame.size.height)
            Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
        }
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
        m_btn_closepurchase.addTarget(self, action: #selector(PlayViewController.CloseClick(_:)), forControlEvents: .TouchUpInside)
        
        
        //2 dollar
        let l_h = m_btn_closepurchase.frame.origin.y - l_lbl_bonus.frame.origin.y - l_lbl_bonus.frame.size.height
        let l_btn_purchase_h = l_h * 1.0 / 5.75
        var l_btn_frm = CGRectMake(0, 0, 0, 0)
        l_btn_frm.size.height = l_btn_purchase_h
        l_btn_frm.size.width = 3 * l_btn_frm.size.height
        l_btn_frm.origin.x = 0.5 * (l_view_purchase.frame.size.width - l_btn_frm.size.width)
        l_btn_frm.origin.y = l_lbl_bonus.frame.origin.y + l_lbl_bonus.frame.size.height + 0.5 * l_btn_frm.size.height
        let l_btn_2dollar = UIButton(frame: l_btn_frm)
        l_btn_2dollar.setImage(UIImage(named: "2dollar"), forState: .Normal)
        l_btn_2dollar.tag = 2
        l_btn_2dollar.addTarget(self, action: #selector(PlayViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //3 dollar
        l_btn_frm.origin.y = l_btn_2dollar.frame.origin.y + 1.25 * l_btn_2dollar.frame.size.height
        let l_btn_3dollar = UIButton(frame: l_btn_frm)
        l_btn_3dollar.setImage(UIImage(named: "3dollar"), forState: .Normal)
        l_btn_3dollar.tag = 3
        l_btn_3dollar.addTarget(self, action: #selector(PlayViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //4 dollar
        l_btn_frm.origin.y = l_btn_3dollar.frame.origin.y + 1.25 * l_btn_3dollar.frame.size.height
        let l_btn_4dollar = UIButton(frame: l_btn_frm)
        l_btn_4dollar.setImage(UIImage(named: "4dollar"), forState: .Normal)
        l_btn_4dollar.tag = 4
        l_btn_4dollar.addTarget(self, action: #selector(PlayViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //5 dollar
        l_btn_frm.origin.y = l_btn_4dollar.frame.origin.y + 1.25 * l_btn_4dollar.frame.size.height
        let l_btn_5dollar = UIButton(frame: l_btn_frm)
        l_btn_5dollar.setImage(UIImage(named: "5dollar"), forState: .Normal)
        l_btn_5dollar.tag = 5
        l_btn_5dollar.addTarget(self, action: #selector(PlayViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        
        l_view_purchase.addSubview(l_btn_2dollar)
        l_view_purchase.addSubview(l_btn_3dollar)
        l_view_purchase.addSubview(l_btn_4dollar)
        l_view_purchase.addSubview(l_btn_5dollar)
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
    
    
    func GetCoin(sender: UIButton)
    {
        for l_product in PPCore.ShareInstance.m_products
        {
            if Int(ceil(l_product.price.floatValue)) == sender.tag
            {
                PPCore.ShareInstance.m_iaphelper.buyProduct(l_product)
                break
            }
        }
        
    }

}
