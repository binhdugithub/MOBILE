//
//  ViewController.swift
//  CheckMoney
//
//  Created by Nguyễn Thế Bình on 12/21/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

//let SERVER: String = "http://gamesupport.vn/admindav.php"
let SERVER: String = "http://ice.gamesupport.vn/library/XenForo/Qlnt.php"
class ViewController: UIViewController
{

    @IBOutlet weak var m_startdate: UITextField!
    @IBOutlet weak var m_enddate: UITextField!
    @IBOutlet weak var m_Collection: UICollectionView!
    
    
    
    var m_ArrayMoney = [[String: String]]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let age = -3
//        assert(age >= 0, "A person's age cannot be less than zero")
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func RequestMoney(p_url: String)
    {
        print(p_url)
        let l_request : NSMutableURLRequest = NSMutableURLRequest()
        l_request.URL = NSURL(string: p_url)
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
                let JSONS: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                print("Buoc 1")
                if let p_jsmoney = JSONS["money"] as? [[String: String]]
                {
                    m_ArrayMoney = [[String: String]]()
                    for l_JSON in p_jsmoney
                    {
                        print("------------------------")
                        var l_money = [String: String]()
                        
                        if let p_id: String = l_JSON["id"]
                        {
                            l_money["id"] = p_id
                            print("ID: \(p_id)")
                        }
                        
                        if let p_user = l_JSON["user"]
                        {
                            l_money["user"] = p_user
                            print(p_user)
                        }
                        
                        if let p_mgt = l_JSON["mgt"]
                        {
                            l_money["mgt"] = p_mgt
                            print(p_mgt)
                        }
                        
                        if let p_timent = l_JSON["timent"]
                        {
                            l_money["timent"] = p_timent
                            print(p_timent)
                        }
                        
                        if let p_card_id = l_JSON["card_id"]
                        {
                            l_money["card_id"] = String(p_card_id)
                            print(p_card_id)
                        }
                        
                        m_ArrayMoney.append(l_money)
                        //m_ArrayStory.sortInPlace({$0["id"] < $1["id"]})
                        
                        self.m_Collection.reloadData()
                    }
                    
                }
                
            }
            catch let JSONError as NSError
            {
                let myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                
                print("Parsing failed:\(JSONError) and data: \(response)")
                
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

    @IBAction func OneByDateClick(sender: UIButton)
    {
        var l_path: String = SERVER
            l_path += String("?startdate=")
            l_path += m_startdate.text!
            l_path += String("&enddate=")
            l_path += m_enddate.text!
            l_path += String("&show=0")
        
        self.RequestMoney(l_path)
    }
    
    
}


extension ViewController: UICollectionViewDataSource
{
    
    //UICloolectionViewSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  m_ArrayMoney.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: CellControl = collectionView.dequeueReusableCellWithReuseIdentifier("CellControl", forIndexPath: indexPath) as! CellControl
        
        cell.backgroundColor = UIColor.whiteColor()
        let l_row = indexPath.row / 5
        let l_column = indexPath.row % 5
        
        switch l_column
        {
        case 0:
            cell.lblTitle.text = m_ArrayMoney[l_row]["id"]
        case 1:
            cell.lblTitle.text = m_ArrayMoney[l_row]["user"]
        case 2:
            cell.lblTitle.text = m_ArrayMoney[l_row]["mgt"]
        case 3:
            cell.lblTitle.text = m_ArrayMoney[l_row]["timent"]
        case 4:
            cell.lblTitle.text = m_ArrayMoney[l_row]["card_id"]
        default:
            cell.lblTitle.text = "Default"
        }
        
        cell.lblTitle.textAlignment = .Left
        //cell.lblTitle.f
        return cell
    }

}

extension ViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print("Cell \(indexPath.row)")
        
        let alert = UIAlertController(title: "didSelectItemAtIndexPath:", message: "Indexpath = \(indexPath)", preferredStyle: .Alert)
        
        let alertAction = UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil)
        alert.addAction(alertAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        let picDimension = self.view.frame.size.width / 6.0
//        return CGSizeMake(picDimension, picDimension)
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
//    {
//        let leftRightInset = self.view.frame.size.width / 14.0
//        return UIEdgeInsetsMake(0, 1, 0, 1)
//    }
}
