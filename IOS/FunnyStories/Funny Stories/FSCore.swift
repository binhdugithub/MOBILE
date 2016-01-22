//
//  FSCore.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

let SERVER_URL = "http://cusiki.com:8888/api/funnystories"
class FSCore
{
    var m_TestArry = NSMutableArray()
    var m_ArrayStory = [Story]()
    var m_ArrayFavorite = [Story]()
    var m_EndOfData: Bool = false
    var m_sem: dispatch_semaphore_t?
    var m_ReadingCount:Int = 0
  
    static let ShareInstance = FSCore()
    private init()
    {
    
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
  
    func GETListStory(p_id: Int)
    {
      if m_EndOfData == true
      {
        print("End of database")
        return
      }
      
        let l_url : String =  SERVER_URL + String("/stories?id_start=\(p_id)&limit=10")
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
      
        m_sem = dispatch_semaphore_create(0)
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedListStory)
        l_task.resume()
      
        dispatch_semaphore_wait(m_sem!, DISPATCH_TIME_FOREVER)
    }
  
  
  
    func LoadedListStory(data:NSData?,response:NSURLResponse?,let err:NSError?)
    {
        print("LoadedListTitle")
      
        if err != nil
        {
          print("Have error: \(err)")
          dispatch_semaphore_signal(m_sem!)
          return
        }
      
      
        if let res: NSHTTPURLResponse = response as? NSHTTPURLResponse
        {
            if (res.statusCode != 200)
            {
              print("Result have problem")
              dispatch_semaphore_signal(m_sem!)
              return
            }
            //print("Status code:\(res.statusCode)")
            do
            {
              let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: [[String: AnyObject]]]
              
              if let l_JSON = JSON
              {
                let l_stories: [[String: AnyObject]] = l_JSON["stories"]!
                
                if l_stories.count == 0
                {
                  print("End of database")
                }
                else
                {
                  for story in l_stories
                  {
                    //print("------------------------")
                    let l_story: Story = Story(p_id: nil, p_title: nil, p_content: nil, p_image: nil, p_liked: false)
                    story["id"]
                    
                    if let p_id = story["id"]  as? Int
                    {
                      l_story.m_id = p_id
                    }
                    
                    if let p_title = story["title"] as? String
                    {
                      l_story.m_title = p_title
                    }
                    
                    if let p_content = story["content"] as? String
                    {
                      l_story.m_content = p_content
                    }
                    
                    
                    if let p_image = story["image"] as? String
                    {
                      l_story.m_imageurl = p_image
                    }
                    
                    if let p_audio = story["audio"] as? String
                    {
                      l_story.m_audiourl = p_audio
                    }
                    
                    m_ArrayStory.append(l_story)
                    let l_index = Configuration.ShareInstance.m_Favorite!.indexOfObject(l_story.m_id!)
                    if l_index != NSNotFound
                    {
                      l_story.m_liked = true
                      m_ArrayFavorite.append(l_story)
                    }
                    
                  }
                  
                  m_ArrayStory.sortInPlace({$0.m_id < $1.m_id})
                  
                }
              
              }//end if let l_JSON = JSON
          
            }
            catch let JSONError as NSError
            {
              print("\(JSONError)")
              //3840 "No value"
              //
              if JSONError.code == 3840
              {
                self.m_EndOfData = true
              }
              
              dispatch_semaphore_signal(m_sem!)
              return
            }
        }
        else//server error
        {
            if let l_code = err?.code
            {
                print("Code:\(l_code)")
                switch l_code
                {
                case -1001:
                    print("Server is die")
                case -1004:
                    print("Server is under maintenance mode !")
                case -1022:
                    print("App Transport Security policy requires the use of a secure connection")
                default:
                    print("Error: \(l_code)")
                }
            
            }
        }
      
      
        dispatch_semaphore_signal(m_sem!)
    }
    
    
    func GETStory(p_id: Int)
    {
        let l_url : String = SERVER_URL + String("/story/?id=") + String(p_id)
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedStory)
        l_task.resume()
    }
    
    
    func LoadedStory(p_data:NSData?, p_response:NSURLResponse?, let p_err:NSError?)
    {
        if let res: NSHTTPURLResponse = p_response as? NSHTTPURLResponse
        {
            print("Do with story: \(res.statusCode)")
        }
        else
        {
            if let l_domain = p_err?.domain
            {
                print("Domain:" + l_domain)
            }
            
            if let l_code = p_err?.code
            {
                print("Code:\(l_code)")
                switch l_code
                {
                case -1001:
                    print("Server is die")
                case -1004:
                    print("Server is under maintenance mode !")
                case -1022:
                    print("App Transport Security policy requires the use of a secure connection")
                default:
                    print("Error: \(l_code)")
                }
            }
        }
    }

  
  func GETListImage(p_object: AnyObject?)
  {
    if m_EndOfData == true
    {
      //print("End of database")
      return
    }

    let l_size = m_ArrayStory.count
  
    for i in 0..<l_size
    {
      if(self.m_ArrayStory[i].m_image != nil)
      {
        continue
      }
      
      if let l_path: String = self.m_ArrayStory[i].m_imageurl!
      {
        let l_url:NSURL? = NSURL(string: l_path)!
        if l_url == nil
        {
          continue
        }
        
        let l_request: NSMutableURLRequest = NSMutableURLRequest(URL: l_url!)
        l_request.timeoutInterval = 10.0
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(l_request)
          {   (data, response, error) -> Void in
            if let p_error = error
            {
              if p_error.code != 200
              {
                switch p_error.code
                {
                case -1001:
                  print("Server is die")
                case -1004:
                  print("Server is under maintenance mode !")
                case -1022:
                  print("App Transport Security policy requires the use of a secure connection")
                default:
                  print("Error: \(p_error.code)")
                }
                
                
              }
              
            }
            else if let res: NSHTTPURLResponse = response as? NSHTTPURLResponse
            {
              if (res.statusCode != 200)
              {
                print("Result have problem")
              }
              else
              {
                if(self.m_ArrayStory[i].m_image == nil)
                {
                  if let resultdata = data
                  {
                    //print("Set uiiamge for \(response)")
                    self.m_ArrayStory[i].m_image = NSData(data: resultdata)
                    
                    var indexPaths = [NSIndexPath]()
                    if let l_indexpath = self.m_ArrayStory[i].m_row
                    {
                      indexPaths.append(l_indexpath)
                      
                      if NSThread.isMainThread()
                      {
                        p_object?.collectionView??.reloadItemsAtIndexPaths(indexPaths)
                        
                      }
                      else
                      {
                        dispatch_sync(dispatch_get_main_queue(),
                          {
                            p_object?.collectionView??.reloadItemsAtIndexPaths(indexPaths)
                            
                            
                        });
                        
                        
                      }
                      
                    }
                  }
                  
                }
                
              }//end res is 200
              
            }//end not error
        }
        
        task.resume()
      }
      
    }//end for
  }
  
  
  func GETListAudio(p_object: AnyObject?)
  {
    if m_EndOfData == true
    {
      //print("End of database")
      return
    }

    let l_size = m_ArrayStory.count
    
    for i in 0..<l_size
    {
      if(self.m_ArrayStory[i].m_audio != nil)
      {
        continue
      }
      
      print("Load audio:\(self.m_ArrayStory[i].m_id)")
      let l_path: String = self.m_ArrayStory[i].m_audiourl!
      let l_url:NSURL? = NSURL(string: l_path)!
      //print("url:\(l_path)")
      let l_request: NSMutableURLRequest = NSMutableURLRequest(URL: l_url!)
      l_request.timeoutInterval = 10.0
      
      let task = NSURLSession.sharedSession().dataTaskWithRequest(l_request)
        {   (p_data, response, error) -> Void in
          if let p_error = error
          {
            if p_error.code != 200
            {
              switch p_error.code
              {
              case -1001:
                print("Server is die")
              case -1004:
                print("Server is under maintenance mode !")
              case -1022:
                print("App Transport Security policy requires the use of a secure connection")
              default:
                print("Error: \(p_error.code)")
              }
            }
          }
          else
          {
            if(self.m_ArrayStory[i].m_audio == nil)
            {
              //print("Set audio for \(self.m_ArrayStory[i].m_id): \(p_data?.length)")
              let l_audio = NSData(data: p_data!)
              self.m_ArrayStory[i].m_audio = l_audio
              
            }
            
          }
      }
      
      task.resume()
    }
  }
  
  // GET audio
  func GETAudio(l_id: Int, p_sender: StoryViewController)
  {
    let l_size = self.m_ArrayStory.count
    var l_index: Int = 0
    for i in 0..<l_size
    {
      if self.m_ArrayStory[i].m_id == l_id
      {
        l_index = i
        break
      }
    }

    if(self.m_ArrayStory[l_index].m_audio != nil)
    {
      return
    }
    
      let l_path: String = self.m_ArrayStory[l_index].m_audiourl!
      let l_url:NSURL? = NSURL(string: l_path)!
      print("url:\(l_path)")
      let l_request: NSMutableURLRequest = NSMutableURLRequest(URL: l_url!)
      l_request.timeoutInterval = 10.0
      
    NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:
        {   (p_data, response, error) -> Void in
          if let p_error = error
          {
            if p_error.code != 200
            {
              switch p_error.code
              {
              case -1001:
                print("Server is die")
              case -1004:
                print("Server is under maintenance mode !")
              case -1022:
                print("App Transport Security policy requires the use of a secure connection")
              default:
                print("Error: \(p_error.code)")
              }
            }
          }
          else
          {
            if(self.m_ArrayStory[l_index].m_audio == nil)
            {
              //print("Set audio for \(self.m_ArrayStory[l_index].m_id):\(p_data?.length)")
              self.m_ArrayStory[l_index].m_audio = p_data
              p_sender.PlayAudio()
            }
            else
            {
              print("\(self.m_ArrayStory[l_index].m_title) already have audio: \(self.m_ArrayStory[l_index].m_audio!.length)")
            }
          }
    }).resume()
    
  }
  //end GETAudio
  
    func MmakePostRequest()
    {
        
        let urlPath: String = "http://192.168.0.13:8888/api/funnystories/story/"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        let stringPost="id=3&title=xxx" // Key and Value
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 10
        request.HTTPBody=data
        request.HTTPShouldHandleCookies=false
        
        //let queue:NSOperationQueue = NSOperationQueue()
        //NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:loadedData)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:
            { (data:NSData?,response:NSURLResponse?,let err:NSError?) -> Void in
                //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                do
                {
                    let jsonResult: NSDictionary? = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                    
                    if (jsonResult != nil)
                    {
                        // Success
                        print(jsonResult)
                        
                    }else
                    {
                        // Failed
                        print("Failed")
                    }
                }
                catch let JSONError as NSError
                {
                    print("\(JSONError)")
                }
                
                //end catch
        })
        
    }
  
  
    func ScreenShot() -> UIImage
    {
      let layer = UIApplication.sharedApplication().keyWindow!.layer
      let scale = UIScreen.mainScreen().scale
      UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
      
      layer.renderInContext(UIGraphicsGetCurrentContext()!)
      let screenshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
      
      return screenshot
    }
    
}
