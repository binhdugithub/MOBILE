//
//  SoundController.swift
//  CheckMoney
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation

class SoundController
{
    static let ShareInstance = SoundController()
    var m_AudioPlayerClickButton: AVAudioPlayer?
    var m_AudioPlayerGameOver: AVAudioPlayer?
    var m_AudioPlayerGameWin: AVAudioPlayer?
    var m_AudioPlayerCorrect: AVAudioPlayer?
    
    private init()
    {
        do
        {
            var path: String = NSBundle.mainBundle().pathForResource("click", ofType:"mp3")!
            var mp3URL: NSURL = NSURL.fileURLWithPath(path)
            m_AudioPlayerClickButton = try AVAudioPlayer(contentsOfURL:mp3URL, fileTypeHint:nil)
            path = NSBundle.mainBundle().pathForResource("gameover", ofType:"mp3")!
            mp3URL=NSURL.fileURLWithPath(path)
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
            //try AVAudioSession.sharedInstance().setActive(true)
           
        
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
    

}
