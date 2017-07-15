//
//  ViewController2.swift
//  YearRace
//
//  Created by David Ruvinskiy on 5/24/16.
//  Copyright © 2016 David Ruvinskiy. All rights reserved.
//

import UIKit

let monthNames:[String] = ["January", "February", "March", "April", "May", "June", "July", "August",
                           "September",	"October", "November", "December"]

let days:[Int] = Array(1...31)

let debugging = false

var monthToInt: Dictionary<String, Int> = [
    "January" : 1,
    "February" : 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
]

let maxDates:[Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

var undoControls = [false, true]

var showAnswerControls = false

class ViewController2: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentMonth = 1
    var currentDay = 1
    
    var mode = ""
    var firstPlayer = ""
    
    var month = "January"
    var intMonth = 1
    var day = 1
    
    var undoMonth = 1
    var undoDay = 1
    
    @IBOutlet weak var monthLogoImageView: UIImageView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var showAnswerButton: UIButton!
    
    func translateMonth(_ month: Int) -> String {
        if (1 <= month && month <= 12) {
            return monthNames[month - 1];
        }
        
        return "";
    }
    
    func play(_ month: Int, day: Int) {
        let playMonth = translateMonth(month)
        label.text = "My choice is \(playMonth) \(day)."
    }
    
    func start31() {
        if firstPlayer == "Computer" {
            let firstDay = Int(arc4random_uniform(UInt32(18))) + 2
            
            label.text = "I will start with January \(firstDay)."
            day = firstDay
            currentDay = firstDay;
            undoDay = firstDay
            
            let dayRow = convertValueToRow(day, typeOfValue: "day")
            picker.selectRow(dayRow, inComponent: 1, animated: false)
            
            self.pickerView(picker, didSelectRow: 0, inComponent: 0)
            self.pickerView(picker, didSelectRow: dayRow, inComponent: 1)
            
        }
        else if firstPlayer == "Me" {
            label.text = "The starting date is January 1."
        }
    }
    
    func start1() {
        if firstPlayer == "Computer" {
            let firstDay = Int(arc4random_uniform(UInt32(18))) + 13
            
            label.text = "I will start with December \(firstDay)."
            day = firstDay
            currentDay = firstDay;
            undoDay = firstDay
            
            let dayRow = convertValueToRow(day, typeOfValue: "day")
            picker.selectRow(dayRow, inComponent: 1, animated: false)
            
            self.pickerView(picker, didSelectRow: 0, inComponent: 0)
            self.pickerView(picker, didSelectRow: dayRow, inComponent: 1)
        }
        else if firstPlayer == "Me" {
            label.text = "The starting date is December 31."
        }
    }
    
    func getDec31() {
        var won = false
        var theyWon = false
        
        if (!won && !theyWon) {
            if ( !( ( intMonth != currentMonth ) && ( day != currentDay ) ) &&
                !( ( intMonth < currentMonth ) || ( day < currentDay ) ) &&
                !( intMonth == currentMonth && day == currentDay ) )
            {
                
                if (intMonth == 12 && day == 31) {
                    theyWon = true
                    presentWinner("Well done - you win!")
                    return
                }
                else {
                    handleThinking(pausing: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1 ), execute: {
                        // Put your code which should be executed with a delay here
                        
                        if (self.day - self.intMonth == 19) {
                            self.intMonth += 1
                        }
                        else {
                            while (self.day - self.intMonth != 19) {
                                if (self.day - self.intMonth > 19) {
                                    self.intMonth += 1
                                }
                                else if (self.day - self.intMonth < 19) {
                                    self.day += 1
                                }
                            }
                        }
                        
                        self.play(self.intMonth, day: self.day)
                        
                        self.undoMonth = self.currentMonth
                        self.undoDay = self.currentDay
                        
                        self.currentMonth = self.intMonth
                        self.currentDay = self.day
                        
                        
                        // Select the date's rows in the view
                        let monthRow = self.convertValueToRow(self.intMonth, typeOfValue: "month")
                        let dayRow = self.convertValueToRow(self.day, typeOfValue: "day")
                        
                        self.picker.selectRow(monthRow, inComponent: 0, animated: false)
                        self.picker.selectRow(dayRow, inComponent: 1, animated: false)
                        
                        self.pickerView(self.picker, didSelectRow: monthRow, inComponent: 0)
                        self.pickerView(self.picker, didSelectRow: dayRow, inComponent: 1)
                        
                        self.monthLogoImageView.image = UIImage(named: self.month)
                        
                        self.handleThinking(pausing: false)
                        
                        if (self.intMonth == 12 && self.day == 31)
                        {
                            won = true;
                            self.presentWinner("The computer wins!");
                            return
                        }
                    })
                }
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) ) &&
                ( ( intMonth < currentMonth) ) )
            {
                wrongDirectionError("You must pick a later date than \(translateMonth ( currentMonth ) ) \(currentDay).")
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) && ( day < currentDay) ))
            {
                changeBothError()
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) ) )
            {
                changeBothError()
            }
            else if ( ( ( intMonth < currentMonth) || ( day < currentDay ) ) )
            {
                wrongDirectionError("You must pick a later date than \(translateMonth ( currentMonth ) ) \(currentDay).")
            }
            else if ( ( intMonth == currentMonth && day == currentDay ) )
            {
                wrongDirectionError("You must pick a later date than \(translateMonth ( currentMonth ) ) \(currentDay).")
            }
        }
    }
    
    func getJan1() {
        var won = false
        var theyWon = false
        
        if (!won && !theyWon) {
            if ( ( ( intMonth <= 12 && intMonth > 0 )  && ( day <= 31 && day > 0 )) &&
                !( ( intMonth != currentMonth ) && ( day != currentDay ) ) &&
                !( ( intMonth > currentMonth ) || ( day > currentDay ) ) &&
                !( intMonth == currentMonth && day == currentDay ) ) {
                
                if (intMonth == 1 && day == 1)
                {
                    theyWon = true
                    presentWinner("Well done - you win!")
                    return
                } else {
                    handleThinking(pausing: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1 ), execute: {
                        // Put your code which should be executed with a delay here
                        
                        if (self.day == self.intMonth)
                        {
                            self.intMonth -= 1
                        }
                        else
                        {
                            while (self.day != self.intMonth)
                            {
                                if (self.day < self.intMonth)
                                {
                                    self.intMonth -= 1
                                }
                                else if (self.day > self.intMonth)
                                {
                                    self.day -= 1
                                }
                            }
                        }
                        
                        self.play(self.intMonth, day: self.day)
                        
                        self.undoMonth = self.currentMonth
                        self.undoDay = self.currentDay
                        
                        self.currentMonth = self.intMonth
                        self.currentDay = self.day
                        
                        if (debugging) {
                            print("Highlighting row \(12 - self.intMonth) in month component, where intMonth is \(self.intMonth)")
                            print("Highlighting row \(maxDates[monthNames.index(of: self.month)!] - self.day) in day component")
                        }
                        
                        // Select the date's rows in the view
                        let monthRow = self.convertValueToRow(self.intMonth, typeOfValue: "month")
                        let dayRow = self.convertValueToRow(self.day, typeOfValue: "day")
                        
                        self.picker.selectRow(monthRow, inComponent: 0, animated: false)
                        self.picker.selectRow(dayRow, inComponent: 1, animated: false)
                        
                        self.pickerView(self.picker, didSelectRow: monthRow, inComponent: 0)
                        self.pickerView(self.picker, didSelectRow: dayRow, inComponent: 1)
                        
                        self.monthLogoImageView.image = UIImage(named: self.month)
                        
                        self.handleThinking(pausing: false)
                        
                        if (self.intMonth == 1 && self.day == 1)
                        {
                            won = true
                            self.presentWinner("I win!")
                            return
                        }

                    })
                }
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) ) &&
                ( ( intMonth > currentMonth) ) )
            {
                wrongDirectionError("You must pick an earlier date than \(translateMonth ( currentMonth ) ) \(currentDay)." )
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) && ( day > currentDay) ))
            {
                changeBothError()
            }
            else if ( ( ( intMonth != currentMonth ) && ( day != currentDay ) ) )
            {
                changeBothError()
            }
            else if ( ( ( intMonth > currentMonth) || ( day > currentDay ) ) )
            {
                wrongDirectionError("You must pick an earlier date than \(translateMonth ( currentMonth ) ) \(currentDay)." )
            }
            else if ( ( intMonth == currentMonth && day == currentDay ) )
            {
                wrongDirectionError("You must pick an earlier date than \(translateMonth ( currentMonth ) ) \(currentDay)." )
            }
        }
    }
    
    func customError(_ message: String) {
        let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func wrongDirectionError(_ message: String) {
        let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeBothError() {
        let alert:UIAlertController = UIAlertController(title: "Error", message: "You cannot change both the day and the month.", preferredStyle: UIAlertControllerStyle.alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentWinner(_ winnerMessage: String) {
        let alert:UIAlertController = UIAlertController(title: winnerMessage, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "defaultScreen", sender: self)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Takes in a row index given by the pickerView, and converts it to a
     * number corresponding to a date or month, depending on the  game mode.
     */
    func convertRowToValue(_ row: Int, typeOfValue: String) -> Int {
        if (mode == "GetDec31") { // getDec31
            return row + 1
        }
        else {                    // getJan1
            if (typeOfValue == "day") {
                // return maxDates[intMonth-1] - row
                return 31 - row
            }
            else {
                return 12 - row
            }
        }
    }
    
    // ---------------------------------------------------------
    
    /**
     * Takes in a month/date value given by the user, and converts it to a
     * row index in the pickerView, depending on the current game mode.
     */
    func convertValueToRow(_ value: Int, typeOfValue: String) -> Int {
        if (mode == "GetDec31") {  // getDec31
            return value - 1
        }
        else {                     // getJan1
            if (typeOfValue == "day") {
                // return maxDates[monthToInt[month]! - 1] - value
                return 31 - value
            }
            else {
                return 12 - value
            }
        }
    }
    //-------------------------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (component == 0) ? 12 : 31
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // If it's in the month view...
        if component == 0 {
            return (mode == "GetDec31") ? monthNames[row] : monthNames[12-row-1]
        }
            
            // if it's in the day view...
        else {
            if mode == "GetDec31" {
                return String(row + 1)
            }
            else {
                return String(31 - row)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            intMonth = convertRowToValue(row, typeOfValue: "month")
            month = monthNames[intMonth-1]
            
            day = convertRowToValue(row, typeOfValue: "day")
            self.pickerView(pickerView, didSelectRow: 31 - day, inComponent: 1)
            
            if (debugging) {print("Changed row in MONTH component:\n   Month was set to \(month)\n   Day was set to \(day)")}
        }
        else if component == 1 {
            let maxDay = maxDates[monthToInt[month]! - 1]
            day = convertRowToValue(pickerView.selectedRow(inComponent: 1), typeOfValue: "day")
            
            if (day > maxDay) {
                if (mode == "GetDec31"){
                    pickerView.selectRow(maxDay-1, inComponent: 1, animated: true)
                }
                else {
                    pickerView.selectRow(31 - maxDay, inComponent: 1, animated: true)
                }
                
                day = maxDay
            }
            
            if (debugging) {print("day was set to \(day)")}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == "January 1" {
            mode = "GetJan1"
        }
        else if mode == "December 31" {
            mode = "GetDec31"
        }
        
        startGame()
    }
    
    func startGame() {
        if !undoControls[0] {
            undoButton.backgroundColor = UIColor.lightGray
        }
        else {
            undoButton.backgroundColor = UIColor(red:0.09, green:0.40, blue:1.00, alpha:1.0)
            undoControls[1] = true
        }
        
        if !showAnswerControls {
            showAnswerButton.backgroundColor = UIColor.lightGray
        }
        else {
            showAnswerButton.backgroundColor = UIColor.red
        }
        
        if (mode == "GetDec31") {
            self.title = "GetDec31"
            
            currentMonth = 1
            currentDay = 1
            
            undoMonth = 1
            undoDay = 1
            
            month = "January"
            intMonth = 1
            day = 1
            
            monthLogoImageView.image = UIImage(named: self.month)
            
            start31()
        }
        else if (mode == "GetJan1") {
            self.title = "GetJan1"
            
            currentMonth = 12
            currentDay = 31
            
            undoMonth = 12
            undoDay = 31
            
            month = "December"
            intMonth = 12
            day = 31
            
            monthLogoImageView.image = UIImage(named: self.month)
            
            start1()
        }
    }
    
    func handleThinking(pausing: Bool) {
        if pausing {
            UIApplication.shared.beginIgnoringInteractionEvents()
            label.isHidden = true
            activityIndicator.startAnimating()
        }
        else {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.label.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func onButtonTapped(_ sender: AnyObject) {
        if (self.mode == "GetDec31") {
            self.getDec31()
        }
        else {
            if (debugging) {print("\(self.month) \(self.day)")}
            self.getJan1()
        }
    }
    
    @IBAction func undoButtonTapped(_ sender: Any) {
        if (!undoControls[0]) {
            customError("The undo button is currently locked. Please visit the Unlock Features page to unlock it.")
        }
        else if !undoControls[1] {
            customError("You can only use the undo button once per game.")
        }
        else if (currentMonth == 1 && currentDay == 1) || (currentMonth == 12 && currentDay == 31) || label.text?.range(of: "I will start with") != nil {
            customError("You have not made any moves yet.")
        }
        else {
            label.text = "My last move was \(translateMonth(undoMonth)) \(undoDay)."
            
            currentMonth = undoMonth
            currentDay = undoDay
            
            // Select the date's rows in the view
            let monthRow = convertValueToRow(undoMonth, typeOfValue: "month")
            let dayRow = convertValueToRow(undoDay, typeOfValue: "day")
            
            picker.selectRow(monthRow, inComponent: 0, animated: true)
            picker.selectRow(dayRow, inComponent: 1, animated: true)
            
            self.pickerView(picker, didSelectRow: monthRow, inComponent: 0)
            self.pickerView(picker, didSelectRow: dayRow, inComponent: 1)
            
            monthLogoImageView.image = UIImage(named: self.month)
            
            undoControls[1] = false
            undoButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func showAnswerButtonTapped(_ sender: Any) {
        if !showAnswerControls {
            customError("The show answer button is currently locked. Please visit the Unlock Features page to unlock it.")
        }
        else {
            performSegue(withIdentifier: "showAnswer", sender: self)
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
