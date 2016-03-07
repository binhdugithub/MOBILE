//
//  FSCore.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/5/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

class FSCore
{
  static let ShareInstance = FSCore()
  var m_ArrayStory = [Story]()
  var m_ArrayTemp = [Story]()
  var m_ArrayUI = [Int]()
  var m_ReadingCount:Int = 0
  var m_OldSizeStories = 0
  var m_IndexStoryStartDisplayed = 0
  
  
  private init()
  {
    if let abc = Configuration.ShareInstance.m_CurrentStory
    {
      m_IndexStoryStartDisplayed = abc
      print("StoryDisplayed: \(m_IndexStoryStartDisplayed)")
    }
    else
    {
      m_IndexStoryStartDisplayed = 0
      print("StoryDisplayed: \(m_IndexStoryStartDisplayed)")
    }
  }
  
  //NextStoryFavorite
  func NextStoryFavorite(p_story: Story?) -> Story?
  {
    if p_story == nil
    {
      return nil
    }
    
    var l_ok = false
    for l_story in FSCore.ShareInstance.m_ArrayStory
    {
      if l_story.m_id == p_story!.m_id
      {
        l_ok = true
      }
      else if l_story.m_liked == true && l_ok == true
      {
        return l_story
      }

    }
    
    let story: Story? = GetStoryAtIndexFavorite(0)
    
    return story
    
  }//end NextStoryFavorite
  
  
  //NextStoryFavorite
  func PreStoryFavorite(p_story: Story?) -> Story?
  {
    if p_story == nil
    {
      return nil
    }
    
    var l_storytmp: Story? = nil
    
    for l_story in FSCore.ShareInstance.m_ArrayStory
    {
      
      if l_story.m_id == p_story!.m_id
      {
        if l_storytmp != nil
        {
          return l_storytmp
        }
        else
        {
          break
        }
      }
      
      if l_story.m_liked == true
      {
        l_storytmp = l_story
      }
      
    }
    
    return GetLastSotryFavorite()
  }//end NextStoryFavorite
  
  
  
  func IndexOfStoryInArrayStory(p_Story: Story) -> Int
  {
    if m_ArrayStory.count == 0
    {
      return -1
    }
    else
    {
      var l_i = 0
      for l_Story in m_ArrayStory
      {
        if l_Story.m_id == p_Story.m_id
        {
          return l_i
        }
        
        l_i++
      }
      
      if l_i == m_ArrayStory.count
      {
        return -1
      }
    }
    
    return 0
  }
  
  func GetStoryAtIndexFavorite(p_indexfavorite: Int) -> Story?
  {
    var l_count = -1
    for p_story in FSCore.ShareInstance.m_ArrayStory
    {
      if p_story.m_liked == true
      {
        l_count++
        
        if l_count == p_indexfavorite
        {
          return p_story
        }
      }
    }
    
    return nil
  }//end GetStory
  
  
  func GetLastSotryFavorite() -> Story?
  {
    var l_storytmp: Story? = nil
    
    for l_story in FSCore.ShareInstance.m_ArrayStory
    {
      if l_story.m_liked == true
      {
        l_storytmp = l_story
      }
    }
    
    return l_storytmp
  }//end GetStory

}