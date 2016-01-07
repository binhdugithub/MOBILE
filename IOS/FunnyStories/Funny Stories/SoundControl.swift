//
//  SoundController.swift
//  CheckMoney
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation

class SoundController: NSObject
{
    static let ShareInstance = SoundController()
    var m_AudioPlayerClickButton: AVAudioPlayer?
    var m_AudioPlayerGameOver: AVAudioPlayer?
    var m_AudioPlayerGameWin: AVAudioPlayer?
    var m_AudioPlayerCorrect: AVAudioPlayer?
    var m_AudioPlayerStory: AVAudioPlayer?
  
    var m_PlayerStory: AVPlayer?
    var m_LastURLStory: String = String("")
  
    private override init()
    {
        do
        {
            var path: String = NSBundle.mainBundle().pathForResource("click", ofType:"mp3")!
            var mp3URL: NSURL = NSURL.fileURLWithPath(path)
            m_AudioPlayerClickButton = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            path = NSBundle.mainBundle().pathForResource("gameover", ofType:"mp3")!
            mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerGameOver = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            path = NSBundle.mainBundle().pathForResource("congratulation", ofType:"mp3")!
            mp3URL=NSURL.fileURLWithPath(path)
            m_AudioPlayerGameWin = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            path = NSBundle.mainBundle().pathForResource("correct", ofType:"mp3")!
            mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerCorrect = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
          
        }
        catch let l_error as NSError
        {
            print("Error: \(l_error)")
        }
    }
    
    func ChangeMute()
    {
        var l_IsMute: Bool = Configuration.ShareInstance.GetIsMute()
        l_IsMute = l_IsMute ? false : true
        Configuration.ShareInstance.WriteMute(l_IsMute)
    }
  

  
    func PlayButton()
    {
        if IsMute()
        {
            return;
        }
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            m_AudioPlayerClickButton!.numberOfLoops = 1
            if m_AudioPlayerClickButton!.prepareToPlay()
            {
                if m_AudioPlayerClickButton!.play()
                {
                    
                } else {
                    
                }
            }
            else
            {
                print("Prepaire play fail")
            }
           
        }
        catch let l_error as NSError
        {
             print("\(l_error)")
        }
        
    }
    
    func IsMute() -> Bool
    {
        return Configuration.ShareInstance.GetIsMute();
    }
    
    func PlayGameOver()
    {
        if IsMute()
        {
            return;
        }
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            if m_AudioPlayerGameOver!.prepareToPlay()
            {
                m_AudioPlayerGameOver!.play()
            }
            else
            {
                print("Prepaire play fail")
            }
        }
        catch let l_error as NSError
        {
            print("\(l_error)")
        }
    }
    
    func PlayCongratulation()
    {
        if IsMute()
        {
            return;
        }
        
        do
        {
            let path = NSBundle.mainBundle().pathForResource("congratulation", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerGameWin = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            
            print("Play win")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
           
        
            if m_AudioPlayerGameWin!.prepareToPlay()
            {
                if m_AudioPlayerGameWin!.play()
                {
                    print("Play ok")
                } else
                {
                    print("Play failed")
                }
            }
            else
            {
                print("Prepaire play fail")
                m_AudioPlayerGameWin!.play()
            }
        }
        catch let l_error as NSError
        {
            print("Play Congratulation:\(l_error)")
        }
        
    }
    
    func PlayCorrect()
    {
        if IsMute()
        {
            return;
        }
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            if m_AudioPlayerCorrect!.prepareToPlay()
            {
                if m_AudioPlayerCorrect!.play()
                {
                    
                } else {
                    
                }
            }
            else
            {
                print("Prepaire play fail")
            }
        }
        catch let l_error as NSError
        {
            print("\(l_error)")
        }
    }
  
  
  
  func PlayURL(p_url: String, p_object: AnyObject)
  {
    print("Play: \(p_url)")
    
    if m_PlayerStory == nil
    {
      let l_url = NSURL(string: p_url)
      m_LastURLStory = p_url
      m_PlayerStory  = AVPlayer(URL: l_url!)
      m_PlayerStory?.volume = 1.0

      
      NSNotificationCenter.defaultCenter().addObserver(p_object, selector: "PlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
      
      m_PlayerStory?.play()
      
    }
    else
    {
      if m_LastURLStory == p_url
      {
        print("Rate:\(m_PlayerStory?.rate)")

        if m_PlayerStory?.rate == 0 &&  (m_PlayerStory?.currentItem?.status == .ReadyToPlay)
        {
          m_PlayerStory?.play()
        }
        else
        {
          m_PlayerStory?.pause()
        }
        
      }
      else
      {
        let l_url = NSURL(string: p_url)
        m_LastURLStory = p_url
        
        m_PlayerStory  = AVPlayer(URL: l_url!)
        m_PlayerStory?.volume = 1.0
        //m_PlayerStory?.actionAtItemEnd = .Pause
        NSNotificationCenter.defaultCenter().removeObserver(p_object)
        NSNotificationCenter.defaultCenter().addObserver(p_object, selector: "PlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
        m_PlayerStory?.play()
        
      }
      
    }
    
  }
  
  
  func PlayURL(p_url: String)
  {
    print("Play: \(p_url)")
    
    if m_PlayerStory == nil
    {
      let l_url = NSURL(string: p_url)
      m_LastURLStory = p_url
      m_PlayerStory  = AVPlayer(URL: l_url!)
      m_PlayerStory?.volume = 1.0

      NSNotificationCenter.defaultCenter().addObserver(self, selector: "PlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
      
      m_PlayerStory?.play()
      
    }
    else
    {
      if m_LastURLStory == p_url
      {
        print("Rate:\(m_PlayerStory?.rate)")
        
        if m_PlayerStory?.rate == 0 &&  (m_PlayerStory?.currentItem?.status == .ReadyToPlay)
        {
          m_PlayerStory?.play()
        }
        else
        {
          m_PlayerStory?.pause()
        }
        
      }
      else
      {
        let l_url = NSURL(string: p_url)
        m_LastURLStory = p_url
        
        m_PlayerStory  = AVPlayer(URL: l_url!)
        m_PlayerStory?.volume = 1.0
        //m_PlayerStory?.actionAtItemEnd = .Pause
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "PlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
        m_PlayerStory?.play()
        
      }
    }
  }
  
  func PauseStory()
  {
    if m_PlayerStory == nil
    {
      //print("Audio is nil")
      return
    }
    
    if m_PlayerStory?.rate != 0
    {
      m_PlayerStory?.pause()
      //let newTime = CMTimeMakeWithSeconds(0, 1);
      //m_PlayerStory?.seekToTime(newTime)
    }
    else
    {
      print("Audio is already paused")
    }
  }
  
  
  func PlayData(p_data: NSData?)
  {
    if let l_data = p_data
    {
      do
      {
        m_AudioPlayerStory = try  AVAudioPlayer(data: l_data)
        
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        m_AudioPlayerStory!.numberOfLoops = 1
        if m_AudioPlayerStory!.prepareToPlay()
        {
          m_AudioPlayerStory!.play()
        }
        else
        {
          print("Prepaire play fail")
        }
        
      }
      catch
      {
        // couldn't load file :(
        print("Couldn't load file")
      }
      
    }//end p_data is not nil
    
  }//end PlayData

}


extension SoundController
{
  func PlayerItemDidReachEnd (p_notify: NSNotification)
  {
    let newTime = CMTimeMakeWithSeconds(0, 1);
    m_PlayerStory?.seekToTime(newTime)

  }
}

