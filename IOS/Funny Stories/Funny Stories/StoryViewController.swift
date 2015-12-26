//
//  StoryViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/20/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController
{
     var m_CellRow: Int = 0
    
    var m_AdView        = UIView()
    var m_ControlView   = UIView()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.hidden = true
        InitNavigationHeader()
        InitViewControl()
        InitAd()
        
       GADMasterViewController.ShareInstance.ResetBannerView(self, p_frame: m_AdView.frame)
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
 
   
    func InitAd()
    {
        var l_rect          = CGRectMake(0, 0, 0, 0)
        l_rect.origin.x     = 0
        l_rect.size.width   = SCREEN_WIDTH
        l_rect.size.height  = FSDesign.ShareInstance.AD_HEIGHT
        l_rect.origin.y     = m_ControlView.frame.origin.y - l_rect.size.height
        m_AdView = UIView(frame: l_rect)
    }
    
    func InitViewControl()
    {

        let l_HSpaceButton: CGFloat = ((SCREEN_WIDTH - 6.0 * FSDesign.ShareInstance.ICON_WIDTH) / 6)
        //Previous button
        var l_rect = CGRectMake(
            0.5 * l_HSpaceButton,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonPrevious = UIButton(frame: l_rect)
        l_UIButtonPrevious.setImage(UIImage(named: "previous"), forState: UIControlState.Normal)
        l_UIButtonPrevious.setTitle("", forState: UIControlState.Normal)
        l_UIButtonPrevious.addTarget(self, action: "PreviousClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //audio button
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonPrevious.frame.size.width + l_UIButtonPrevious.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonAudio = UIButton(frame: l_rect)
        l_UIButtonAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
        l_UIButtonAudio.setTitle("", forState: UIControlState.Normal)
        l_UIButtonAudio.addTarget(self, action: "AudioClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //A+
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonAudio.frame.size.width + l_UIButtonAudio.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonAPlus = UIButton(frame: l_rect)
        l_UIButtonAPlus.setImage(UIImage(named: "a_plus"), forState: UIControlState.Normal)
        l_UIButtonAPlus.setTitle("", forState: UIControlState.Normal)
        l_UIButtonAPlus.addTarget(self, action: "APlusClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //A-
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonAPlus.frame.size.width + l_UIButtonAPlus.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonASub = UIButton(frame: l_rect)
        l_UIButtonASub.setImage(UIImage(named: "a_sub"), forState: UIControlState.Normal)
        l_UIButtonASub.setTitle("", forState: UIControlState.Normal)
        l_UIButtonASub.addTarget(self, action: "ASubClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Favorite
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonASub.frame.size.width + l_UIButtonASub.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonFavorite = UIButton(frame: l_rect)
        l_UIButtonFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
        l_UIButtonFavorite.setTitle("", forState: UIControlState.Normal)
        l_UIButtonFavorite.addTarget(self, action: "FavoriteClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Next
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonFavorite.frame.size.width + l_UIButtonFavorite.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonNext = UIButton(frame: l_rect)
        l_UIButtonNext.setImage(UIImage(named: "next"), forState: UIControlState.Normal)
        l_UIButtonNext.setTitle("", forState: UIControlState.Normal)
        l_UIButtonNext.addTarget(self, action: "NextClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //view Control
        l_rect = CGRectMake(0, 0, SCREEN_WIDTH, FSDesign.ShareInstance.ICON_HEIGTH + 2 * FSDesign.ShareInstance.ICON_VHSPACE)
        l_rect.origin.y    = SCREEN_HEIGHT - l_rect.size.height
        
        m_ControlView = UIView(frame: l_rect)
        
        m_ControlView.addSubview(l_UIButtonPrevious)
        m_ControlView.addSubview(l_UIButtonAudio)
        m_ControlView.addSubview(l_UIButtonAPlus)
        m_ControlView.addSubview(l_UIButtonASub)
        m_ControlView.addSubview(l_UIButtonFavorite)
        m_ControlView.addSubview(l_UIButtonNext)
        
        self.view.addSubview(m_ControlView)
    }

    //init header
    func InitNavigationHeader()
    {
        //self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
       
        
        //Left button: back button
        //
        let l_rect:CGRect = CGRectMake(
            0,
            0,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_backButton: UIButton = UIButton(frame: l_rect)
        l_backButton.setTitle("", forState: .Normal)
        l_backButton.setImage(UIImage(named: "back_home"), forState: UIControlState.Normal)
        l_backButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        l_backButton.addTarget(self, action: "PopCurrentViewController:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: l_backButton)
        
        //title
        //
        let l_UILableTitle: UILabel? = UILabel()
        l_UILableTitle!.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController!.navigationBar.frame.size.height)
        l_UILableTitle!.textAlignment = NSTextAlignment.Center
        l_UILableTitle!.numberOfLines = 2
        l_UILableTitle!.font = UIFont.systemFontOfSize(15)
        
        l_UILableTitle!.textColor = UIColor.redColor()
        l_UILableTitle!.text = FSCore.ShareInstance.m_ArrayStory[m_CellRow]["title"] as? String
        
        self.navigationItem.titleView  = l_UILableTitle
        
        
        //Right button: Share
        //
        let l_RectShare:CGRect = CGRectMake(
            0,
            0,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        let l_ShareButton: UIButton = UIButton(frame: l_RectShare)
        l_ShareButton.setTitle("", forState: .Normal)
        l_ShareButton.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
        l_ShareButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        l_ShareButton.addTarget(self, action: "ShareClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let l_ShareBarButton = UIBarButtonItem(customView: l_ShareButton)
       
        self.navigationItem.rightBarButtonItem = l_ShareBarButton
        
    }
    
    
    // MARK: - Navigation

    func PopCurrentViewController(sender: UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func ShareClick(sender: UIButton!)
    {
        print("Share click")
    }
    
    
    func PreviousClick(sender: UIButton!)
    {
        print("Previous click")
    }
    
    func NextClick(sender: UIButton!)
    {
        print("Next click")
    }
    
    func APlusClick(sender: UIButton!)
    {
        print("Aplus click")
    }
    
    func ASubClick(sender: UIButton!)
    {
        print("ASub click")
    }
    
    func FavoriteClick(sender: UIButton!)
    {
        print("Favorite click")
    }
    
    func AudioClick(sender: UIButton!)
    {
        print("Audio click")
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
