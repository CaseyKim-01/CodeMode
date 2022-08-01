//
//  ViewController.swift
//  CodeMode
//
//  Created by Casey Kim on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var RecordLabel: UILabel!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Switch.isOn = false 
    }

    @IBAction func StartStopSwitch(_ sender: UISwitch) {
        
        if (sender.isOn)
        {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerCounter), userInfo: nil, repeats: true)
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            TitleLabel.textColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            TimerLabel.textColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            RecordLabel.textColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        }
        else
        {
            timerCounting = false
            timer.invalidate()
            self.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            TitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            
            TimerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            RecordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @objc func TimerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 3600))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    @IBAction func ResetTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you want to reset the timer?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.Switch.isOn = false
            self.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            self.TitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            
            self.TimerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            self.RecordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SaveTapped(_ sender: UIButton) {
        
        RecordLabel.text = "Record: " + TimerLabel.text!
    }
}

