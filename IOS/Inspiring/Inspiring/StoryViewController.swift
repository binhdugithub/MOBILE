//
//  StoryViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/20/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation

class StoryViewController: UIViewController
{
    var m_Story: Story = Story()
    var m_AdView        = UIView()
    var m_ControlView   = UIView()
    var m_ContentView   = UIView()

    var m_LblTitle      = UILabel()
    var m_BtnFavorite   = UIButton()
    var m_BtnFB         = UIButton()
    var m_BtnTW         = UIButton()
    
    var m_IsLiked:Bool = false
    
    var m_UIImage         = UIImageView()
  
  override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.tabBarController?.tabBar.hidden = true
        InitNavigationHeader()
        InitControlView()
        InitAd()
        InitContentView()
        RefreshStory()
        self.view.bringSubviewToFront(self.m_AdView)
      
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        GADMasterViewController.ShareInstance.ResetBannerView(self, p_ads: self.m_AdView)
        //self.m_AdView.hidden = true
        
        m_LblTitle.text = "Inspiring & Positive Quotes"
        m_IsLiked = m_Story.m_liked!
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
  
  
  
  func RefreshStory()
  {
    FSCore.ShareInstance.m_ReadingCount += 1
    if (FSCore.ShareInstance.m_ReadingCount == 4)
    {
      FSCore.ShareInstance.m_ReadingCount = 0
      GADMasterViewController.ShareInstance.ResetInterstitialView(self)
    }
  }
  
  
  //init header
  func InitNavigationHeader()
  {
    //self.navigationItem.setHidesBackButton(true, animated: true)
    //self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    //self.navigationController!.navigationBar.barStyle = UIBarStyle.Default
    //self.navigationController!.navigationBar.backgroundColor = FSDesign.ShareInstance.COLOR_NAV_HEADER_BG
    self.navigationController!.navigationBar.barTintColor = UIColor.blackColor()
    //self.navigationController!.navigationBar.translucent = false
    
    //Left button: back button
    //
    let l_rect:CGRect = CGRectMake(
      0,
      0,
      self.navigationController!.navigationBar.frame.size.height - 4,
      self.navigationController!.navigationBar.frame.size.height - 4)
    
    let l_backButton: UIButton = UIButton(frame: l_rect)
    l_backButton.setTitle("", forState: .Normal)
    l_backButton.setImage(UIImage(named: "back_home"), forState: UIControlState.Normal)
    l_backButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    l_backButton.addTarget(self, action: "BackClick:", forControlEvents: UIControlEvents.TouchUpInside)
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: l_backButton)
    
