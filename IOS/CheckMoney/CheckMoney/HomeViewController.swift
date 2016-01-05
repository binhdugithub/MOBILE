//
//  HomeViewController.swift
//  CheckMoney
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblSum: UILabel!
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
   
    func registerBackgroundTask()
    {
        backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler
        {
            [unowned self] in
            self.endBackgroundTask()
        }
        
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask()
    {
        NSLog("Background task ended.")
        UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reinstateBackgroundTask"), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reinstateBackgroundTask"), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
//        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
//        appDelegate.myHomeView = self
        
        let myThread = NSThread(target:self, selector:"ThreadGetMoney:", object:nil)
        myThread.start()
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func reinstateBackgroundTask()
    {
        if backgroundTask == UIBackgroundTaskInvalid
        {
            registerBackgroundTask()
        }
    }
    
    func ThreadGetMoney(p_url: String)
    {
        while 1 > 0
        {
            GETMoney()
            sleep(5)
        }
    }
    
    func GETMoney()
    {
        let l_url : String =  String("http://ice.gamesupport.vn/library/XenForo/Qlnt.php?today=")
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: l_url)
        l_request.HTTPMethod = "GET"
        l_request.timeoutInterval = 10
        let l_task = NSURLSession.sharedSession().dataTaskWithRequest(l_request, completionHandler:LoadedMoney)
        l_task.resume()
    }
    
    
    func LoadedMoney(data:NSData?,response:NSURLResponse?,let err:NSError?)
    {
        
        if let res: NSHTTPURLResponse = response as? NSHTTPURLResponse
        {
            print("Status code:\(res.statusCode)")
            do
            {
                guard let JSON: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? NSDictionary else
                {
                    print("parse json failed")
                    return
                }
                
                
                let old_count = Int(lblCount.text!)
                
                
                if let new_count: Int = JSON["Count"] as? Int
                {
                    let new_sum: Int = (JSON["Sum"] as? Int)!
                    
                    if new_count != old_count
                    {
                        print("Update")
                        if NSThread.isMainThread()
                        {
                            lblCount.text = String(new_count)
                            SoundController.ShareInstance.PlayCongratulation()
                            self.lblSum.text = String(new_sum)
            
                        }
                        else
                        {
                            dispatch_sync(dispatch_get_main_queue(),{
                                self.lblCount.text = String(new_count)
                                self.lblSum.text = String(new_sum)
                                SoundController.ShareInstance.PlayCongratulation()

                                });
                            
                            
                        }
                        
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
}
