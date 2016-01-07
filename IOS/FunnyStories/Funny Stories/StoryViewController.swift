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
    var m_Row: Int?
  
    var m_AdView        = UIView()
    var m_ControlView   = UIView()
    var m_ContentView   = UIView()

    var m_BtnAudio      = UIButton()
    var m_TextView      = UITextView()
    var m_LblTitle      = UILabel()
  
    var m_CurrentTextViewFontSize: CGFloat?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.tabBarController?.tabBar.hidden = true
        InitNavigationHeader()
        InitControlView()
        InitAd()
        InitContentView()
        RepreshStory()
        
       //GADMasterViewController.ShareInstance.ResetBannerView(self, p_frame: m_AdView.frame)
      
      
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        GADMasterViewController.ShareInstance.ResetBannerView(self, p_ads: self.m_AdView)
    }
  
  
  
  func RepreshStory()
  {
    //title
    m_LblTitle.text = m_Story.m_title
    
    //content
    let l_content = NSMutableAttributedString(string: "\n\n     ")
    l_content.appendAttributedString(NSAttributedString(string: self.m_Story.m_content!))
    let l_EndContent = NSMutableAttributedString(string: "\n\n[CUSIKI]")
    l_content.appendAttributedString(l_EndContent)
    
    let l_attributeFont = [NSFontAttributeName: UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW)!]
    let l_attributeColor = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    l_content.addAttributes(l_attributeFont, range: NSRange(location: 0,length: l_content.length))
    l_content.addAttributes(l_attributeColor, range: NSRange(location: 0,length: l_content.length))
    
    
