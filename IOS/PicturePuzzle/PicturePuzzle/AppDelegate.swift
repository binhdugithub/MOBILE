//
//  AppDelegate.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/16/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
       window!.backgroundColor = ViewDesign.ShareInstance.COLOR_BG
       Configuration.ShareInstance.CallSelf()
        
        if PPCore.ShareInstance.m_ArrayApp.count <= 0
        {
            NetWorkModel.ShareInstance.GETApps()
        }
        
        PPCore.ShareInstance.m_iaphelper.requestProducts{success, products in
            if success
            {
                PPCore.ShareInstance.m_products = products!
            }
        }
        
        return true
    }

//    func applicationWillResignActive(application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    }
//
//    func applicationDidEnterBackground(application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
////        Configuration.ShareInstance.WriteMute(SoundController.ShareInstance.m_ismuted)
////        Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
////        Configuration.ShareInstance.WriteLevel(PPCore.ShareInstance.m_level)
//    }
//
//    func applicationWillEnterForeground(application: UIApplication) {
//        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    }
//
//    func applicationDidBecomeA ctive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
    }


}

