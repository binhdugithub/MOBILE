//
//  DBModel.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 3/5/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

import UIKit
import GameKit

class DBModel
{
  static let ShareInstance = DBModel()
  
  private init()
  {
    
  }

  
  //Create Database
  func CreateDatabase(p_name: String) -> Bool
  {
    let l_dabPath = GetDocPathFile(FILE_DATABASE)
    
    if !NSFileManager.defaultManager().fileExistsAtPath(l_dabPath)
    {
      
      let l_funnyDB = FMDatabase(path: l_dabPath as String)
      
      if l_funnyDB == nil
      {
        print("Create database \(p_name) failed: \(l_funnyDB.lastErrorMessage())")
        return false
      }
      else
      {
        print("Creat database ok")
      }
      
      return true
    }
    
    return false
  }//end CreateDatabase
  
  
  func CreateTable(p_name: String) -> Bool
  {
    
    let l_dabPath = GetDocPathFile(FILE_DATABASE)
    let l_funnyDB = FMDatabase(path: l_dabPath as String)
    
    if l_funnyDB == nil
    {
      print("Create table \(p_name) failed: \(l_funnyDB.lastErrorMessage())")
      return false
    }
    

    if l_funnyDB.open()
    {
      let sql_stmt = "CREATE TABLE IF NOT EXISTS Story (id INTEGER PRIMARY KEY NOT NULL, title CHAR (512) NOT NULL, content TEXT NOT NULL,imageurl CHAR(512), image BLOD DEFAULT(NULL),audiourl CHAR(256), audio BLOD DEFAULT (NULL), favorite BOOLEAN NOT NULL DEFAULT (0));"
      if !l_funnyDB.executeStatements(sql_stmt)
      {
        print("Create table \(p_name) failed:\(l_funnyDB.lastErrorMessage())")
        l_funnyDB.close()
        return false
        
      }
      
      print("Create table ok: \(l_dabPath)")
      l_funnyDB.close()
      return true
    }
    else
    {
      print("Create table Error: \(l_funnyDB.lastErrorMessage())")
    }

    return false
    
  }//end CreateTable

  
  func GetAllStories() -> FMResultSet?
  {
    let l_pathDB = GetDocPathFile(FILE_DATABASE)
    let l_funnyDB = FMDatabase(path: l_pathDB)
    if l_funnyDB.open()
    {
      let l_query = "SELECT * from Story"
      let l_results:FMResultSet? = l_funnyDB.executeQuery(l_query, withArgumentsInArray: nil)
      
      while  l_results?.next() == true
      {
        let l_id = Int((l_results?.intForColumn("id"))!)
        let l_title = l_results?.stringForColumn("title")
        let l_content = l_results?.stringForColumn("content")
        let l_image = l_results?.dataForColumn("image")
        let l_audio = l_results?.dataForColumn("audio")
        let l_liked = l_results?.boolForColumn("favorite")
        let l_imageurl = l_results?.stringForColumn("imageurl")
        let l_audiourl = l_results?.stringForColumn("audiourl")
        
        let l_Story = Story(p_id: l_id, p_title: l_title, p_content: l_content, p_imageurl: l_imageurl, p_image: l_image, p_audiourl: l_audiourl, p_audio: l_audio, p_like: l_liked)
        
        FSCore.ShareInstance.m_ArrayStory.append(l_Story)
        FSCore.ShareInstance.m_ArrayTemp.append(l_Story.Copy())
        
        print("id: \(l_Story.m_id)  img: \(l_Story.m_imageurl) audio: \(l_Story.m_audiourl)")

      }
      
      l_funnyDB.close()
      return l_results
    }
    else
    {
      print("GetAllStories failed: \(l_funnyDB.lastErrorMessage())")
    }

    return nil
  }//end GetAllStories
  
  
  //InsertStory
  func InsertStory(p_story: Story) -> Bool
  {
    if p_story.m_image == nil
    {
      return false
    }
    
    let l_pathDB = GetDocPathFile(FILE_DATABASE)
    let l_funnyDB = FMDatabase(path: l_pathDB)
    
    if l_funnyDB.open()
    {
      
        do
        {
          let insertSQL = "INSERT INTO Story(id, title, content,imageurl, image, audiourl, audio, favorite) VALUES(?,?,?,?,?,?,?,?)"
          try l_funnyDB.executeUpdate(insertSQL,values:  [p_story.m_id!,
                                                          p_story.m_title!,
                                                          p_story.m_content!,
                                                          p_story.m_imageurl!,
                                                          p_story.m_image == nil ? NSNull() : p_story.m_image!,
                                                          p_story.m_audiourl!,
                                                          p_story.m_audio == nil ? NSNull() : p_story.m_audio!,
                                                          p_story.m_liked!])
          
          print("Insert \(p_story.m_id) ok")
          
          l_funnyDB.close()
          return true
          
        }
        catch let ex as NSError
        {
          print("Error: \(ex.description)")
          l_funnyDB.close()
        }
    }
    else
    {
      print("Open db failed: \(l_funnyDB.lastErrorMessage())")
    }
    
    return false
  }//End InsertStory
  
  
  
  //UpdateFavoriteStory
  func UpdateFavoriteStory(p_Story: Story) -> Bool
  {
    
    let l_pathDB = GetDocPathFile(FILE_DATABASE)
    let l_funnyDB = FMDatabase(path: l_pathDB)
    
    if l_funnyDB.open()
    {
      
      do
      {
        let updateSQL = "UPDATE Story SET favorite = ? WHERE id = ?"
        try l_funnyDB.executeUpdate(updateSQL,values: [p_Story.m_liked!, p_Story.m_id!])
        
        print("Update \(p_Story.m_id) set favorite =  \(p_Story.m_liked) ok")
        
        l_funnyDB.close()
        return true
        
      }
      catch let ex as NSError
      {
        print("Error: \(ex.description)")
        l_funnyDB.close()
      }
    }
    else
    {
      print("Open db failed: \(l_funnyDB.lastErrorMessage())")
    }
    
    return false
  }//End UpdateFavoriteStory
  
  
  
  //UpdateFavoriteStory
  func UpdateAudio(p_Story: Story) -> Bool
  {
    
    let l_pathDB = GetDocPathFile(FILE_DATABASE)
    let l_funnyDB = FMDatabase(path: l_pathDB)
    
    if l_funnyDB.open()
    {
      
      do
      {
        let updateSQL = "UPDATE Story SET audio = ? WHERE id = ?"
        try l_funnyDB.executeUpdate(updateSQL,values: [p_Story.m_audio!, p_Story.m_id!])
        
        print("Update audio for \(p_Story.m_id) ok")
        
        l_funnyDB.close()
        return true
        
      }
      catch let ex as NSError
      {
        print("Error: \(ex.description)")
        l_funnyDB.close()
      }
    }
    else
    {
      print("Open db failed: \(l_funnyDB.lastErrorMessage())")
    }
    
    return false
  }//End UpdateFavoriteStory
  
  


}
