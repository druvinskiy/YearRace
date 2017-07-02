//
//  ViewController.swift
//  YearRace
//
//  Created by David Ruvinskiy on 5/23/16.
//  Copyright © 2016 David Ruvinskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var mode = "GetJan1"
    var firstPlayer = "Me"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modeSegmentChanged(_ sender: UISegmentedControl) {
        let index:Int = sender.selectedSegmentIndex
        let title:String = sender.titleForSegment(at: index)!
        mode = title
    }
    
    @IBAction func firstPlayerSegmentChanged(_ sender: UISegmentedControl) {
        let index:Int = sender.selectedSegmentIndex
        let title:String = sender.titleForSegment(at: index)!
        firstPlayer = title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gameScreen") {
            let secondViewController:ViewController2 = segue.destination as! ViewController2
            
            secondViewController.mode = mode
            secondViewController.firstPlayer = firstPlayer
        }
    }
    
    @IBAction func unwindToMainMenu(_ sender: UIStoryboardSegue) {
    }
}
