//
//  FirstViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/14/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

let SERVER_URL = "http://192.168.0.106:8888/api/funnystories"
let cellIdentifier = "StoryTableViewCell"

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var m_TableView: UITableView!
    //@IBOutlet weak var m_TableView: UITableView!
    var m_ArrayStory = [[String: String]]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //NSLog("Width: %f And Height: %f", SCREEN_WIDTH, SCREEN_HEIGHT);
        m_TableView.delegate = self
        m_TableView.dataSource = self
        m_TableView.backgroundColor = UIColor.whiteColor()
        let testFrame : CGRect = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)
        m_TableView.frame = testFrame
        
        self.navigationItem.title = String("Home")
        
        RequestListTitle()
       
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RequestListTitle()
    {
        let l_url : String =  SERVER_URL + String("/stories")
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedListTitle)
        l_task.resume()
    }
    
    
    func RequestStory(p_id: Int)
    {
        let l_url : String = SERVER_URL + String("/story/?id=") + String(p_id)
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedStory)
        l_task.resume()
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

    
    func LoadedStory(p_data:NSData?,p_response:NSURLResponse?,let p_err:NSError?)
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
    
    func LoadedListTitle(data:NSData?,response:NSURLResponse?,let err:NSError?)
    {
        
        if let res: NSHTTPURLResponse = response as? NSHTTPURLResponse
        {
            print("Status code:\(res.statusCode)")
            //print("Error:")
            //print(err)
            
            
            do
            {
                guard let JSON: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0)) else
                {
                    print("parse json failed")
                    return
                }
                
                if let stories = JSON["stories"] as? [[String: AnyObject]]
                {
                    for story in stories
                    {
                        //print("------------------------")
                        var l_story = [String: String]()
                        
                        if let p_id = story["id"] as? Int
                        {
                            l_story["id"] = String(p_id)
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
                        m_ArrayStory.sortInPlace({$0["id"] < $1["id"]})
                    }
                }
            }
            catch let JSONError as NSError
            {
                print("\(JSONError)")
            }
            
            if NSThread.isMainThread()
            {
                m_TableView?.reloadData()
            }
            else
            {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0))
                    {
                        //do some task
                        dispatch_async(dispatch_get_main_queue())
                            {
                                //update UI
                                self.m_TableView?.reloadData()
                        }
                }
            }
        }
        else//server error
        {
            if let l_domain = err?.domain
            {
                print("Domain:" + l_domain)
            }
            
            if let l_code = err?.code
            {
                print("Code:\(l_code)")
                //code = -1001 Server die
                //code = -1004 Cannot connect to server
                
                switch l_code
                {
                case -1001:
                    print("Server is die")
                case -1004:
                    print("Server is under maintenance mode !")
                default:
                    print("Error: \(l_code)")
                }
            }
        }
    
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.m_ArrayStory.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.m_TableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StoryTableViewCell
        
        if let p_title = self.m_ArrayStory[indexPath.row]["title"]
        {
            print("title:" + p_title)
            cell.SetTitle(p_title)
        }
        else
        {
            cell.SetTitle("This is default")
        }
        
        if let p_url = self.m_ArrayStory[indexPath.row]["image"]
        {
            let l_url:NSURL? = NSURL(string: p_url)!
            
            do
            {
//                let l_data = try NSData(contentsOfURL: l_url!, options:NSDataReadingOptions())
//                let l_image = UIImage(data: l_data)!
//                if let p_image: UIImage = l_image
//                {
//                    cell.SetImage(p_image)
//                }
             
                let l_request: NSMutableURLRequest = NSMutableURLRequest(URL: l_url!)
                l_request.timeoutInterval = 3.0
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(l_request)
                    {   (data, response, error) -> Void in
                        if let p_error = error
                        {
                            print("Error:\(p_error.code)")
                            let p_image = UIImage(named: "home")
                            cell.SetImage(p_image)
                        }
                        else
                        {
                            let l_data = NSData(data: data!)
                            let l_image = UIImage(data: l_data)
                            
                            if let p_image: UIImage = l_image
                            {
                                cell.SetImage(p_image)
                            }
                        }
                        
                    }
                
                task.resume()
                
            }
            catch let p_error as NSError?
            {
                print("Get image failed: \(p_error)")
            }
            
            
            print("Vao day")
        }
        
//        if let p_cell: StoryTableViewCell = cell
//        {
//            print("Set animation for cell" + self.m_ArrayStory[indexPath.row]["title"]!)
//            //p_cell.accessoryType  = UITableViewCellAccessoryType.DetailDisclosureButton
//            //p_cell.selectionStyle = UITableViewCellSelectionStyle.None
//        }
        
        
        return cell
    }
    
}