//    let attributes = [
//      NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 12.0)!,
//      NSUnderlineStyleAttributeName : 1,
//      NSForegroundColorAttributeName : UIColor.darkGrayColor(),
//      NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
//      NSStrokeWidthAttributeName : 3.0]
//    
//    var atriString = NSAttributedString(string: "My Attributed String", attributes: attributes)
    
    let l_attachment = NSTextAttachment()
    
    if self.m_Story.m_image != nil
    {
      let l_image = UIImage(data: self.m_Story.m_image!)
      l_attachment.image = l_image
      
      
//      let imageView = UIImageView(image: l_image)
//      imageView.frame.origin.x = 1.0/2 * (m_TextView.frame.size.width - imageView.frame.size.width)
//      imageView.frame.origin.y = 0
//      imageView.frame.size.width = (l_image?.size.width)!
//      imageView.frame.size.height = (l_image?.size.height)!
//      imageView.layer.borderWidth = 1.0
//      imageView.layer.masksToBounds = false
//      imageView.layer.borderColor = UIColor.whiteColor().CGColor
//      imageView.layer.cornerRadius = 5
//      imageView.clipsToBounds = true
//      
//      
//      let path = UIBezierPath(rect: CGRectMake(0, 0, m_TextView.frame.width, imageView.frame.size.height))
//      m_TextView.textContainer.exclusionPaths = [path]
//      m_TextView.addSubview(imageView)
//      
//      let path2 = UIBezierPath(rect: CGRectMake(0, 0, m_TextView.frame.width, 100))
//      m_TextView.textContainer.exclusionPaths = [path2]
      //m_TextView.text = l_content.string
      
      

    }
    else
    {
      l_attachment.image = UIImage(named: "story_default")
    }

    let l_scale: CGFloat = (l_attachment.image?.size.width)! / (m_TextView.frame.size.width/3)
    l_attachment.image = UIImage(CGImage: l_attachment.image!.CGImage!, scale: l_scale, orientation: .Up)
    let attrStringWithImage = NSAttributedString(attachment: l_attachment)
    l_content.replaceCharactersInRange(NSMakeRange(0, 0), withAttributedString: attrStringWithImage)
    m_TextView.attributedText = l_content
    
  }
  
  
  //init header
  func InitNavigationHeader()
  {
    //self.navigationItem.setHidesBackButton(true, animated: true)
    //self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    self.navigationController!.navigationBar.barStyle = UIBarStyle.Default
    self.navigationController!.navigationBar.backgroundColor = UIColor.brownColor()
    
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
    m_LblTitle = UILabel()
    m_LblTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.navigationController!.navigationBar.frame.size.height)
    m_LblTitle.textAlignment = NSTextAlignment.Center
    m_LblTitle.numberOfLines = 2
    m_LblTitle.font = UIFont.systemFontOfSize(15)
    m_LblTitle.textColor = UIColor.blackColor()
    self.navigationItem.titleView  = m_LblTitle
    
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
  
  
  func InitAd()
  {
    var l_rect          = CGRectMake(0, 0, 0, 0)
    l_rect.origin.x     = 0
    l_rect.size.width   = SCREEN_WIDTH
    l_rect.size.height  = FSDesign.ShareInstance.AD_HEIGHT
    l_rect.origin.y     = m_ControlView.frame.origin.y - l_rect.size.height
    m_AdView = UIView(frame: l_rect)
    m_AdView.backgroundColor = UIColor.clearColor()
    
    self.view.addSubview(m_AdView)
  }

 
  func InitContentView()
  {
    var l_rect          = CGRectMake(0, 0, 0, 0)
    l_rect.origin.x     = 0
    l_rect.size.width   = SCREEN_WIDTH
    l_rect.origin.y     = FSDesign.ShareInstance.NAVI_HEIGHT
    l_rect.size.height  = m_AdView.frame.origin.y - l_rect.origin.y
    
    m_ContentView = UIView(frame: l_rect)
    m_ContentView.backgroundColor = UIColor.brownColor()
    
    //text view
    l_rect.size.width = m_ContentView.frame.size.width - 2 * FSDesign.ShareInstance.CELL_MARGIN
    l_rect.origin.x = FSDesign.ShareInstance.CELL_MARGIN
    l_rect.origin.y = 0
    l_rect.size.height = m_ContentView.frame.size.height
    m_TextView = UITextView(frame: l_rect)
    m_TextView.textAlignment = NSTextAlignment.Left
    //m_TextView.editable = false
    m_TextView.backgroundColor = UIColor.grayColor()
    m_TextView.delegate = self

   // self.m_TextView.(self, action: "TextViewClick:", forControlEvents: UIControlEvents.TouchUpInside)
    
    m_ContentView.addSubview(m_TextView)
    self.view.addSubview(m_ContentView)
  }
  
  
    
    func InitControlView()
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
        
        m_BtnAudio = UIButton(frame: l_rect)
        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
        m_BtnAudio.setTitle("", forState: UIControlState.Normal)
        m_BtnAudio.addTarget(self, action: "AudioClick:", forControlEvents: UIControlEvents.TouchUpInside)
      
        
        //A-
        l_rect = CGRectMake(
            l_HSpaceButton + m_BtnAudio.frame.size.width + m_BtnAudio.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonASub = UIButton(frame: l_rect)
        l_UIButtonASub.setImage(UIImage(named: "a_sub"), forState: UIControlState.Normal)
        l_UIButtonASub.setTitle("", forState: UIControlState.Normal)
        l_UIButtonASub.addTarget(self, action: "ASubClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //A+
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonASub.frame.size.width + l_UIButtonASub.frame.origin.x,
            FSDesign.ShareInstance.ICON_VHSPACE,
            FSDesign.ShareInstance.ICON_WIDTH,
            FSDesign.ShareInstance.ICON_HEIGTH)
        
        let l_UIButtonAPlus = UIButton(frame: l_rect)
        l_UIButtonAPlus.setImage(UIImage(named: "a_plus"), forState: UIControlState.Normal)
        l_UIButtonAPlus.setTitle("", forState: UIControlState.Normal)
        l_UIButtonAPlus.addTarget(self, action: "APlusClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Favorite
        l_rect = CGRectMake(
            l_HSpaceButton + l_UIButtonAPlus.frame.size.width + l_UIButtonAPlus.frame.origin.x,
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
        m_ControlView.addSubview(m_BtnAudio)
        m_ControlView.addSubview(l_UIButtonAPlus)
        m_ControlView.addSubview(l_UIButtonASub)
        m_ControlView.addSubview(l_UIButtonFavorite)
        m_ControlView.addSubview(l_UIButtonNext)
      
        m_ControlView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(m_ControlView)
    }

  
    // MARK: - Navigation

    func PopCurrentViewController(sender: UIButton!)
    {
        SoundController.ShareInstance.PauseStory()
        if let l_navController = self.navigationController
        {
          for controller in l_navController.viewControllers
          {
            if controller.isKindOfClass(HomeViewController)
            {
              
              let HomeView: HomeViewController = controller as! HomeViewController
              HomeView.m_CurrentIndex = m_Story.m_row
              l_navController.popToViewController(HomeView, animated: true)
              
              print("Set current indexpath")

            }
          }
          
        }
    }
  
    
    func ShareClick(sender: UIButton!)
    {
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
      
      let l_image = FSCore.ShareInstance.ScreenShot()
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
  
    func TextViewClick(sender: UIButton!)
    {
      print("TextView click")
    }
  
    func PreviousClick(sender: UIButton!)
    {
        SoundController.ShareInstance.PauseStory()
        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
      
        var i = 0
        for story in FSCore.ShareInstance.m_ArrayStory
        {
          if story.m_id == m_Story.m_id
          {
            m_Story = FSCore.ShareInstance.m_ArrayStory[i == 0 ? FSCore.ShareInstance.m_ArrayStory.count - 1 : i - 1]
            break
          }
          
          i++
        }
        
        RepreshStory()
        //print("Previous click")
    }
    
    func NextClick(sender: UIButton!)
    {
        SoundController.ShareInstance.PauseStory()
        m_BtnAudio.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
      
      
        var i = 0
        for story in FSCore.ShareInstance.m_ArrayStory
        {
          i++
          if story.m_id == m_Story.m_id
          {
            m_Story = FSCore.ShareInstance.m_ArrayStory[i >= FSCore.ShareInstance.m_ArrayStory.count ? 0 : i]
            break
          }
        }
      
        RepreshStory()
      
        //print("Next click")
    }
    
    func APlusClick(sender: UIButton!)
    {
        //print("Aplus click")
        if let _ = self.m_CurrentTextViewFontSize
        {
          self.m_CurrentTextViewFontSize = self.m_CurrentTextViewFontSize! + FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
          
        }
        else
        {
          self.m_CurrentTextViewFontSize = FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW + FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
          
        }

        let l_FontPlus = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: self.m_CurrentTextViewFontSize!)
        self.m_TextView.SetFont(l_FontPlus!)
        
    }//end APlusClick
  
  
    func ASubClick(sender: UIButton!)
    {
        //print("ASub click")
      if let _ = self.m_CurrentTextViewFontSize
      {
        self.m_CurrentTextViewFontSize = self.m_CurrentTextViewFontSize! - FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
        
      }
      else
      {
        self.m_CurrentTextViewFontSize = FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW - FSDesign.ShareInstance.FONT_SIZE_TEXTVIEW_DELTA
        
      }
      
      let l_FontSub = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: self.m_CurrentTextViewFontSize!)
      self.m_TextView.SetFont(l_FontSub!)
    }//end ASubClick
  
  
  
    func FavoriteClick(sender: UIButton!)
    {
        print("Favorite click")
    }
  
  
    
    func AudioClick(sender: UIButton!)
    {
        SoundController.ShareInstance.PlayURL(m_Story.m_audiourl!, p_object: self)
      
        if SoundController.ShareInstance.m_PlayerStory?.rate == 0
        {
          sender.setImage(UIImage(named: "audio_play"), forState: UIControlState.Normal)
        }
        else
        {
          sender.setImage(UIImage(named: "audio_stop"), forState: UIControlState.Normal)
        }

    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
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
  
  func textViewDidChangeSelection(textView: UITextView)
  {
    //print("textViewDidChangeSelection")
  }
  
  func textViewDidBeginEditing(textView: UITextView)
  {
    print("textViewDidBeginEditing")
    
  }
  
  func textViewDidChange(textView: UITextView)
  {
    print("textViewDidChange")
  }
  
  func textViewDidEndEditing(textView: UITextView)
  {
    print("textViewDidEndEditing")
  }
  
  func textViewShouldBeginEditing(textView: UITextView) -> Bool
  {
    
    UIView.animateWithDuration(0.4, animations: {
      if self.m_ControlView.hidden == true
      {
        self.m_ControlView.hidden = false
        
        var l_frame = self.m_ControlView.frame
        l_frame.origin.y = l_frame.origin.y - l_frame.size.height
        self.m_ControlView.frame = l_frame
        
        l_frame = self.m_AdView.frame
        l_frame.origin.y = l_frame.origin.y - self.m_ControlView.frame.size.height
        self.m_AdView.frame = l_frame
        
        l_frame = self.m_TextView.frame
        l_frame.size.height = l_frame.size.height - self.m_ControlView.frame.size.height
        self.m_TextView.frame = l_frame
        
        l_frame = self.m_ContentView.frame
        l_frame.size.height = l_frame.size.height - self.m_ControlView.frame.size.height
        self.m_ContentView.frame = l_frame
      }
      else
      {
        self.m_ControlView.hidden = true
        var l_frame = self.m_ControlView.frame
        l_frame.origin.y = l_frame.origin.y + l_frame.size.height
        self.m_ControlView.frame = l_frame
        
        l_frame = self.m_AdView.frame
        l_frame.origin.y = l_frame.origin.y + self.m_ControlView.frame.size.height
        self.m_AdView.frame = l_frame
        
        l_frame = self.m_TextView.frame
        //l_frame.origin.y += l_frame.size.height
        l_frame.size.height = l_frame.size.height + self.m_ControlView.frame.size.height
        self.m_TextView.frame = l_frame
        
        l_frame = self.m_ContentView.frame
        l_frame.size.height = l_frame.size.height + self.m_ControlView.frame.size.height
        self.m_ContentView.frame = l_frame
        
      }
      
    })
    
    
    return false
  }
  
  func textViewShouldEndEditing(textView: UITextView) -> Bool
  {
    print("textViewShouldEndEditing")
    return false
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
  {
    print("touchesMoved")
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touchesBegan")
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    print("touchesCancelled")
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touchesEnded")
  }
  
  override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
    print("touchesEstimatedPropertiesUpdated")
  }
}
