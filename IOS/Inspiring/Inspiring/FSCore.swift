//
//  FSCore.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

let SERVER_URL = "http://cusiki.com:7777/api/inspiring"
let NUMBER_IMAGES_ONCE_LOAD = 30
class FSCore
{
    var m_TestArry = NSMutableArray()
    var m_ArrayImage = [Story]()
    var m_ArrayFavorite = [Story]()
    var m_IsLoading: Bool = false
    var m_ReadingCount:Int = 0
  
    static let ShareInstance = FSCore()
    private init()
    {
        m_IsLoading = false
    
    } // This prevents others from using the default '()' initializer for this class
    

}
