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
    var m_ismuted: Bool!
    var m_coin: Int!
    var m_level: Int!
    
    static let ShareInstance = Configuration()
  
    
    private init()
    {
        m_ismuted = false
        m_coin = -1
        m_level = -1
        
        LoadConfig()
    }
  
    func LoadConfig()
    {
        let pathData: String = GetDocPathFile(FILE_CONFIG)
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
          if let a = dicData?.objectForKey("ismuted") as? Bool
          {
            m_ismuted = a
          }
          else
          {
            m_ismuted = false
          }
          
          if let a = dicData?.objectForKey("level") as? Int
          {
            m_level = a
          }
          else
          {
            m_level = 1
          }
          
          if let a = dicData?.objectForKey("coin") as? Int
          {
            m_coin = a
          }
          else
          {
            m_coin = 100
          }
          
        }
        else
        {
            NSLog("Load data.plist fail !!")
            m_ismuted = false
            m_level = 1
            m_coin = 100
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
            m_level = p_level
            print("write rate:\(m_level)")
            
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
            m_coin = p_coin
            print("write coin:\(m_coin)")
            
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
    }
    
}

