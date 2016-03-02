//
//  FSCore.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

let SERVER_URL = "http://cusiki.com:8888/api/funnystories"
let NUMBER_IMAGES_ONCE_LOAD = 30

enum KEY_UI: Int
{
  case UI_RELOAD_COLLECTION = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

class FSCore
{
    var m_ArrayStory = [Story]()
    var m_ArrayFavorite = [Story]()
    var m_ArrayUI = [Int]()
  
    var m_ReadingCount:Int = 0
    var m_IsLoading: Bool = false
  
    static let ShareInstance = FSCore()
    private init()
    {
      m_IsLoading = false
    } // This prevents others from using the default '()' initializer for this class
    
  func IndexOfStoryInFaovrite(p_Story: Story) -> Int
  {
    var l_i = 0
    for l_Story in m_ArrayFavorite
    {
      if l_Story.m_id == p_Story.m_id
      {
        return l_i
      }
      
      l_i++
    }
    
    if l_i == m_ArrayFavorite.count
    {
      return -1
    }
    
    return 0
  }
  
  func IndexOfStoryInArrayStory(p_Story: Story) -> Int
  {
    var l_i = 0
    for l_Story in m_ArrayStory
    {
      if l_Story.m_id == p_Story.m_id
      {
        return l_i
      }
      
      l_i++
    }
    
    if l_i == m_ArrayStory.count
    {
      return -1
    }
    
    return 0
  }
  
  
  func GETStories(p_id: Int, p_object: HomeViewController) -> Bool
  {
    if (FSCore.ShareInstance.m_IsLoading == true)
    {
      print("Is loading => return")
      return false
    }
    
    FSCore.ShareInstance.m_IsLoading = true
    
    let l_url : String =  SERVER_URL + String("/stories")
      
    Alamofire.request(.GET, l_url, parameters: ["id_start": "\(p_id)", "limit" : "\(NUMBER_IMAGES_ONCE_LOAD)"]).responseJSON(){
        p_response in
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        {
            switch p_response.result
            {
            case .Failure(let error):
              print("Request failed with error: \(error)")
            case .Success(let JSON):
              //print("Success with JSON: \(JSON)")
              let JSONResponse = JSON as! NSDictionary
              let JSONStories = JSONResponse.valueForKey("stories")! as! [NSDictionary]
              let listStories = JSONStories.map{
                //Story(p_id: $0.valueForKey("id") as! Int, , p_imageurl: $0.valueForKey("imageurl") as! String, )
                Story(p_id: $0.valueForKey("id") as? Int, p_title: $0.valueForKey("title") as? String, p_content: $0.valueForKey("content") as? String, p_imageurl: $0.valueForKey("image") as? String, p_audiourl: $0.valueForKey("audio") as? String);
              }
              
              if listStories.count > 0
              {
                for p_story in listStories
                {
                  let l_i = self.IndexOfStoryInArrayStory(p_story)
                  if l_i == -1
                  {
                    self.m_ArrayStory.append(p_story)
                    let l_index = Configuration.ShareInstance.m_Favorite!.indexOfObject(p_story.m_id!)
                    if l_index != NSNotFound
                    {
                      p_story.m_liked = true
                      self.m_ArrayFavorite.append(p_story)
                    }
                  }
                }//end for p_story in listStories
              }//end if listStories.cout > 0
            
                
                FSCore.ShareInstance.m_ArrayStory.sortInPlace({$0.m_id < $1.m_id})
                
                //                        for var i in 0..<FSCore.ShareInstance.m_ArrayImage.count
                //                        {
                //                            print(FSCore.ShareInstance.m_ArrayImage[i].m_imageurl)
                //                        }
                //
                //Configuration.ShareInstance.WriteCurrentImage(FSCore.ShareInstance.m_ArrayImage[0].m_id!)
                
                // 10
                //                    let indexPaths = (lastItem..<FSCore.ShareInstance.m_ArrayStory.count).map{NSIndexPath(forItem: $0, inSection: 0)}
                //
                // 11
                dispatch_async(dispatch_get_main_queue())
                {
                  if (p_object.m_Indicator!.isAnimating())
                  {
                    p_object.m_Indicator!.stopAnimating()
                  }
                  
                  p_object.ReloadData()
                }
              }//end switch
            
        }//end dispatch_async
        
        FSCore.ShareInstance.m_IsLoading = false
        
    }//end Alamofire.request
    
    return true
    
  }//end function GETStories
  

  }//end class
