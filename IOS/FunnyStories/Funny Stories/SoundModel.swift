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
  
    var m_PlayerStory: AVPlayer?
    var m_LastURLStory: String = String("")
  
    private override init()
    {
        do
        {
            let path: String = NSBundle.mainBundle().pathForResource("click", ofType:"mp3")!
            let mp3URL: NSURL = NSURL.fileURLWithPath(path)
            m_AudioPlayerClickButton = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
         
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            m_AudioPlayerClickButton!.numberOfLoops = 0
          
        }
        catch let l_error as NSError
        {
            print("Error init: \(l_error)")
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
        
      
          m_AudioPlayerClickButton?.currentTime = 0
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
    
    func IsMute() -> Bool
    {
        //return Configuration.ShareInstance.GetIsMute();
        return false
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

      
      NSNotificationCenter.defaultCenter().addObserver(p_object, selector: Selector("PlayerItemDidReachEnd:"), name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
      
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
        NSNotificationCenter.defaultCenter().addObserver(p_object, selector: Selector("PlayerItemDidReachEnd:"), name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
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

      NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("PlayerItemDidReachEnd:"), name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
      
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("PlayerItemDidReachEnd:"), name: AVPlayerItemDidPlayToEndTimeNotification, object: m_PlayerStory?.currentItem)
        m_PlayerStory?.play()
        
      }
    }
  }
  
}


