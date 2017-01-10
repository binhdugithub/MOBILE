//
//  StoryViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/20/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class StoryViewController: UIViewController
{
    var m_Story: Story? = Story()
    var m_IsHomeView: Bool?
  
    var m_AdView        = UIView()
    var m_ControlView   = UIView()
    //var m_ContentView   = UIView()

    var m_BtnAudio      = UIButton()
    var m_BtnFavorite   = UIButton()
    var m_TextView      = UITextView()
    var m_LblTitle      = UILabel()
  
    var m_BtnFB         = UIButton()
    var m_BtnTW         = UIButton()
  
    var m_AudioPlayer: AVAudioPlayer?
  
    var m_AudioLoadIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad()
  {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.tabBarController?.tabBar.hidden = true
      
      
        UIGraphicsBeginImageContext(self.view.frame.size);
        var l_image = UIImage(named: "bg_textview")
        l_image?.drawInRect(self.view.bounds)
        l_image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: l_image!)
      
        InitNavigationHeader()
        InitContentView()
        InitControlView()
        InitAd()
        RefreshStory()
    
        print("Status bar: \(FSDesign.ShareInstance.STATUSBAR_HEIGHT)")
        print("Navigator: \(FSDesign.ShareInstance.NAVIGATOR_HEIGHT)")
        print("textview: \(m_TextView.frame.size.height)")
        print("control: \(m_ControlView.frame.size.height)")
        print("tabbar bar: \(FSDesign.ShareInstance.TABBAR_HEIGHT)")
      
       GADMasterViewController.ShareInstance.ResetBannerView(self, p_ads: self.m_AdView)
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
      
    }
  
  
  func RefreshStory()
  {
    if m_Story == nil
    {
      return
    }
    
    m_AudioPlayer = nil
    
    //title
    m_LblTitle.text = m_Story!.m_title
    
    //content
    let l_content = NSMutableAttributedString(string: "\n\n")
    l_content.appendAttributedString(NSAttributedString(string: self.m_Story!.m_content!))
    let l_EndContent = NSMutableAttributedString(string: "\n\n[End]")
    l_content.appendAttributedString(l_EndContent)
    
    let l_attributeFont = [NSFontAttributeName: UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW)!]
    
    let l_attributeColor = [NSForegroundColorAttributeName: UIColor.blackColor()]
    
    l_content.addAttributes(l_attributeFont, range: NSRange(location: 0,length: l_content.length))
    l_content.addAttributes(l_attributeColor, range: NSRange(location: 0,length: l_content.length))

    
    let l_attachment = NSTextAttachment()
  
      l_attachment.image = self.m_Story!.GetImage()
    
      let l_scale: CGFloat = (CGFloat(400)) / (self.m_TextView.frame.size.width/2)
      l_attachment.image = UIImage(CGImage: l_attachment.image!.CGImage!, scale: l_scale, orientation: .Up)
      let attrStringWithImage = NSAttributedString(attachment: l_attachment)
      l_content.replaceCharactersInRange(NSMakeRange(0, 0), withAttributedString: attrStringWithImage)
      
      self.m_TextView.attributedText = l_content
    

    GADMasterViewController.ShareInstance.ResetInterstitialView(self)
    
    if m_AudioLoadIndicator?.isAnimating() == true
    {
      m_AudioLoadIndicator?.stopAnimating()
    }
    
    //favorite
    if m_Story!.m_liked == true
    {
      m_BtnFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
    }
    else
    {
      m_BtnFavorite.setImage(UIImage(named: "favorite_no"), forState: UIControlState.Normal)
    }

    
  }
