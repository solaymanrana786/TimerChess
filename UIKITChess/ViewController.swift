//
//  ViewController.swift
//  UIKITChess
//
//  Created by Solayman Rana on 22/3/20.
//  Copyright © 2020 Solayman Rana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static var xxx:Double = 300
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    var timer1 =  Timer()
    var timer2 =  Timer()
    
    var getTime1: String = ""
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    
    
    
    @IBOutlet weak var downTimeLabel: UILabel!
    @IBOutlet weak var upTimeLabel: UILabel!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var upView: UIView!
    
    struct Config {
        static var timerLength: Double = xxx
    }
    
    struct Config2 {
        static var timerLength2: Double = xxx
    }
    
    
    var timeRemaining = Config.timerLength {
        didSet {
            upTimeLabel.text = formattedTime(timeRemaining)
        }
    }
    
    
    var timeRemaining2 = Config2.timerLength2 {
        didSet {
            downTimeLabel.text = formattedTime(timeRemaining2)
        }
    }
    
    @IBAction func pickerDownButtontTapped(_ sender: Any) {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .countDownTimer
        
        datePicker.addTarget(self, action: #selector(self.dateChanged2(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick2))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
    }
    
  
    @IBOutlet weak var upPicker: UIButton!
    @IBAction func pickerButtonTapped(_ sender: Any) {
        
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .countDownTimer
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @IBAction func settingButtontapped(_ sender: Any) {
        
    }
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBAction func pauseButtontapped(_ sender: Any) {
         timer1.invalidate()
         timer2.invalidate()
         pauseButton.alpha = 0
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        timeRemaining = Config.timerLength
        timeRemaining2 = Config2.timerLength2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnView2(_:))))
        upView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnView1(_:))))
        downTimeLabel.text = formattedTime(timeRemaining2)
        upTimeLabel.text = formattedTime(timeRemaining)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = .none
        //        dateFormatter.timeStyle = .long
        
        dateFormatter.dateFormat = "HH:mm"
        
        
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            let timeInt = date.timeIntervalSince1970
            
            //            getTime1 = dateFormatter.string(from: date)
            upTimeLabel.text = dateFormatter.string(from: date)
            //            let lastTime: Double = Double(getTime1)
            ViewController.self.xxx = timeInt
        }
        
    }
    
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    
    @objc func dateChanged2(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = .none
        //        dateFormatter.timeStyle = .long
        
        dateFormatter.dateFormat = "HH:mm"
        
        
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            let timeInt = date.timeIntervalSince1970
            
            //            getTime1 = dateFormatter.string(from: date)
            downTimeLabel.text = dateFormatter.string(from: date)
            //            let lastTime: Double = Double(getTime1)
            ViewController.self.xxx = timeInt
        }
        
    }
    
    @objc func onDoneButtonClick2() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    
    @objc func tapOnView1(_ sender: UITapGestureRecognizer) {
        startTimer2()
        downView.backgroundColor = .yellow
        upView.backgroundColor = .white
        timer1.invalidate()
        upView.isUserInteractionEnabled = false
        downView.isUserInteractionEnabled = true
         pauseButton.alpha = 1
    }
    
    @objc func tapOnView2(_ sender: UITapGestureRecognizer) {
        startTimer()
        upView.backgroundColor = .yellow
        downView.backgroundColor = .white
        timer2.invalidate()
        upView.isUserInteractionEnabled = true
        downView.isUserInteractionEnabled = false
         pauseButton.alpha = 1t
    }
    
    func formattedTime(_ time: Double) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time - Double(minutes) * 60)
        let milliseconds = Int((time - Double(minutes) * 60 - Double(seconds)) * 10)
        let formattedString: String!
        
        if minutes == 0 {
            formattedString = "\(seconds).\(milliseconds)"
        } else {
            if seconds < 10 {
                formattedString =  "\(minutes):0\(seconds)"
            } else {
                formattedString = "\(minutes):\(seconds)"
            }
        }
        return formattedString
    }
    
    func startTimer() {
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 0.1
            if timeRemaining <= 0 {
                timeRemaining = 0
                view.backgroundColor = .orange
            }
        }
    }
    
    func startTimer2() {
        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(updateTimer2)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer2() {
        if timeRemaining2 > 0 {
            timeRemaining2 -= 0.1
            if timeRemaining2 <= 0 {
                timeRemaining2 = 0
                view.backgroundColor = .orange
            }
        }
    }
}



extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
    }
}
