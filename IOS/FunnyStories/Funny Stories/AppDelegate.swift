//
//  AppDelegate.swift
//  Pinterest
//
//  Created by Mic Pringle on 10/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  
  var window: UIWindow?
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
  {
    // Override point for customization after application launch.

    window!.backgroundColor = FSDesign.ShareInstance.COLOR_BACKGROUND
    
    
    if DBModel.ShareInstance.CreateDatabase(FILE_DATABASE) == true
    {
      print("Create databse \(FILE_DATABASE) ok ")
      DBModel.ShareInstance.CreateTable("Story")
    }
    else
    {
      DBModel.ShareInstance.GetAllStories()
      FSCore.ShareInstance.m_OldSizeStories = FSCore.ShareInstance.m_ArrayStory.count

    }
    
    return true
  }
  
  func applicationWillResignActive(application: UIApplication)
  {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication)
  {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication)
  {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication)
  {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication)
  {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    print("Save Story")
    for i in 0..<FSCore.ShareInstance.m_OldSizeStories
    {
      if FSCore.ShareInstance.m_ArrayTemp[i].m_liked != FSCore.ShareInstance.m_ArrayStory[i].m_liked!
      {
        DBModel.ShareInstance.UpdateFavoriteStory(FSCore.ShareInstance.m_ArrayStory[i])
      }
    }
    
    for i in FSCore.ShareInstance.m_OldSizeStories..<FSCore.ShareInstance.m_ArrayStory.count
    {
      DBModel.ShareInstance.InsertStory(FSCore.ShareInstance.m_ArrayStory[i])
    }
    
    //Save currentStory displayed
    //write current story
    print("Save current displayed story:\(Configuration.ShareInstance.m_CurrentStory!)")
    
    Configuration.ShareInstance.WriteCurrentStory(Configuration.ShareInstance.m_CurrentStory!)

  }
}