//end RefreshStory

  
  
  //init header
  func InitNavigationHeader()
  {
    //self.navigationItem.setHidesBackButton(true, animated: true)
    //self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    self.navigationController!.navigationBar.barStyle = UIBarStyle.Default
    self.navigationController!.navigationBar.backgroundColor = FSDesign.ShareInstance.COLOR_NAV_HEADER_BG
    
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
    l_backButton.addTarget(self, action: #selector(StoryViewController.BackClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: l_backButton)
    
    //title
    //
    m_LblTitle = UILabel()
    m_LblTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController!.navigationBar.frame.size.height)
    m_LblTitle.textAlignment = NSTextAlignment.Center
    m_LblTitle.numberOfLines = 2
    m_LblTitle.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_SIZE_TITLE)
    m_LblTitle.textColor = FSDesign.ShareInstance.COLOR_STORY_TITLE
    self.navigationItem.titleView  = m_LblTitle
    
    //Right button: Share
    //
    let l_RectShare:CGRect = l_backButton.frame
    let l_ShareButton: UIButton = UIButton(frame: l_RectShare)
    l_ShareButton.setTitle("", forState: .Normal)
    l_ShareButton.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
    l_ShareButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    l_ShareButton.addTarget(self, action: #selector(StoryViewController.ShareClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
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
    m_AdView.backgroundColor = FSDesign.ShareInstance.COLOR_CONTROL_BG
    
    var frm = m_AdView.frame;
    frm.origin.x = 0;
    frm.origin.y =  0;
    let l_LblCopyright = UILabel.init(frame: frm)
    l_LblCopyright.textColor = UIColor.blackColor()
    l_LblCopyright.text = TEXT_COPYRIGHT
    l_LblCopyright.textAlignment = .Center
    l_LblCopyright.font = UIFont.systemFontOfSize(CGFloat(FSDesign.ShareInstance.FONT_SIZE_COPYRIGHT))
    
    m_AdView.addSubview(l_LblCopyright)
    self.view.addSubview(m_AdView)
    
  }

 
  func InitContentView()
  {
    var l_rect          = CGRectMake(0, 0, 0, 0)

    //text view
    l_rect.origin.x = FSDesign.ShareInstance.TEXTVIEW_MARGIN//0.5 * (m_ContentView.frame.size.width - l_rect.size.width)
    l_rect.origin.y = FSDesign.ShareInstance.NAVIGATOR_HEIGHT + FSDesign.ShareInstance.STATUSBAR_HEIGHT
    l_rect.size.width = SCREEN_WIDTH - 2 * FSDesign.ShareInstance.TEXTVIEW_MARGIN
    l_rect.size.height = SCREEN_HEIGHT - l_rect.origin.y - FSDesign.ShareInstance.AD_HEIGHT - FSDesign.ShareInstance.ICON_HEIGTH - FSDesign.ShareInstance.ICON_VHSPACE * 2 - 1
  
    m_TextView = UITextView(frame: l_rect)
    m_TextView.textAlignment = NSTextAlignment.Left
    m_TextView.backgroundColor = UIColor.clearColor()
    m_TextView.delegate = self

    print("Frame of content: \(m_TextView.frame)")
    self.view.addSubview(m_TextView)

  }
  
    func InitControlView()
    {

        let l_HSpaceButton: CGFloat = ((SCREEN_WIDTH - 5.0 * FSDesign.ShareInstance.ICON_WIDTH) / 5)
        //Previous button
        var l_rect = CGRectMake(
            0.4 * l_HSpaceButton,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonPrevious = UIButton(frame: l_rect)
        l_UIButtonPrevious.setImage(UIImage(named: "previous"), forState: UIControlState.Normal)
        l_UIButtonPrevious.setTitle("", forState: UIControlState.Normal)
        l_UIButtonPrevious.addTarget(self, action: #selector(StoryViewController.PreviousClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //audio button
//        l_rect = CGRectMake(
//            l_HSpaceButton + l_UIButtonPrevious.frame.size.width + l_UIButtonPrevious.frame.origin.x,
//            FSDesign.ShareInstance.ICON_VHSPACE,
//            FSDesign.ShareInstance.ICON_WIDTH,
//            FSDesign.ShareInstance.ICON_HEIGTH)
//        
//        m_BtnAudio = UIButton(frame: l_rect)
//        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
//        m_BtnAudio.setTitle("", forState: UIControlState.Normal)
      
      
//      
//        //A-
//        l_rect = CGRectMake(
//            l_HSpaceButton + m_BtnAudio.frame.size.width + m_BtnAudio.frame.origin.x,
//            FSDesign.ShareInstance.ICON_VHSPACE,
//            FSDesign.ShareInstance.ICON_WIDTH,
//            FSDesign.ShareInstance.ICON_HEIGTH)
//        
//        let l_UIButtonASub = UIButton(frame: l_rect)
//        l_UIButtonASub.setImage(UIImage(named: "a_sub"), forState: UIControlState.Normal)
//        l_UIButtonASub.setTitle("", forState: UIControlState.Normal)
//        l_UIButtonASub.addTarget(self, action: #selector(StoryViewController.ASubClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      
      
      
      //A-
      l_rect = CGRectMake(
        l_HSpaceButton + l_UIButtonPrevious.frame.size.width + l_UIButtonPrevious.frame.origin.x,
        FSDesign.ShareInstance.ICON_VHSPACE,
        FSDesign.ShareInstance.ICON_WIDTH,
        FSDesign.ShareInstance.ICON_HEIGTH)
      
      let l_UIButtonASub = UIButton(frame: l_rect)
      l_UIButtonASub.setImage(UIImage(named: "a_sub"), forState: UIControlState.Normal)
      l_UIButtonASub.setTitle("", forState: UIControlState.Normal)
      l_UIButtonASub.addTarget(self, action: #selector(StoryViewController.ASubClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      
        //A+
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonASub.frame.size.width + l_UIButtonASub.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonAPlus = UIButton(frame: l_rect)
        l_UIButtonAPlus.setImage(UIImage(named: "a_plus"), forState: UIControlState.Normal)
        l_UIButtonAPlus.setTitle("", forState: UIControlState.Normal)
        l_UIButtonAPlus.addTarget(self, action: #selector(StoryViewController.APlusClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //Favorite
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonAPlus.frame.size.width + l_UIButtonAPlus.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        m_BtnFavorite = UIButton(frame: l_rect)
        m_BtnFavorite.setTitle("", forState: UIControlState.Normal)
        m_BtnFavorite.addTarget(self, action: #selector(StoryViewController.FavoriteClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        if m_Story!.m_liked == true
        {
          m_BtnFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
        }
        else
        {
          m_BtnFavorite.setImage(UIImage(named: "favorite_no"), forState: UIControlState.Normal)
        }
      
        //Next
        l_rect = CGRectMake(
            l_HSpaceButton + m_BtnFavorite.frame.size.width + m_BtnFavorite.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonNext = UIButton(frame: l_rect)
        l_UIButtonNext.setImage(UIImage(named: "next"), forState: UIControlState.Normal)
        l_UIButtonNext.setTitle("", forState: UIControlState.Normal)
        l_UIButtonNext.addTarget(self, action: #selector(StoryViewController.NextClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      
        // indicator
        m_AudioLoadIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        m_AudioLoadIndicator!.frame = m_BtnAudio.frame
        m_AudioLoadIndicator!.hidesWhenStopped = true
        m_AudioLoadIndicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        m_AudioLoadIndicator?.stopAnimating()
        //view Control
        l_rect = CGRectMake(0, 0, SCREEN_WIDTH, FSDesign.ShareInstance.ICON_HEIGTH + 2 * FSDesign.ShareInstance.ICON_VHSPACE)
        l_rect.origin.y    = SCREEN_HEIGHT - l_rect.size.height
      
      
        m_ControlView = UIView(frame: l_rect)
        m_ControlView.backgroundColor = FSDesign.ShareInstance.COLOR_CONTROL_BG
      
        m_ControlView.addSubview(l_UIButtonPrevious)
        m_ControlView.addSubview(m_BtnAudio)
        m_ControlView.addSubview(l_UIButtonAPlus)
        m_ControlView.addSubview(l_UIButtonASub)
        m_ControlView.addSubview(m_BtnFavorite)
        m_ControlView.addSubview(l_UIButtonNext)
        m_ControlView.addSubview(m_AudioLoadIndicator!)
      
        self.view.addSubview(m_ControlView)
    }

  
    // MARK: - Navigation

    func BackClick(sender: UIButton!)
    {
        SoundController.ShareInstance.PlayButton()
      
        if (m_AudioPlayer?.playing == true)
        {
          m_AudioPlayer?.stop()
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
  
     
  
    func PreviousClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
        if m_AudioPlayer?.playing == true
        {
            m_AudioPlayer?.stop()
        }
      
        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
      
        if m_IsHomeView == true
        {
          var l_currentIndex = FSCore.ShareInstance.IndexOfStoryInArrayStory(m_Story!)
          l_currentIndex = (l_currentIndex == 0) ? FSCore.ShareInstance.m_ArrayStory.count - 1 : (l_currentIndex - 1)
          if l_currentIndex >= 0 && FSCore.ShareInstance.m_ArrayStory.count > 0
          {
            m_Story = FSCore.ShareInstance.m_ArrayStory[l_currentIndex]
          }
        }
        else
        {
            m_Story = FSCore.ShareInstance.PreStoryFavorite(m_Story)
        }
      
        RefreshStory()
    }
  
    func NextClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
        if m_AudioPlayer?.playing == true
        {
          m_AudioPlayer?.stop()
        }
      
      
        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
      
        if m_IsHomeView == true
        {
          var l_currentIndex = FSCore.ShareInstance.IndexOfStoryInArrayStory(m_Story!)
          l_currentIndex = (l_currentIndex == (FSCore.ShareInstance.m_ArrayStory.count - 1)) ? 0 : (l_currentIndex + 1)
          if l_currentIndex >= 0 && FSCore.ShareInstance.m_ArrayStory.count > 0
          {
            m_Story = FSCore.ShareInstance.m_ArrayStory[l_currentIndex]
          }
          
          
        }
        else
        {
          m_Story = FSCore.ShareInstance.NextStoryFavorite(m_Story)
          
        }
      
        RefreshStory()
    }
    
    func APlusClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
      FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW += FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
      if FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW > 40
      {
        FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW -= FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
      }
      else
      {
        let l_FontPlus = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW)
        self.m_TextView.SetFont(l_FontPlus!)
      }
      
    }//end APlusClick
  
  
    func ASubClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
        //print("ASub click")
      FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW -= FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
      if FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW < 8
      {
        FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW += FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
      }
      else
      {
        let l_FontPlus = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW)
        self.m_TextView.SetFont(l_FontPlus!)
      }
    }//end ASubClick
  
  
  
    func FavoriteClick(sender: UIButton!)
    {
      SoundController.ShareInstance.PlayButton()
      //print("Favorite click")
      
      if m_Story!.m_liked == true
      {
        m_Story!.m_liked = false
        m_BtnFavorite.setImage(UIImage(named: "favorite_no"), forState: UIControlState.Normal)
      
      }
      else
      {

        m_Story!.m_liked = true
        m_BtnFavorite.setImage(UIImage(named: "favorite_yes"), forState: UIControlState.Normal)
        
      }
      
      
      DBModel.ShareInstance.UpdateFavoriteStory(m_Story!)
    }

  
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
    }
  
  func ShowRate()
  {
    let refreshAlert = UIAlertView()
    refreshAlert.title = "Rate Funny Short Stories"
    refreshAlert.message = "If you enjoy using Funny Short Stories, please take a moment to rate it in the App Store. Thanks for your support!"
    refreshAlert.addButtonWithTitle("Yes, Rate It!")
    refreshAlert.addButtonWithTitle("Remind me later")
    refreshAlert.addButtonWithTitle("No, Thanks")
  
    refreshAlert.show()
    refreshAlert.delegate = self
  }

}

extension StoryViewController : UIAlertViewDelegate
{
  func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
  {
    switch buttonIndex
    {
    case 0://rate
      #if TARGET_IPHONE_SIMULATOR
        print("APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
      #else
      let l_linkapp = "itms-apps://itunes.apple.com/app/id\(YOUR_APP_ID)"
       UIApplication.sharedApplication().openURL(NSURL(string : l_linkapp)!)
      Configuration.ShareInstance.WriteRate(2)
      #endif
      break
    case 1://not remind rate
      print("Remind later")
      Configuration.ShareInstance.m_Rate = 100 // don't want to rate again in a one using app
      break
    case 2:// no thanks
      print("No thank")
      Configuration.ShareInstance.WriteRate(0)
      break
    default:
      print("Don't know what choose")
      break
    }
    
  }
}

extension StoryViewController
{
  func PlayerItemDidReachEnd (p_notify: NSNotification)
  {
    let newTime = CMTimeMakeWithSeconds(0, 1);
    SoundController.ShareInstance.m_PlayerStory?.seekToTime(newTime)
    
    m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)

  }
}

extension StoryViewController: AVAudioPlayerDelegate
{
  func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool)
  {
    print("Play finished")
    m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
    m_AudioPlayer?.currentTime = 0
    
  }
}

