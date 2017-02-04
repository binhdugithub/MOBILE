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
    var m_CurrentStory: Int?
    var m_Rate: Int?
    var m_IsMute: Bool?
    
    static let ShareInstance = Configuration()
  
    
    fileprivate init()
    {
      m_IsMute = false
      m_Rate = 1
      m_CurrentStory = 0
      
      LoadConfig()
    }
  
    func GetPathData() -> String
    {
      var destinationPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask , true)[0]
      destinationPath.append(FILE_CONFIG)
      
      if !FileManager.default.fileExists(atPath: destinationPath)
      {
        var sourcePath: String = Bundle.main.resourcePath!
        sourcePath.append(FILE_CONFIG)
        do
        {
          try FileManager.default.copyItem(atPath: sourcePath, toPath:destinationPath)
        }
        catch let l_error as NSError
        {
          print("Error: \(l_error.localizedDescription)")
        }
      }
      
      return destinationPath;
      
    }
    
  
    func LoadConfig()
    {
        let pathData: String = self.GetPathData()
        //print("Path:\(pathData)")
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
          if let a = dicData?.object(forKey: "IsMute") as? Bool
          {
            m_IsMute = a
          }
          else
          {
            m_IsMute = false
          }
          
          if let a = dicData?.object(forKey: "CurrentStory") as? Int
          {
            m_CurrentStory = a
          }
          else
          {
            m_CurrentStory = 0
          }
          
          if let a = dicData?.object(forKey: "Rate") as? Int
          {
            m_Rate = a
          }
          else
          {
            m_Rate = 1
          }
          
        }
        else
        {
            NSLog("Load data.plist fail !!")
            m_IsMute = false
            m_CurrentStory = 0
            m_Rate = 1
        }
        
    }
    
    func GetIsMute() -> Bool
    {
        return m_IsMute!;
        
    }
    
  
    func WriteRate(_ p_rate: Int)
    {
        let pathData: String = self.GetPathData()
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(NSNumber(value: p_rate as Int), forKey:"Rate" as NSCopying)
            l_dicData.write(toFile: pathData, atomically:true)
            m_Rate = p_rate
            print("write rate:\(m_Rate)")
            
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
    }
    
    func WriteMute(_ p_ismute: Bool)
    {
        let pathData: String = self.GetPathData()
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
            dicData!.setObject(p_ismute, forKey:"IsMute" as NSCopying)
            dicData!.write(toFile: pathData, atomically:true)
            m_IsMute=p_ismute
        }
        else
        {
            print("Load data plist info fail !!")
            
        }
        
    }
  
    func WriteFavorite(_ p_favorite: NSMutableArray)
    {
      let pathData: String = self.GetPathData()
      let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
      if let l_dicData = dicData
      {
        if p_favorite.count > 0
        {
          l_dicData.setObject(p_favorite, forKey:"Favorite" as NSCopying)
          l_dicData.write(toFile: pathData, atomically:true)
        }
        
      }
    }
  
  
    func WriteCurrentStory(_ p_index: Int)
    {
      let pathData: String = self.GetPathData()
      let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
      if let l_dicData = dicData
      {
        l_dicData.setObject(p_index, forKey:"CurrentStory" as NSCopying)
        l_dicData.write(toFile: pathData, atomically:true)
      }
    }
  
}

