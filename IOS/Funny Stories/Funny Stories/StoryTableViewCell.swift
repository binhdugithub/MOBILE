//
//  StoryTableViewCell.swift
//  TableViewDemo
//
//  Created by Nguyễn Thế Bình on 12/19/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit



class StoryTableViewCell: UITableViewCell
{
    
    var m_Row: Int = -1
 
    @IBOutlet weak var m_UIImageTitle: UIImageView!

    @IBOutlet weak var m_UILabelTitle: UILabel!
    //@IBOutlet weak var m_UIImageTick: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        //View
        self.frame.size.width = SCREEN_WIDTH
        self.frame.size.height = FSDesign.ShareInstance.CELL_HEIGHT
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = true;
        self.contentView.frame.size.width = self.frame.size.width
        self.contentView.frame.size.height = self.frame.size.height
        self.contentView.frame.origin.x = 0
        self.contentView.frame.origin.y = 0
        
        print("contentView Width: \(self.contentView.frame.size.width) and height: \(self.contentView.frame.size.height)")
        print("self Width: \(self.frame.size.width) and height: \(self.frame.size.height)")
        
        //m_UIImageTitle
        self.m_UIImageTitle.translatesAutoresizingMaskIntoConstraints = true;
        self.m_UIImageTitle.frame = CGRectMake(
            FSDesign.ShareInstance.CELL_MARGIN,
            FSDesign.ShareInstance.CELL_MARGIN,
            self.contentView.frame.size.height - FSDesign.ShareInstance.CELL_MARGIN * 2,
            self.contentView.frame.size.height - 2 * FSDesign.ShareInstance.CELL_MARGIN)
        self.m_UIImageTitle.contentMode = .ScaleToFill
        
        
        //m_UILabelTitle
        self.m_UILabelTitle.translatesAutoresizingMaskIntoConstraints = true;
        self.m_UILabelTitle.textAlignment = NSTextAlignment.Right
        self.m_UILabelTitle.numberOfLines = 1
        //        self.m_UILabelTitle.font = UIFont(name: "Avenir-Light", size: 15.0)
        //        self.m_UILabelTitle.font = UIFont.boldSystemFontOfSize(15)
        //        self.m_UILabelTitle.font = UIFont.italicSystemFontOfSize(15)
        self.m_UILabelTitle.font = UIFont.systemFontOfSize(20)
        let currentFontHeight = self.m_UILabelTitle?.intrinsicContentSize().height
        print("Height of font: \(currentFontHeight)")
        
        self.m_UILabelTitle.frame.origin.x = self.m_UIImageTitle.frame.origin.x + self.m_UIImageTitle.frame.size.width
        self.m_UILabelTitle.frame.origin.y = self.m_UIImageTitle.frame.origin.y
        self.m_UILabelTitle.frame.size.width = self.contentView.frame.size.width - self.m_UILabelTitle.frame.origin.x - FSDesign.ShareInstance.CELL_MARGIN
        self.m_UILabelTitle.frame.size.height = currentFontHeight!
        
        print("Size of label title: ", self.m_UILabelTitle.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        //print("You select cell")
        //self.selectedBackgroundView?.backgroundColor = UIColor.brownColor()
        
    }
    
    override func layoutSubviews()
    {
        //print("lay out subviews", self.m_Row)
        super.layoutSubviews()
        
    }
    
    func SetRow(p_row: Int?)
    {
        if let l_row: Int = p_row
        {
            self.m_Row = l_row
        }
    }
    
    func SetBackgroundColor(p_0: UIColor, p_1: UIColor)
    {
       
        if (m_Row % 2) == 0
        {
            self.contentView.backgroundColor = p_0
        }
        else
        {
            self.contentView.backgroundColor = p_1
        }
        
    }

    
    func SetImage(p_image: UIImage?)
    {
        if NSThread.isMainThread()
        {
            if let image = p_image
            {
                m_UIImageTitle.image = image
            }
            else
            {
                m_UIImageTitle.image = UIImage(named: "home")
            }
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
                            if let image = p_image
                            {
                                self.m_UIImageTitle.image = image
                            }
                            else
                            {
                                self.m_UIImageTitle.image = UIImage(named: "home")
                            }
                    }
            }
        }
        
    }
    
    func SetTitle(p_title: String?)
    {
        if NSThread.isMainThread()
        {
            if let title = p_title
            {
                m_UILabelTitle!.text = title
            }
            else
            {
                m_UILabelTitle.text = "This is default title"
            }
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
                            if let title = p_title
                            {
                                self.m_UILabelTitle!.text = title
                            }
                            else
                            {
                                self.m_UILabelTitle.text = "This is default title"
                            }
                    }
            }
        }
        
    }
}
