//
//  PPCore.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import Foundation
class PPCore
{
    static let ShareInstance = PPCore()
    var m_ArrayPhoto = [Photo]()
    var m_complete_photo = false
    
    private init()
    {
        print("Coin is : \(Configuration.ShareInstance.m_coin)")
        LoadListPhoto()
        
        //self.DiaplayArray()
    }
    
    //load list photo
    func LoadListPhoto() -> Void
    {
        let pathData: String = GetDocPathFile(FILE_DATA)
        let dicData: NSDictionary? = NSDictionary(contentsOfFile: pathData)!

        if dicData != nil
        {
            //print("Dic: \(dicData)")
            for (p_id, p_completed) in dicData!
            {
                let l_photo = Photo(p_id: p_id as! String, p_completed: PHOTO_STATUS(rawValue: p_completed as! Int)!)
                m_ArrayPhoto.append(l_photo)
            }
            
            m_ArrayPhoto.sortInPlace{$0.m_id < $1.m_id}
        }
        else
        {
            NSLog("Load data.plist fail !!")
            
        }
    }
    
    func DiaplayArray() -> Void
    {
        for p_photo in m_ArrayPhoto
        {
            print("id: \(p_photo.m_id)")
        }
    }
    
}