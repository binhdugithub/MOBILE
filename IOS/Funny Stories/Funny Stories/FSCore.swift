//
//  FSCore.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

let SERVER_URL = "http://192.168.0.106:8888/api/funnystories"
class FSCore
{
    var m_ArrayStory = [[String: AnyObject]]()
    var m_LoadedListTitle: Bool = false
    
    static let ShareInstance = FSCore()
    private init()
    {
    
    } // This prevents others from using the default '()' initializer for this class
    
    
    func GETListTitle()
    {
        let l_url : String =  SERVER_URL + String("/stories")
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedListTitle)
        l_task.resume()
    }
    
    
    func LoadedListTitle(data:NSData?,response:NSURLResponse?,let err:NSError?)
    {
        
        if let res: NSHTTPURLResponse = response as? NSHTTPURLResponse
        {
            print("Status code:\(res.statusCode)")
            do
            {
                guard let JSON: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0)) else
                {
                    print("parse json failed")
                    return
                }
                
                if let stories = JSON["stories"] as? [[String: AnyObject]]
                {
                    m_ArrayStory = [[String: AnyObject]]()
                    m_LoadedListTitle = true
                    
                    for story in stories
                    {
                        //print("------------------------")
                        var l_story = [String: AnyObject]()
                        
                        if let p_id = story["id"] as? Int
                        {
                            l_story["id"] = p_id
                            //print("ID: \(p_id)")
                        }
                        
                        if let p_title = story["title"] as? String
                        {
                            l_story["title"] = p_title
                            //print(p_title)
                        }
                        
                        if let p_image = story["image"] as? String
                        {
                            l_story["image"] = p_image
                            //print(p_image)
                        }
                        
                        if let p_audio = story["audio"] as? String
                        {
                            l_story["audio"] = p_audio
                            //print(p_audio)
                        }
                        
                        if let p_rate = story["rate"] as? Int
                        {
                            l_story["rate"] = String(p_rate)
                            //print("Rate: \(p_rate)")
                        }
                        
                        m_ArrayStory.append(l_story)
                        //m_ArrayStory.sortInPlace({$0["id"] < $1["id"]})
                    }
                    
                }
            }
            catch let JSONError as NSError
            {
                print("\(JSONError)")
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
    
    
    func GETImageForCell(p_cell: StoryTableViewCell, p_row: Int)
    {
       
        let l_path: String = self.m_ArrayStory[p_row]["image"]! as! String
        let l_url:NSURL? = NSURL(string: l_path)!
        
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
                        
                        p_cell.SetImage(nil)
                    }
                    
                }
                else
                {
                    //print("Set data for:", p_cell.m_UILabelTitle.text)
                    let l_data = NSData(data: data!)
                    let l_image = UIImage(data: l_data)
                    self.m_ArrayStory[p_row]["uiimage"] = l_data
                    p_cell.SetImage(l_image)
                }
                
        }
        
        task.resume()
        
        
        return
    }
    
    
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
    
}
