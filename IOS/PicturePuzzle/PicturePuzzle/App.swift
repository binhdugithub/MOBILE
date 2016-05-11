//
//  App.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 5/10/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class App: NSObject
{
    
    var m_name: String
    var m_imgurl: String
    var m_link: String
    var m_imgdata: NSData!
    
    override init()
    {
        m_name = ""
        m_imgurl = ""
        m_link = ""
        m_imgdata = nil
    }
    
    init(p_name: String, p_imageurl: String, p_link: String)
    {
        m_name = p_name
        m_imgurl = p_imageurl
        m_link = p_link
    }


}
