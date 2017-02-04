//
//  MoreViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/9/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import AVFoundation


class MoreViewController: UIViewController
{
  
  var m_FBButton: UIButton
  var m_TWButton: UIButton
  var m_RateButton: UIButton
  var m_ImgView: UIImageView
  var m_MoreAppScrollView: UIScrollView
  var m_MoreAppText: UILabel
  required init?(coder aDecoder: NSCoder)
  {
    m_FBButton = UIButton()
    m_TWButton = UIButton()
    m_RateButton = UIButton()
    m_MoreAppScrollView = UIScrollView()
    m_ImgView = UIImageView()
    m_MoreAppText = UILabel()
    
    super.init(coder: aDecoder)

  }
  
  func GetUrlImage(p_imageurl: String)-> String
  {
    var l_pathimg: String =  Bundle.main.resourcePath!
    l_pathimg.append("/")
    l_pathimg.append(p_imageurl)
    
    if FileManager.default.fileExists(atPath: l_pathimg)
    {
      return p_imageurl
    }
    else
    {
      return ""
    }
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle
  {
    return UIStatusBarStyle.lightContent
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  
    let F = App(p_name: "Find 100 Numbers", p_imageurl: GetUrlImage(p_imageurl: "1to100numbers.jpg"), p_link: "itms-apps://itunes.apple.com/app/id1048219569")
    let B = App(p_name: "Bờm Đố Vui", p_imageurl: GetUrlImage(p_imageurl: "bomdovui.jpg"), p_link: "itms-apps://itunes.apple.com/app/id1028819809")
    let T = App(p_name: "Test Eyes", p_imageurl: GetUrlImage(p_imageurl: "testeyes.jpg"), p_link: "itms-apps://itunes.apple.com/app/id1031081322")
    let A = App(p_name: "Animal Puzzle", p_imageurl: GetUrlImage(p_imageurl: "animalpuzzle.png"), p_link: "itms-apps://itunes.apple.com/app/id1111859523")
    let Fun = App(p_name: "Funny Stories", p_imageurl: GetUrlImage(p_imageurl: "funnystories.jpg"), p_link: "itms-apps://itunes.apple.com/app/id1070241747")
    
    FSCore.ShareInstance.m_ArrayApp.append(F)
     FSCore.ShareInstance.m_ArrayApp.append(B)
     FSCore.ShareInstance.m_ArrayApp.append(T)
     FSCore.ShareInstance.m_ArrayApp.append(A)
     FSCore.ShareInstance.m_ArrayApp.append(Fun)
   
    
    self.SetupView()
    SetupMoreAppView()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    
    
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
  
  }
  
  func SetupView()
  {
    //logo view
    var l_logofrm = CGRect(x: 0, y: 0, width: 0, height: 0)
    l_logofrm.size.width = SCREEN_WIDTH / 2
    l_logofrm.size.height = l_logofrm.size.width
    l_logofrm.origin.x = 1.0/2 * (SCREEN_WIDTH - l_logofrm.size.width)
    l_logofrm.origin.y = 20
    m_ImgView = UIImageView(frame: l_logofrm)
    m_ImgView.image = UIImage(named: "lauchimage")
    
    //facebook
    var l_frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    l_frame.size.width = SCREEN_WIDTH / 3
    l_frame.size.height = 1.0/3 * l_frame.size.width
    l_frame.origin.x = 1.0/2 * (SCREEN_WIDTH - l_frame.size.width)
    l_frame.origin.y = m_ImgView.frame.origin.y + m_ImgView.frame.size.height + 10
    
    m_FBButton = UIButton(frame: l_frame)
    m_FBButton.backgroundColor = UIColor.clear
    
    UIGraphicsBeginImageContext(m_FBButton.frame.size)
    UIImage(named: "fb")?.draw(in: m_FBButton.bounds)
    var l_image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_FBButton.setImage(l_image, for: UIControlState())
    
    UIGraphicsBeginImageContext(m_FBButton.frame.size)
    UIImage(named: "fb_pressed")?.draw(in: m_FBButton.bounds)
    l_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_FBButton.setImage(l_image, for: UIControlState.highlighted)
    m_FBButton.setTitle("", for: UIControlState())
    
    m_FBButton.addTarget(self, action: #selector(MoreViewController.FBClick(_:)), for: UIControlEvents.touchUpInside)
    
    //tw 
    l_frame = m_FBButton.frame
    l_frame.origin.y = m_FBButton.frame.origin.y + m_FBButton.frame.size.height + 1.0/5 * m_FBButton.frame.size.height
    m_TWButton = UIButton(frame: l_frame)
    m_TWButton.backgroundColor = UIColor.clear
    UIGraphicsBeginImageContext(m_TWButton.frame.size)
    UIImage(named: "tw")?.draw(in: m_TWButton.bounds)
    l_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_TWButton.setImage(l_image, for: UIControlState())
    
    UIGraphicsBeginImageContext(m_TWButton.frame.size)
    UIImage(named: "tw_pressed")?.draw(in: m_TWButton.bounds)
    l_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_TWButton.setImage(l_image, for: UIControlState.highlighted)
    m_TWButton.setTitle("", for: UIControlState())
    m_TWButton.addTarget(self, action: #selector(MoreViewController.TWClick(_:)), for: UIControlEvents.touchUpInside)
    
    //rate
    l_frame = m_TWButton.frame
    l_frame.origin.y = m_TWButton.frame.origin.y + m_TWButton.frame.size.height + 1.0/5 * m_TWButton.frame.size.height
    m_RateButton = UIButton(frame: l_frame)
    m_RateButton.backgroundColor = UIColor.clear
    
    UIGraphicsBeginImageContext(m_RateButton.frame.size)
    UIImage(named: "rate")?.draw(in: m_RateButton.bounds)
    l_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_RateButton.setImage(l_image, for: UIControlState())
    
    UIGraphicsBeginImageContext(m_RateButton.frame.size)
    UIImage(named: "rate_pressed")?.draw(in: m_RateButton.bounds)
    l_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    m_RateButton.setImage(l_image, for: UIControlState.highlighted)
    m_RateButton.setTitle("", for: UIControlState())
    m_RateButton.addTarget(self, action: #selector(MoreViewController.RateClick(_:)), for: UIControlEvents.touchUpInside)
    
    
    //view more app
    var l_frame2 = CGRect(x: 0, y: 0, width: 0, height: 0)
    l_frame2.size.width = SCREEN_WIDTH - 20
    l_frame2.origin.x = 10
    l_frame2.size.height = m_RateButton.frame.size.height * CGFloat(2)
    l_frame2.origin.y = SCREEN_HEIGHT - FSDesign.ShareInstance.TABBAR_HEIGHT - l_frame2.size.height - 20
    
    m_MoreAppScrollView = UIScrollView(frame: l_frame2)
    m_MoreAppScrollView.layer.cornerRadius = 5
    m_MoreAppScrollView.layer.borderWidth = 1
    m_MoreAppScrollView.layer.borderColor = FSDesign.ShareInstance.COLOR_MOREAPP_BG.cgColor
    m_MoreAppScrollView.backgroundColor = UIColor.clear//FSDesign.ShareInstance.COLOR_MOREAPP_BG

    m_MoreAppScrollView.isScrollEnabled = true
    m_MoreAppScrollView.showsHorizontalScrollIndicator = true
    m_MoreAppScrollView.bounces = true
    
    //label
    var l_txtfrm = CGRect(x: 0, y: 0, width: 0, height: 0)
    l_txtfrm.size.width = m_MoreAppScrollView.frame.size.width
    l_txtfrm.size.height = 35
    l_txtfrm.origin.x = m_MoreAppScrollView.frame.origin.x
    l_txtfrm.origin.y = m_MoreAppScrollView.frame.origin.y - l_txtfrm.size.height
    
    m_MoreAppText = UILabel(frame: l_txtfrm)
    m_MoreAppText.textColor = UIColor.white
    m_MoreAppText.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    m_MoreAppText.text = "More Applications:"
    
    //end view more app
    self.view.addSubview(m_MoreAppScrollView)
    self.view.addSubview(m_FBButton)
    self.view.addSubview(m_TWButton)
    self.view.addSubview(m_RateButton)
    self.view.addSubview(m_ImgView)
    self.view.addSubview(m_MoreAppText)
    
  }
  
  func SetupMoreAppView()
  {
    
    let l_height = 0.9 * m_MoreAppScrollView.frame.size.height
    let l_y = 0.05 * l_height
    let l_space = 0.1 * l_height
    var l_frame = CGRect(x: 0, y: l_y, width: l_height, height: l_height)
    
    for i in 0..<FSCore.ShareInstance.m_ArrayApp.count
    {
      l_frame.origin.x = l_space + (l_frame.size.width + l_space) * CGFloat(i)
      let l_btn = UIButton(frame: l_frame)
      l_btn.layer.cornerRadius = l_height / 5
      l_btn.layer.borderWidth = l_height / 20
      l_btn.layer.borderColor = FSDesign.ShareInstance.COLOR_BODER_BG.cgColor
      //l_btn.setImage(UIImage(named: FSCore.ShareInstance.m_ArrayApp[i].m_imageurl), for: UIControlState.normal)
      
      UIGraphicsBeginImageContext(l_btn.frame.size)
      UIImage(named: FSCore.ShareInstance.m_ArrayApp[i].m_imageurl)?.draw(in: l_btn.bounds)
      let l_image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      l_btn.backgroundColor = UIColor(patternImage: l_image!)
      
      l_btn.tag = i
      l_btn.addTarget(self, action: #selector(MoreViewController.MoreAppClick(_:)), for: UIControlEvents.touchUpInside)
      
      m_MoreAppScrollView.addSubview(l_btn)
    }
    
    m_MoreAppScrollView.contentSize = CGSize( width: CGFloat(FSCore.ShareInstance.m_ArrayApp.count) * (l_height + l_space) + l_space, height: m_MoreAppScrollView.frame.size.height)
  }
  
  func FBClick(_ sender: UIButton!)
  {
    SoundController.ShareInstance.PlayButton()
    print("FB Click")
    UIApplication.shared.openURL(URL(string: URL_FB)!)
  }
  
  func TWClick(_ sender: UIButton!)
  {
    SoundController.ShareInstance.PlayButton()
    print("TW Click")
    UIApplication.shared.openURL(URL(string: URL_TW)!)
  }

  
  func RateClick(_ sender: UIButton!)
  {
    SoundController.ShareInstance.PlayButton()
    print("RateClick")
    #if TARGET_IPHONE_SIMULATOR
      print("APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
    #else
      let l_linkapp = "itms-apps://itunes.apple.com/app/id\(YOUR_APP_ID)"
      UIApplication.shared.openURL(URL(string : l_linkapp)!)
    #endif

  }
  
  
  func MoreAppClick(_ sender: UIButton!)
  {
    
    SoundController.ShareInstance.PlayButton()
    print("MoreAppClick: \(FSCore.ShareInstance.m_ArrayApp[sender.tag].m_name)")
    #if TARGET_IPHONE_SIMULATOR
      print("APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
    #else
      let l_linkapp = FSCore.ShareInstance.m_ArrayApp[sender.tag].m_link
      UIApplication.shared.openURL(URL(string : l_linkapp)!)
    #endif
    
  }
  

}