    //title
    //
    m_LblTitle = UILabel()
    m_LblTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController!.navigationBar.frame.size.height)
    m_LblTitle.textAlignment = NSTextAlignment.Center
    m_LblTitle.numberOfLines = 2
    m_LblTitle.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_SIZE_TITLE)
    m_LblTitle.textColor = UIColor.whiteColor()
    self.navigationItem.titleView  = m_LblTitle
    
    //Right button: Share
    //
    let l_RectShare:CGRect = l_backButton.frame
    let l_ShareButton: UIButton = UIButton(frame: l_RectShare)
    l_ShareButton.setTitle("", forState: .Normal)
    l_ShareButton.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
    l_ShareButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    l_ShareButton.addTarget(self, action: "ShareClick:", forControlEvents: UIControlEvents.TouchUpInside)
    let l_ShareBarButton = UIBarButtonItem(customView: l_ShareButton)
    
    self.navigationItem.rightBarButtonItem = l_ShareBarButton
    
  }
  
  
  func InitAd()
  {
    var l_rect          = CGRectMake(0, 0, 0, 0)
    l_rect.origin.x     = 0
    l_rect.size.width   = SCREEN_WIDTH
    l_rect.size.height  = FSDesign.ShareInstance.AD_HEIGHT
    l_rect.origin.y     = m_ControlView.frame.origin.y - l_rect.size.height - 1
    m_AdView = UIView(frame: l_rect)
    m_AdView.backgroundColor = UIColor.blackColor()//FSDesign.ShareInstance.COLOR_CONTROL_BG
    
    var frm = m_AdView.frame;
    frm.origin.x = 0;
    frm.origin.y =  0;
    let l_LblCopyright = UILabel.init(frame: frm)
    l_LblCopyright.textColor = UIColor.whiteColor()
    //l_LblCopyright.text = TEXT_COPYRIGHT
    l_LblCopyright.textAlignment = .Center
    l_LblCopyright.font = UIFont.systemFontOfSize(CGFloat(FSDesign.ShareInstance.FONT_SIZE_COPYRIGHT))
    
    m_AdView.addSubview(l_LblCopyright)
    self.view.addSubview(m_AdView)
    
  }

 
  func InitContentView()
  {
    var l_rect          = CGRectMake(0, 0, 0, 0)
    l_rect.origin.x     = 0
    l_rect.size.width   = SCREEN_WIDTH
    l_rect.origin.y     = FSDesign.ShareInstance.NAVI_HEIGHT
    l_rect.size.height  = m_AdView.frame.origin.y - l_rect.origin.y + m_ControlView.frame.size.height
    
    m_ContentView = UIView(frame: l_rect)
    m_ContentView.backgroundColor = FSDesign.ShareInstance.COLOR_CONTENT_BG
    

    
    //Facebook button
    m_BtnFB.backgroundColor = UIColor.clearColor()
    m_BtnFB.setImage(UIImage(named: "fb"), forState: UIControlState.Normal)
    m_BtnFB.setTitle("", forState: UIControlState.Normal)
    m_BtnFB.addTarget(self, action: "FBClick:", forControlEvents: UIControlEvents.TouchUpInside)
    
    m_BtnFB.setTitleColor(UIColor.whiteColor(), forState: .Normal)

    
    //Twitter button
    var l_frmtw = m_BtnFB.frame
    l_frmtw.origin.x += l_frmtw.size.width + 10
    m_BtnTW.frame = l_frmtw
    m_BtnTW.backgroundColor = UIColor.clearColor()
    m_BtnTW.setImage(UIImage(named: "tw"), forState: UIControlState.Normal)
    m_BtnTW.setTitle("", forState: .Normal)
    m_BtnTW.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    m_BtnTW.addTarget(self, action: "TWClick:", forControlEvents: UIControlEvents.TouchUpInside)
  
    //UIImage
    var l_frmimg = m_ContentView.frame
    l_frmimg.origin.x = 0
    l_frmimg.origin.y = 0
    l_frmimg.size.width = SCREEN_WIDTH
    let boundingRect =  CGRect(x: 0, y: 0, width: l_frmimg.size.width, height: CGFloat(MAXFLOAT))
    if let l_image = m_Story.m_image
    {
        let image = UIImage(data: l_image)?.decompressedImage
        let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, boundingRect)
        
        l_frmimg.size.height = rect.size.height
        
        m_UIImage.frame = l_frmimg
        m_UIImage.image = UIImage(data: l_image)
    }
 
    m_ContentView.addSubview(m_UIImage)
    self.view.addSubview(m_ContentView)
  }
  
    func InitControlView()
    {

        let l_x: CGFloat = ((SCREEN_WIDTH -  FSDesign.ShareInstance.ICON_WIDTH) / 2)
        var l_rect = CGRectMake(
            l_x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        m_BtnFavorite = UIButton(frame: l_rect)
        m_BtnFavorite.setTitle("", forState: UIControlState.Normal)
        m_BtnFavorite.addTarget(self, action: "FavoriteClick:", forControlEvents: UIControlEvents.TouchUpInside)
        if m_Story.m_liked == true
        {
          m_BtnFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
        }
        else
        {
          m_BtnFavorite.setImage(UIImage(named: "favorite_no"), forState: UIControlState.Normal)
        }
        
        //view Control
        l_rect = CGRectMake(0, 0, SCREEN_WIDTH, FSDesign.ShareInstance.ICON_HEIGTH + 2 * FSDesign.ShareInstance.ICON_VHSPACE)
        l_rect.origin.y    = SCREEN_HEIGHT - l_rect.size.height
        
        m_ControlView = UIView(frame: l_rect)
        m_ControlView.addSubview(m_BtnFavorite)
        
        m_ControlView.backgroundColor = FSDesign.ShareInstance.COLOR_CONTROL_BG
        self.view.addSubview(m_ControlView)
    }

  
    // MARK: - Navigation

    func BackClick(sender: UIButton!)
    {
        SoundController.ShareInstance.PlayButton()
      
        if m_IsLiked == true
        {
            if m_Story.m_liked == false
            {
                var i = 0
                for x_story in FSCore.ShareInstance.m_ArrayFavorite
                {
                    if x_story.m_imageurl == m_Story.m_imageurl
                    {
                        FSCore.ShareInstance.m_ArrayFavorite.removeAtIndex(i)
                        break
                    }
                    
                    i++
                }
            }
            
        }
        else
        {
            if m_Story.m_liked == true
            {
                FSCore.ShareInstance.m_ArrayFavorite.append(m_Story.Copy())
            }
        }
        
        for x_story in FSCore.ShareInstance.m_ArrayImage
        {
            if x_story.m_imageurl == m_Story.m_imageurl
            {
                x_story.m_liked = m_Story.m_liked
                break
            }
        }
        
        
        
        
        
        
        if let l_navController = self.navigationController
        {
          for controller in l_navController.viewControllers
          {
            if controller.isKindOfClass(HomeViewController)
            {
              let HomeView: HomeViewController = controller as! HomeViewController
              l_navController.popToViewController(HomeView, animated: true)
            }
            
            if controller.isKindOfClass(FavoriteViewController)
            {
              let FavoriteView: FavoriteViewController = controller as! FavoriteViewController
              l_navController.popToViewController(FavoriteView, animated: true)
   
            }
          }
          
        }
    }
  
    
    func ShareClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
        //print("Share click")
      
      #if TARGET_IPHONE_SIMULATOR
        print("APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
      #else
        
        var l_link = String("itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=") + String(YOUR_APP_ID);

        print("Version: \(VERSION)")
        if (Float(VERSION) >= 7.0)
        {
          print("VAo day");
          l_link = String("itms-apps://itunes.apple.com/app/id") + String(YOUR_APP_ID);
        }
        
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:MyApp]];
      #endif
      
      let l_image = ScreenShot()
      var shareItems: NSArray?
      
      if let l_MyAppWebsite = NSURL(string: l_link)
      {
        print("\(l_MyAppWebsite)")
        //shareItems = [l_MyAppWebsite, l_image]
        shareItems = [l_image]
      }
      else
      {
        shareItems = [l_image]
      }
      
      let l_ActivityVC: UIActivityViewController = UIActivityViewController(activityItems:shareItems as! [AnyObject], applicationActivities:nil)

      
      l_ActivityVC.setValue("Funny Stories", forKey: "Subject")
      
      l_ActivityVC.completionWithItemsHandler = {(activity, success, items, error) in
        print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
      }
      
      self.presentViewController(l_ActivityVC, animated: true, completion: nil)
      
      //        l_ActivityVC.excludedActivityTypes = [
      //                      UIActivityTypeAirDrop,
      //                      UIActivityTypePostToFacebook,
      //                      UIActivityTypePostToTwitter,
      //                      UIActivityTypePostToVimeo,
      //                      UIActivityTypePostToWeibo,
      //                      UIActivityTypePostToFlickr
      //              ]
      
    }
  
    func FBClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
      print("FB Click")
      UIApplication.sharedApplication().openURL(NSURL(string: URL_FB)!)
    }
    
    func TWClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
      print("TW Click")
      UIApplication.sharedApplication().openURL(NSURL(string: URL_TW)!)
    }
  
  
    func FavoriteClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
      //print("Favorite click")
      
      if m_Story.m_liked == true
      {
        m_Story.m_liked = false
        m_BtnFavorite.setImage(UIImage(named: "favorite_no"), forState: UIControlState.Normal)
      }
      else
      {
        m_Story.m_liked = true
        m_BtnFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
      }
        
      
    }

    func AudioClick(sender: UIButton!)
    {
       
    }
  
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("hhee")
     
    }
}