extension StoryViewController: UITextViewDelegate
{
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    print("shouldChangeTextInRange")
    return false
  }
  
  func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
    print("shouldInteractWithTextAttachment")
    return false
  }
  
  
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    print("shouldInteractWithURL")
    return false
  }
  
  func textViewShouldBeginEditing(textView: UITextView) -> Bool
  {
      if self.m_ControlView.frame.origin.y > (SCREEN_HEIGHT - 5)
      {
        UIView.animateWithDuration(0.4, animations:
        {
          var l_frame = self.m_ControlView.frame
          l_frame.origin.y = l_frame.origin.y - l_frame.size.height
          self.m_ControlView.frame = l_frame
          
          l_frame = self.m_AdView.frame
          l_frame.origin.y = l_frame.origin.y - self.m_ControlView.frame.size.height
          self.m_AdView.frame = l_frame
          
          l_frame = self.m_TextView.frame
          l_frame.size.height = l_frame.size.height - self.m_ControlView.frame.size.height
          self.m_TextView.frame = l_frame
        })
        
        
      }
      else
      {
        UIView.animateWithDuration(0.4, animations:
        {
          var l_frame = self.m_ControlView.frame
          l_frame.origin.y = l_frame.origin.y + l_frame.size.height
          self.m_ControlView.frame = l_frame
          
          l_frame = self.m_AdView.frame
          l_frame.origin.y = l_frame.origin.y + self.m_ControlView.frame.size.height
          self.m_AdView.frame = l_frame
          
          l_frame = self.m_TextView.frame
          l_frame.size.height = l_frame.size.height + self.m_ControlView.frame.size.height
          self.m_TextView.frame = l_frame
        })
        
      }
    
    return false
  }
  
  func textViewShouldEndEditing(textView: UITextView) -> Bool
  {
    //print("textViewShouldEndEditing")
    return false
  }

}
