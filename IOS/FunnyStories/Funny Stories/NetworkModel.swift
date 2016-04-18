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
    
    
  
  func GETStories(p_id: Int,  p_limit: Int = NUMBER_IMAGES_ONCE_LOAD, p_object: HomeViewController) -> Bool
  {
    if (self.m_IsLoading == true)
    {
      print("Is loading => return")
      return false
    }
    else
    {
      print("Get sotires")
    }
    
  
    self.m_IsLoading = true
    let l_url : String =  SERVER_URL + String("/stories")
      
    Alamofire.request(.GET, l_url, parameters: ["id_start": "\(p_id)", "limit" : "\(p_limit)"]).responseJSON(){
        p_response in
      
      print("Request: \(p_response.request)")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        {
            switch p_response.result
            {
              case .Failure(let error):
                print("Request failed with error: \(error)")
              
                if error.code == -6006
                {
                    dispatch_async(dispatch_get_main_queue())
                    {
                        p_object.ShowToast("We'll update the story as soon as possible.")
                    }
                }
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
                      
                      //print("id: \(p_story.m_id) audio: \(p_story.m_audiourl)")
                    }
                  }
                  
                  //refresh UI
                  dispatch_async(dispatch_get_main_queue())
                  {
                      p_object.ReloadData()
                  }
                  
                  
                  if FSCore.ShareInstance.m_ArrayStory.count - FSCore.ShareInstance.m_ArrayTemp.count >= 10
                  {
                    print("************ Insert story in database **********")
                    let l_i = FSCore.ShareInstance.m_ArrayTemp.count
                    for i in l_i..<FSCore.ShareInstance.m_ArrayStory.count
                    {
                      if DBModel.ShareInstance.InsertStory(FSCore.ShareInstance.m_ArrayStory[i]) == false
                      {
                        break
                      }
                      else
                      {
                        FSCore.ShareInstance.m_ArrayTemp.append(FSCore.ShareInstance.m_ArrayStory[i].Copy())
                      }
                    }
                  }
                  else
                  {
                    print("ArrayStory: \(FSCore.ShareInstance.m_ArrayStory.count) and Temp: \(FSCore.ShareInstance.m_ArrayTemp.count)")
                  }
                  
                }//end if listStories.cout > 0
              
              }//end switch

          dispatch_async(dispatch_get_main_queue())
          {
            if (p_object.m_Indicator!.isAnimating())
            {
              p_object.m_Indicator!.stopAnimating()
            }
          }
          
          self.m_IsLoading = false
        }//end dispatch_async
        
      
        
    }//end Alamofire.request
    
    return true
    
  }//end function GETStories
  
  
  func GETApps(p_object: MoreViewController) -> Bool
  {
    if (self.m_IsLoading == true)
    {
      print("Is loading => return")
      return false
    }
    
    self.m_IsLoading = true
    
    let l_url : String =  SERVER_URL + String("/apps")
    
    Alamofire.request(.GET, l_url, parameters: nil).responseJSON(){
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
            let JSONApps = JSONResponse.valueForKey("apps")! as! [NSDictionary]
            let listApps = JSONApps.map{
              //Story(p_id: $0.valueForKey("id") as! Int, , p_imageurl: $0.valueForKey("imageurl") as! String, )
              App(p_name: $0.valueForKey("nameapp") as! String, p_imageurl: $0.valueForKey("imageurl") as! String, p_link: $0.valueForKey("linkapp") as! String)
            }
            
            if listApps.count > 0
            {
              
              for p_app in listApps
              {
                FSCore.ShareInstance.m_ArrayApp.append(p_app)
              }
              
              //refresh UI
              dispatch_async(dispatch_get_main_queue())
              {
                  p_object.SetupMoreAppView()
              }
            }//end if listApps.cout > 0
            
          }//end switch
          
      }//end dispatch_async
      
      self.m_IsLoading = false
      
    }//end Alamofire.request
    
    return true
    
  }//end function GETApps
  

  }//end class
