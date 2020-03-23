//
//  NextViewController.swift
//  UIKITChess
//
//  Created by Solayman Rana on 23/3/20.
//  Copyright © 2020 Solayman Rana. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var picker: UIPickerView!
       var hour:Int = 0
       var minutes:Int = 0
       var seconds:Int = 0

    
    @IBAction func onTapBack(_ sender: Any) {
        print(hour)
        print(minutes)
        print(seconds)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        picker.delegate = self
        picker.dataSource = self
        
       // picker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
    }
    
      

}


extension NextViewController:UIPickerViewDelegate,UIPickerViewDataSource {
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
            return "\(row) hour"
        case 1:
            return "\(row) mins"
        case 2:
            return "\(row) secs"
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
