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

class NetWorkModel
{
    
    var m_IsLoading: Bool = false
  
    static let ShareInstance = NetWorkModel()
    private init()
    {
      m_IsLoading = false
    } // This prevents others from using the default '()' initializer for this class
    
  
  
  func GETApps() -> Bool
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
                PPCore.ShareInstance.m_ArrayApp.append(p_app)
              }
              
              //refresh UI
//              dispatch_async(dispatch_get_main_queue())
//              {
//                  p_object.ReloadGUI()
//              }
            }//end if listApps.cout > 0
            
          }//end switch
          
      }//end dispatch_async
      
      self.m_IsLoading = false
      
    }//end Alamofire.request
    
    return true
    
  }//end function GETApps
  

  }//end class
