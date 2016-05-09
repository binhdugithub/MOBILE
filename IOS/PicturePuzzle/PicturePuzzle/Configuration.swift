//
//  Configuration.swift
//  CheckMoney
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//
import UIKit
import GameKit

class Configuration
{
    static let ShareInstance = Configuration()
  
    
    private init()
    {
        LoadConfig()
    }
  
    func CallSelf() -> Void
    {
        print("Function do nothing")
    }
    
    func LoadConfig()
    {
        let pathData: String = GetDocPathFile(FILE_CONFIG)
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
          if let l_ismuted = dicData?.objectForKey("ismuted") as? Bool
          {
            SoundController.ShareInstance.m_ismuted = l_ismuted
          }
          else
          {
            SoundController.ShareInstance.m_ismuted = false
          }
          
          if let l_level = dicData?.objectForKey("level") as? Int
          {
            PPCore.ShareInstance.m_level = l_level
          }
          else
          {
            PPCore.ShareInstance.m_level = 1
          }
          
          if let l_coin = dicData?.objectForKey("coin") as? Int
          {
            PPCore.ShareInstance.m_coin = l_coin
          }
          else
          {
            PPCore.ShareInstance.m_coin = 100
          }
          
        }
        else
        {
            NSLog("Load data.plist fail !!")
            SoundController.ShareInstance.m_ismuted = false
            PPCore.ShareInstance.m_level = 1
            PPCore.ShareInstance.m_coin = 100
        }
        
    }
    
    func WriteLevel(p_level: Int)
    {
        let pathData: String = GetDocPathFile(FILE_CONFIG)
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(NSNumber(integer: p_level), forKey:"level")
            l_dicData.writeToFile(pathData, atomically:true)
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
    }
    
    func WriteCoin(p_coin: Int)
    {
        let pathData: String = GetDocPathFile(FILE_CONFIG)
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(NSNumber(integer: p_coin), forKey:"coin")
            l_dicData.writeToFile(pathData, atomically:true)
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
    }
    
    func WriteMute(p_mute: Bool)
    {
        let pathData: String = GetDocPathFile(FILE_CONFIG)
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(p_mute, forKey:"ismuted")
            l_dicData.writeToFile(pathData, atomically:true)
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
    }
    
}

