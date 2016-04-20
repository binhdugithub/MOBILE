//
//  TestDefine.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/15/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


let YOUR_APP_ID: String             = "1070241747"
let AMOD_BANNER_FOOTER_UNIT :String = "ca-app-pub-2735696870763171/5172236840"
let AMOD_INTERSTITIAL_UNIT :String  = "ca-app-pub-2735696870763171/6648970044"

let URL_FB: String = "https://www.facebook.com/cusikiapp"
let URL_TW: String = "https://twitter.com/cusikiapp"

let TIME_TO_SHOW_ADS = 5
//let TIME_TO_SHOW_RATE = 13


let TEXT_COPYRIGHT:String = "CUSIKI @2016"

let FILE_CONFIG = "config.plist"
let FILE_DATA = "photolist.plist"

let IS_IPAD:Bool               =     (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
let IS_IPHONE: Bool            =     (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
let IS_RETINA: Bool            =     (UIScreen.mainScreen().scale >= 2.0)

let SCREEN_WIDTH:CGFloat       =     UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:CGFloat      =     UIScreen.mainScreen().bounds.size.height
let SCREEN_MAX_LENGTH:CGFloat  =     max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH:CGFloat  =     min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS:Bool   =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 480.0)) // 640 x 960
let IS_IPHONE_5:Bool           =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 568.0)) // 640 x 1136
let IS_IPHONE_6:Bool           =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 667.0)) // 750 x 1334
let IS_IPHONE_6P:Bool          =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 736.0)) // 828 x 1472

let IS_IPAD_1X:Bool           =     (IS_IPAD && (SCREEN_MAX_LENGTH == 512))  //768 x 1024 IPAD2, IPAD mini 1x
let IS_IPAD_2X:Bool           =     (IS_IPAD && (SCREEN_MAX_LENGTH == 1024)) //1536 x 2048 IPAD, IPADmini 2x
let IS_IPAD_PRO:Bool          =     (IS_IPAD && (SCREEN_MAX_LENGTH == 1366)) //IPAD pro

let VERSION: String           =     (UIDevice.currentDevice().systemVersion)

let NAVIGATOR_1X_HEIGHT        =     CGFloat(22)
let STATUS_BAR_HEIGHT         =     CGFloat(10)
let DISPLAY_X                 =     UIScreen.mainScreen().scale

//open flash iphone
func toggleTorch()
{
  let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
  // check if the device has torch
  if  avDevice.hasTorch
  {
    // lock your device for configuration
    do
    {
      try avDevice.lockForConfiguration()
      // check if your torchMode is on or off. If on turns it off otherwise turns it on
      avDevice.torchMode = avDevice.torchActive ? AVCaptureTorchMode.Off : AVCaptureTorchMode.On
      
      // sets the torch intensity to 100%
      try avDevice.setTorchModeOnWithLevel(1.0)
      // unlock your device
      avDevice.unlockForConfiguration()
      
    }
    catch let p_error as NSError
    {
      print("Open flash error: \(p_error)")
    }
    
  }
}

//off flash iphone
func toggleTorchOff()
{
  let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
  if (device.hasTorch)
  {
    do
    {
      try device.lockForConfiguration()
      let torchOn = !device.torchActive
      try device.setTorchModeOnWithLevel(1.0)
      device.torchMode = torchOn ? AVCaptureTorchMode.On : AVCaptureTorchMode.Off
      device.unlockForConfiguration()
    }
    catch let p_error as NSError
    {
      print("Open flash error: \(p_error)")
    }
    
  }
}



//resize image
func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage
{
  let size = image.size
  let widthRatio  = targetSize.width  / image.size.width
  let heightRatio = targetSize.height / image.size.height
  
  // Figure out what our orientation is, and use that to form the rectangle
  var newSize: CGSize
  if(widthRatio > heightRatio)
  {
    newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
  }
  else
  {
    newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
  }
  
  // This is the rect that we've calculated out and this is what is actually used below
  let rect = CGRectMake(0, 0, newSize.width, newSize.height)
  
  // Actually do the resizing to the rect using the ImageContext stuff
  UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
  image.drawInRect(rect)
  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  
  return newImage
}

//capture screenShot
func ScreenShot() -> UIImage
{
  let layer = UIApplication.sharedApplication().keyWindow!.layer
  let scale = UIScreen.mainScreen().scale
  UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
  
  layer.renderInContext(UIGraphicsGetCurrentContext()!)
  let screenshot = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  
  UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
  
  return screenshot
}

//Get full Path

func GetDocPathFile(p_name: String) -> String
{
    var destinationPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask , true)[0]
    destinationPath.appendContentsOf("/")
    destinationPath.appendContentsOf(p_name)
    if !NSFileManager.defaultManager().fileExistsAtPath(destinationPath)
    {
        var sourcePath: String = NSBundle.mainBundle().resourcePath!
        sourcePath.appendContentsOf("/")
        sourcePath.appendContentsOf(p_name)
        do
        {
            try NSFileManager.defaultManager().copyItemAtPath(sourcePath, toPath:destinationPath)
        }
        catch let l_error as NSError
        {
            print("Error: \(l_error.localizedDescription)")
        }
    }

    print("Path: \(destinationPath)")
    return destinationPath;
  
}


//get height of font
func HeightForText(p_text: String, p_font: UIFont, p_width: CGFloat) -> CGFloat
{
  //  let rect = NSString(string: p_text).boundingRectWithSize(CGSize(width: p_width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: p_font], context: nil)
  //  return ceil(rect.height)
  
  let label:UILabel = UILabel(frame: CGRectMake(0, 0, p_width, CGFloat.max))
  label.numberOfLines = 0
  label.lineBreakMode = NSLineBreakMode.ByWordWrapping
  label.font = p_font
  label.text = p_text
  
  label.sizeToFit()
  return label.frame.height
  
}


//get width of font
func WidthForText(p_text: String, p_font: UIFont, p_heigh: CGFloat) -> CGFloat
{
  //    let rect = NSString(string: p_text).boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT), height: p_heigh), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: p_font], context: nil)
  //    return ceil(rect.width)
  
  let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, p_heigh))
  label.numberOfLines = 1
  label.lineBreakMode = NSLineBreakMode.ByWordWrapping
  label.font = p_font
  label.text = p_text
  
  label.sizeToFit()
  return label.frame.width
  
}


//alert
func ShowAlert(title : String? , message : String?) -> UIAlertController
{
  let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
  let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
  alert.addAction(action)
  
  //self.presentViewController(alert, animated: true, completion: nil)
  
  return alert
}


//alert
func ShowSettingsAlert(title : String? , message : String?) -> UIAlertController
{
  let l_alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
  let settingAction = UIAlertAction(title: "Setting", style: .Default, handler: {(action: UIAlertAction) -> Void in
    dispatch_async(dispatch_get_main_queue())
    {
      UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
  })
  
  let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
  
  l_alertController.addAction(settingAction)
  l_alertController.addAction(cancelAction)
  
  //self.presentViewController(alertController, animated: true, completion: nil)
  return l_alertController
  
}