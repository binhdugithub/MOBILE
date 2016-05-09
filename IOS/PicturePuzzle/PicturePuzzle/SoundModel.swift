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
    var m_AudioPlayerClick: AVAudioPlayer!
    var m_AudioPlayerGameOver: AVAudioPlayer!
    var m_AudioPlayerGameWin: AVAudioPlayer!
    var m_AudioPlayerSwap: AVAudioPlayer!
    var m_AudioPlayerWinCoin: AVAudioPlayer!
    var m_ismuted: Bool!
  
  
    private override init()
    {
        
    }
    
    func ChangeMute()
    {
        var l_IsMute: Bool = SoundController.ShareInstance.m_ismuted
        l_IsMute = l_IsMute ? false : true
        Configuration.ShareInstance.WriteMute(l_IsMute)
    }
  
    func WinCoin()
    {
        if SoundController.ShareInstance.m_ismuted == true
        {
            return;
        }
        
        do
        {
            
            let path = NSBundle.mainBundle().pathForResource("wincoin", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerWinCoin = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            m_AudioPlayerWinCoin?.currentTime = 0
            if m_AudioPlayerWinCoin!.prepareToPlay()
            {
                if m_AudioPlayerWinCoin!.play()
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
    

    func PlayClick()
    {
        if SoundController.ShareInstance.m_ismuted == true
        {
            return;
        }
      
        do
        {
            
            let path = NSBundle.mainBundle().pathForResource("click", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerClick = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DefaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            m_AudioPlayerClick?.currentTime = 0
            if m_AudioPlayerClick!.prepareToPlay()
            {
              if m_AudioPlayerClick!.play()
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
    
    
    func PlayGameOver()
    {
        if SoundController.ShareInstance.m_ismuted == true
        {
            return;
        }
        
        do
        {
            let path = NSBundle.mainBundle().pathForResource("gameover", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerGameOver = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
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
        if SoundController.ShareInstance.m_ismuted == true
        {
            return;
        }
        
        do
        {
            let path = NSBundle.mainBundle().pathForResource("congratulation", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerGameWin = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
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
    
    func PlaySwap()
    {
        if SoundController.ShareInstance.m_ismuted == true
        {
            return;
        }
        
        do
        {
            let path = NSBundle.mainBundle().pathForResource("swap", ofType:"mp3")!
            let mp3URL = NSURL.fileURLWithPath(path)
            m_AudioPlayerSwap = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            if m_AudioPlayerSwap!.prepareToPlay()
            {
                if m_AudioPlayerSwap!.play()
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
  
  
}


