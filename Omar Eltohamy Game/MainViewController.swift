//
//  MainViewController.swift
//  Omar Eltohamy Game
//
//  Created by oeltoham on 11/5/17.
//  Copyright © 2017 oeltoham. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var numbersLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    @IBOutlet weak var timeLabel:UILabel?
    
    var score:Int = 0
    var timer:Timer?
    var seconds: Int = 60
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setRandomNumberLabel()
        updateScoreLabel()
        
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for:UIControlEvents.editingChanged)
    }

    func updateScoreLabel()
    {
        scoreLabel?.text = "\(score)"
    }
    
    func updateTimeLabel()
    {
        if (timeLabel != nil)
        {
            let min:Int = (seconds / 60) % 60
            let sec:Int = seconds % 60
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            timeLabel!.text = "\(min_p):\(sec_p)"
        }
    }
    
    func setRandomNumberLabel()
    {
        numbersLabel?.text = generateRandomString()
    }
    
    func textFieldDidChange(textField:UITextField)
    {
        if inputField?.text?.characters.count ?? 0 < 4
        {
            return
        }
        
        if let numbers_text = numbersLabel?.text,
           let input_text = inputField?.text,
           let numbers = Int(numbers_text),
           let input = Int(input_text)
        {
            print("Comparing: \(input_text) minus \(numbers_text) == \(input - numbers)")
            
            if(input-numbers == 2222)
            {
                print("Correct")
                score -= -1
            }
        }
        setRandomNumberLabel()
        updateScoreLabel()
        if(timer == nil)
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo:nil, repeats:true)
        }
    }
    
    func onUpdateTimer() -> Void
    {
        if(seconds > 0 && seconds <= 60)
        {
            seconds -= 1
            updateTimeLabel()
            
        }
        else if(seconds == 0)
        {
            if(timer != nil)
            {
                timer!.invalidate()
                timer = nil
                let alertController = UIAlertController(title: "Game Over!", message: "Done! This is your score: \(score) points. Try again?", preferredStyle: .alert)
                let tryagainAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                alertController.addAction(tryagainAction)
                self.present(alertController, animated: true, completion: nil)
                score = 0
                seconds = 60
                updateTimeLabel()
                updateScoreLabel()
                setRandomNumberLabel()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func generateRandomString() -> String
    {
        var result:String = ""
        for _ in 1...4
        {
            let digit:Int = Int(arc4random_uniform(8)+1)
            
            result += "\(digit)"
        }
        
        return result
    }
}
