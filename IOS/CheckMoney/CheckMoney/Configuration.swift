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
    var m_LeaderboardIdentifier: String?
    var m_BestScore: Int64?
    var m_IsMute: Bool?
    let FILECONFIG = "/data.plist"
    
    static let ShareInstance = Configuration()
    
    func ReportScore()
    {
        if m_LeaderboardIdentifier != nil
        {
            let score: GKScore = GKScore(leaderboardIdentifier:m_LeaderboardIdentifier!)
            score.value = m_BestScore!
            GKScore.reportScores([score], withCompletionHandler:{ error in
                if error != nil
                {
                    NSLog("%@",error!.localizedDescription)
                    
                }
                
            })
            
        } else
        {
            NSLog("LeaderBoard failed")
            
        }
        
    }
    
    func SetLeaderboardIdentifier(p_leaderboard: String)
    {
        m_LeaderboardIdentifier = p_leaderboard
        
    }
    
    
    private init()
    {
        LoadConfig()
    }
    
    func LoadConfig()
    {
        let pathData: String = self.GetPathData()
        print("Path:\(pathData)")
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!
        if dicData != nil
        {
            m_IsMute = (dicData?.objectForKey("IsMute") as? Bool)!
            m_BestScore = dicData?.objectForKey("BestScore") as? Int64
        }
        else
        {
            NSLog("Load data.plist fail !!")
            m_IsMute = false
            m_BestScore=0
        }
        
    }
    
    func GetIsMute() -> Bool
    {
        return m_IsMute!;
        
    }
    
    func GetBestScore() -> Int64 {
        return m_BestScore!;
        
    }
    
    func WriteBestScore(p_socre: Int64)
    {
        let pathData: String = self.GetPathData()
        let dicData: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: pathData)!
        if let l_dicData = dicData
        {
            l_dicData.setObject(NSNumber(longLong: p_socre), forKey:"BestScore")
            l_dicData.writeToFile(pathData, atomically:true)
            m_BestScore=p_socre
            print("Best new score:\(m_BestScore)")
            
        }
        else
        {
            NSLog("Load data plist info fail !!")
            
        }
        
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
            
            print("Copied data plist")
            print("Source:\(sourcePath)")
            print("Destination:\(destinationPath)")
            
        }
        else
        {
            NSLog("File exist")
            
        }
        
        return destinationPath;
        
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
    
}

