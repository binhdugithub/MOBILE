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
    var m_IsMute: Bool?
    var m_CurrentImage: Int?
    var m_ArrayLinkFavorite = NSMutableArray()
  
    let FILECONFIG = "/config.plist"
    
    static let ShareInstance = Configuration()
    
    private init()
    {
        LoadConfig()
    }
  
    func GetPathData() -> String
    {
      var destinationPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask , true)[0]
      destinationPath.appendContentsOf(FILECONFIG)
      
      if !NSFileManager.defaultManager().fileExistsAtPath(destinationPath)
      {
        var sourcePath: String = NSBundle.mainBundle().resourcePath!
        sourcePath.appendContentsOf(FILECONFIG)
        do
        {
          try NSFileManager.defaultManager().copyItemAtPath(sourcePath, toPath:destinationPath)
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
        print("Path:\(pathData)")
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
            m_IsMute = (dicData?.objectForKey("IsMute") as? Bool)!
            m_ArrayLinkFavorite = dicData?.objectForKey("Favorite") as! NSMutableArray
            //m_ArrayLinkFavorite.sortInPlace({$0 > $1})
            m_CurrentImage = dicData?.objectForKey("CurrentImage") as? Int
          
        }
        else
        {
            NSLog("Load data.plist fail !!")
            m_IsMute = false
            m_CurrentImage = -1
            m_ArrayLinkFavorite = NSMutableArray()
        }
        
    }
    
    func GetIsMute() -> Bool
    {
        return m_IsMute!;
        
    }
    
    func WriteMute(p_ismute: Bool)
    {
        let pathData: String = self.GetPathData()
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
            dicData!.setObject(p_ismute, forKey:"IsMute")
            dicData!.writeToFile(pathData, atomically:true)
            m_IsMute=p_ismute
        }
        else
        {
            print("Load data plist info fail !!")
            
        }
    }
  
    func WriteFavorite(p_favorite: NSMutableArray)
    {
      let pathData: String = self.GetPathData()
      let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
      if let l_dicData = dicData
      {
        if p_favorite.count > 0
        {
          l_dicData.setObject(p_favorite, forKey:"Favorite")
          l_dicData.writeToFile(pathData, atomically:true)
        }
        
      }
    }
    
    func WriteCurrentImage(p_index: Int)
    {
        let pathData: String = self.GetPathData()
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(p_index, forKey:"CurrentImage")
            l_dicData.writeToFile(pathData, atomically:true)
        }
    }
    
}

