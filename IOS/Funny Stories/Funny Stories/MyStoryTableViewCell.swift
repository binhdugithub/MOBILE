//
//  StoryCell.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/17/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

class MyStoryTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var m_Title: UILabel!
    @IBOutlet weak var m_ImageView: UIImageView!
    @IBOutlet weak var m_ImageTick: UIImageView!
    
    func SetBackGround(p_color: UIColor?)
    {
        if let color = p_color
        {
            self.backgroundColor = color
        }
    }
    
    func SetTick(p_tick: Bool)
    {
        if p_tick
        {
            m_ImageTick.image = UIImage(named: "ok")
        }
        else
        {
            m_ImageTick.image = UIImage()
        }
    }
    
    func SetImage(p_image: UIImage?)
    {
        if let image = p_image
        {
            m_ImageView.image = image
        }
        else
        {
            m_ImageTick.image = UIImage()
        }
    }
    
    func SetTitle(p_title: String?)
    {
        if let title = p_title
        {
            m_Title!.text = title
        }
        else
        {
            m_Title.text = "Default title"
        }
    }
}
