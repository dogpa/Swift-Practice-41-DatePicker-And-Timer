//
//  ViewController.swift
//  Swift Practice # 40 DatePicker And Timer
//
//  Created by CHEN PEIHAO on 2021/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    //倒數器名稱輸入textfield
    @IBOutlet weak var eventNameTextField: UITextField!
    //DatePicker選擇器
    @IBOutlet weak var eventDateSelectDatePicker: UIDatePicker!
    //顯示textField的Label
    @IBOutlet weak var eventNameLabel: UILabel!
    //顯示datePikcker的日期string的label
    @IBOutlet weak var eventDateLabel: UILabel!
    //倒數器顯示的天數
    @IBOutlet weak var dayOfEventCountLabel: UILabel!
    //倒數器顯示的小時
    @IBOutlet weak var hoursOfEventCountLabel: UILabel!
    //倒數器顯示的分鐘
    @IBOutlet weak var minutesOfEventCountLabel: UILabel!
    //倒數器顯示的秒
    @IBOutlet weak var secondsOfEventCountLabel: UILabel!
    //定義timer 倒數時間用
    var timer : Timer?
    
    
    
    //點選任何位置收鍵盤的function
    func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
    view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //點選任意位置收鍵盤
        self.hideKeyboardWhenTappedAround()
    }

    func dateCountStart() {
        
        //將datepicker所選擇的「日期」指定給eventDate
        let eventDate = eventDateSelectDatePicker.date
        
        
        
        //讓eventDateLabel顯示datepicker選擇的時間
        
        //定義formatter為可以將時間轉換成字串的DateFormatter()
        let formatter = DateFormatter()
        //將指定好的formatter的格式透過.dateFormat指派為指定的時間顯示內容
        formatter.dateFormat = "yyyy/MM/dd"
        //將.dateFormat的字串顯示內容指派給showTOLabelDate
        //而showTOLabelDate取得的時間來原則為指派給eventDate的使用則選擇的date picker
        let showTOLabelDate = formatter.string(from: eventDate)
        //將處理好的時間轉字串的格式顯示在eventDateLabel（顯示選定的時間的label）
        eventDateLabel.text = showTOLabelDate
        
        
        //計算倒數計時
        
        //透過if else判斷 若是timer已經有時間進去的話
        //則將原本的timer取消
        if let timer = timer {
            timer.invalidate()
        }
        
        //啟用timer觸發事件，間隔為每一秒
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            //將目前與datepicker的時間差透過.timeIntervalSinceNow使用後
            //指派給interval
            let interval = Int(eventDate.timeIntervalSinceNow)
            //取得時間差的秒數的餘數
            let eventSconds = interval % 60
            //取得時間差的分鐘的餘數
            let eventMinutes = interval / 60 % 60
            //取得時間差的小時的餘數
            let eventHours = interval / 60 / 60 % 24
            //取得時間差的天數
            let eventDay = interval / 60 / 60 / 24
            
            //將取得到的剩餘「天」「時」「分」「秒」各自指派給已經準備好的Label
            self.secondsOfEventCountLabel.text = "\(eventSconds) 秒"
            self.minutesOfEventCountLabel.text = "\(eventMinutes) 分"
            self.hoursOfEventCountLabel.text = "\(eventHours) 小時"
            self.dayOfEventCountLabel.text = "\(eventDay) 天"
        }

    }//自訂dateCountStart()結束位置

    //Date Pikcer的Action
    @IBAction func dateSelect(_ sender: Any) {
        //執行寫好的dateCountStart()function
        dateCountStart()
        
    }
    
    //UITextField的Action
    @IBAction func eventNameWrite(_ sender: Any) {
        //按return收鍵盤
        view.endEditing(true)
        //講textfield的內容指派給ventNameTextField
        eventNameLabel.text = eventNameTextField.text
    }
    
    
}

