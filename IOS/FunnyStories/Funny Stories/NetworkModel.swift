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
let NUMBER_IMAGES_ONCE_LOAD = 20

enum KEY_UI: Int
{
  case UI_RELOAD_COLLECTION = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

class NetWorkModel
{
    
    var m_IsLoading: Bool = false
  
    static let ShareInstance = NetWorkModel()
    private init()
    {
      m_IsLoading = false
    } // This prevents others from using the default '()' initializer for this class
    
    
  
  func GETStories(p_id: Int, p_type: Int, p_object: HomeViewController, p_limit: Int = NUMBER_IMAGES_ONCE_LOAD, p_thefirst: Int = 1) -> Bool
  {
    if (self.m_IsLoading == true)
    {
      print("Is loading => return")
      return false
    }
    
    self.m_IsLoading = true
    
    let l_url : String =  SERVER_URL + String("/stories")
      
    Alamofire.request(.GET, l_url, parameters: ["id_start": "\(p_id)", "limit" : "\(p_limit)", "type" : "\(p_type)", "thefirst" : "\(p_thefirst)"]).responseJSON(){
        p_response in
      
      print("Request: \(p_response.request)")
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
                var listStories = JSONStories.map{
                  //Story(p_id: $0.valueForKey("id") as! Int, , p_imageurl: $0.valueForKey("imageurl") as! String, )
                  Story(p_id: $0.valueForKey("id") as? Int, p_title: $0.valueForKey("title") as? String, p_content: $0.valueForKey("content") as? String, p_imageurl: $0.valueForKey("image") as? String, p_audiourl: $0.valueForKey("audio") as? String);
                }
                
                listStories.sortInPlace({$0.m_id < $1.m_id})
                if listStories.count > 0
                {
                  for p_story in listStories
                  {
                    let l_i = FSCore.ShareInstance.IndexOfStoryInArrayStory(p_story)
                    if l_i == -1
                    {
                      FSCore.ShareInstance.m_ArrayStory.append(p_story)
                      
                      print("id: \(p_story.m_id) audio: \(p_story.m_audiourl)")
                    }
                  }
                  
                  //refresh UI
                  dispatch_async(dispatch_get_main_queue())
                  {
                      p_object.ReloadData()
                  }
                }//end if listStories.cout > 0
              
              }//end switch
          
          
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
          {
            dispatch_async(dispatch_get_main_queue())
            {
              if (p_object.m_Indicator!.isAnimating())
              {
                p_object.m_Indicator!.stopAnimating()
              }
            }
          }

        }//end dispatch_async
        
        self.m_IsLoading = false
        
    }//end Alamofire.request
    
    return true
    
  }//end function GETStories
  
  
//  func GETStory(p_id: Int, p_object: FavoriteViewController) -> Bool
//  {
//    print("Id: \(p_id)")
//    
//    let l_url : String =  SERVER_URL + String("/story")
//    
//    Alamofire.request(.GET, l_url, parameters: ["id": "\(p_id)"]).responseJSON(){
//      p_response in
//      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
//        {
//
//        switch p_response.result
//        {
//        case .Failure(let error):
//          print("Request failed with error: \(error)")
//        case .Success(let JSON):
//          //print("Success with JSON: \(JSON)")
//          let JSONResponse = JSON as! NSDictionary
//          let l_id = JSONResponse.valueForKey("id")! as? Int
//          let l_title = JSONResponse.valueForKey("title")! as? String
//          let l_content = JSONResponse.valueForKey("content")! as? String
//          let l_imageurl   = JSONResponse.valueForKey("image")! as? String
//          let l_audiourl = JSONResponse.valueForKey("audio")! as? String
//          
//          let l_Story = Story(p_id: l_id, p_title: l_title, p_content: l_content, p_imageurl: l_imageurl, p_audiourl: l_audiourl)
//          l_Story.m_liked = true
//          FSCore.ShareInstance.m_ArrayFavorite.append(l_Story)
//
//          FSCore.ShareInstance.m_ArrayFavorite.sortInPlace({$0.m_id < $1.m_id})
//          
//          if FSCore.ShareInstance.m_ArrayFavorite.count == Configuration.ShareInstance.m_Favorite?.count
//          {
//            dispatch_async(dispatch_get_main_queue())
//            {
//                p_object.ReloadData()
//            }
//          }
//         
//
//        }//end switch
//      }
//      
//    }//end Alamofire.request
//    
//    return true
//    
//  }//end function GETStory

  }//end class
