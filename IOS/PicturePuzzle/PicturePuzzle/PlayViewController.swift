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

enum STATEGAME
{
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
    var m_btn_home: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_level: UILabel!
    
    var m_view_tiles_photo: UIView!
    var m_view_full_photo: UIView!
    
    //variable 
    var m_array_tiles: [UIImageView]!
    var m_photo_index: Int!
    var m_photo_img: UIImage!
    var m_state: Int!
    var m_time: Int!
    var m_lock: NSLock!
    var m_is_touched: Bool!
    var m_touched_frm: CGRect!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.m_array_tiles = [UIImageView]()
        self.m_lock = NSLock()
        self.m_is_touched = false
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SetupView()
        SetupVariable()
        RandomPhoto()
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func SetupVariable() -> Void
    {
        let l_size: Int = NUMBER_V_ITEM * NUMBER_H_ITEM;
        let imgViewWidth: CGFloat = m_view_tiles_photo.frame.size.width / CGFloat(NUMBER_H_ITEM);
        let imgViewHeight:CGFloat = m_view_tiles_photo.frame.size.height / CGFloat(NUMBER_V_ITEM);
        for _ in 0..<l_size
        {
            var frmImgView: CGRect = CGRectMake(0, 0, 0, 0)
            frmImgView.size.width = imgViewWidth;
            frmImgView.size.height = imgViewHeight;
            
            let l_ImgView = UIImageView(frame: frmImgView)
            l_ImgView.layer.borderWidth = 1
            l_ImgView.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
            l_ImgView.userInteractionEnabled = true;
            l_ImgView.multipleTouchEnabled = false;
            let l_Pan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PlayViewController.HandlePan(_:)))
            l_ImgView.addGestureRecognizer(l_Pan)
            
            self.m_array_tiles.append(l_ImgView)
            self.m_view_tiles_photo.addSubview(l_ImgView)
        }
    }
    
    
    func RandomPhoto() -> Void
    {
        let l_size: Int = (NUMBER_V_ITEM * NUMBER_H_ITEM)
        let imgWidth: CGFloat = m_array_tiles[0].frame.size.width
        let imgheight = imgWidth
    
        m_photo_img = ResizeImage(UIImage(named: PPCore.ShareInstance.m_ArrayPhoto[m_photo_index].m_name)!, targetSize: m_view_tiles_photo.frame.size)
        
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
            let MyImgView: UIImageView = m_array_tiles[i];
            var l_frm: CGRect = MyImgView.frame;
            let l_x: CGFloat = CGFloat(i % NUMBER_H_ITEM) * l_frm.size.width;
            let l_y: CGFloat = CGFloat(i / NUMBER_V_ITEM) * l_frm.size.height;
            l_frm.origin.x = l_x;
            l_frm.origin.y = l_y;
            MyImgView.frame = l_frm;
        }

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
        
        //
        //footer view
        //
        var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_footer_frm.size.width = SCREEN_WIDTH
        l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
        l_view_footer_frm.origin.x = 0
        l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
        m_view_footer = UIView(frame: l_view_footer_frm)
        m_view_footer.backgroundColor = ViewDesign.ShareInstance.COLOR_FOOTER_BG
        
        
        //
        //body view
        //
        var l_view_body_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_body_frm.size.width = SCREEN_WIDTH
        l_view_body_frm.size.height = SCREEN_HEIGHT - m_view_header.frame.size.height - m_view_footer.frame.size.height
        l_view_body_frm.origin.x = 0
        l_view_body_frm.origin.y = m_view_header.frame.origin.y + m_view_header.frame.size.height
        m_view_body = UIView(frame: l_view_body_frm)
        m_view_body.backgroundColor = ViewDesign.ShareInstance.COLOR_BODY_BG
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = SCREEN_WIDTH
        l_view_subheader_frm.size.height = ViewDesign.ShareInstance.HEIGHT_SUBHEADER
        
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
        //view photo 
        var l_view_tiles_photo_frm = CGRectMake(0, 0, 0, 0)
        l_view_tiles_photo_frm.size.width = ViewDesign.ShareInstance.WIDTH_VIEW_PHOTO
        l_view_tiles_photo_frm.size.height = l_view_tiles_photo_frm.size.width
        l_view_tiles_photo_frm.origin.x = 1.0/2 * (m_view_body.frame.size.width - l_view_tiles_photo_frm.size.width)
        l_view_tiles_photo_frm.origin.y = 1.0/2 * (m_view_body.frame.size.height - l_view_tiles_photo_frm.size.height)
        m_view_tiles_photo = UIView(frame: l_view_tiles_photo_frm)
        m_view_tiles_photo.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        //m_view_tiles_photo.layer.borderWidth = 0.01 * ViewDesign.ShareInstance.WIDTH_VIEW_PHOTO
        
    
        //
        //self add
        //
        m_view_header.addSubview(m_btn_home)
        //m_view_header.addSubview(m_btn_ads)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_level)
        
        self.view.addSubview(m_view_header)
        self.view.addSubview(m_view_body)
        m_view_body.addSubview(m_view_subheader)
        m_view_body.addSubview(m_view_tiles_photo)
        self.view.addSubview(m_view_footer)
    }
    
    
    func HandlePan(sender: UIPanGestureRecognizer) -> Void
    {
        self.m_lock.tryLock()
        switch (sender.state)
        {
        case .Began:
            
            //NSLog(@"UIGestureRecognizerStateBegan");
            if m_is_touched == true
            {
                break
            }
            else
            {
                m_is_touched = true
                sender.view?.layer.borderColor = UIColor.blackColor().CGColor
                if sender.numberOfTouches() == 1
                {
                    self.m_touched_frm = sender.view?.frame
                    
                    for l_ImgView in self.m_array_tiles
                    {
                        if (l_ImgView.tag != sender.view!.tag)
                        {
                            l_ImgView.userInteractionEnabled = false
                        }
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
                        }
                    }
                    
                }
                
                if l_destination != nil
                {
                    for l_tempIcon in self.m_array_tiles
                    {
                        l_tempIcon.layer.borderColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG.CGColor
                    }
                    
                    l_destination.layer.borderColor = UIColor.redColor().CGColor
                    sender.view?.layer.borderColor = UIColor.redColor().CGColor
                }
    
            }
            
            
            break;
            
        case .Ended:
                
            var l_area: CGFloat = 0;
            var l_destination: UIImageView!
            for l_tempIcon in self.m_array_tiles
            {
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
                        
                    }
                }
                
            }
            
            if l_destination != nil
            {
                UIView.animateWithDuration(0.3, animations:{
                    sender.view?.frame = l_destination.frame
                    l_destination.frame = self.m_touched_frm
                    
                    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                    rotateAnimation.fromValue = 0.0
                    rotateAnimation.toValue = CGFloat(M_PI * 2.0)
                    rotateAnimation.duration = 0.5
                    l_destination.layer.addAnimation(rotateAnimation, forKey: nil)
                    
                })
                
            }
            else
            {
                
                UIView.animateWithDuration(0.3, animations:{
                    sender.view?.frame = self.m_touched_frm
                })
            }
            
            
            m_is_touched = false
            
            break;
            
        default:
            print("Default")
            break;

        }//end switch(sender.state)
        
        self.m_lock.unlock()
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
