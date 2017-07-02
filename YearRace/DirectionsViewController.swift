//
//  DirectionsViewController.swift
//  YearRace
//
//  Created by David Ruvinskiy on 6/7/16.
//  Copyright © 2016 David Ruvinskiy. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DirectionsViewController.handleSwipes(_:)))
        
        downSwipe.direction = .down
        downSwipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(downSwipe)
    }
    
    func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        let alert: UIAlertController = UIAlertController(title: nil, message: "Welcome to the backdoor. Please enter the password.", preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            if let textField = alert.textFields?.first as UITextField? {
                if textField.text == "modern rogue" {
                    self.performSegue(withIdentifier: "backdoor", sender: self)
                }
                else {
                    self.handleSwipes(sender)
                }
            }
        }
        
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
