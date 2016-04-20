//
//  Photo.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import Foundation

enum PHOTO_STATUS: Int
{
    case PHOTO_LOCK = 0, PHOTO_NOT_COMPLETED, PHOTO_COMPLETED
}

class Photo: NSObject {
    
    var m_id: Int!
    var m_name: String!
    var m_completed: PHOTO_STATUS!
    

    override init()
    {
        m_id = -1
        m_name = String(m_id) + ".jpg"
        m_completed = PHOTO_STATUS.PHOTO_LOCK
    }
    
    init(p_id: String, p_completed: PHOTO_STATUS)
    {
        m_id = Int(p_id)
        m_name = p_id + ".jpg"
        m_completed = p_completed
    }
    
    
}
