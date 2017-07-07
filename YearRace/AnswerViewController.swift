//
//  AnswerViewController.swift
//  YearRace
//
//  Created by David Ruvinskiy on 6/4/16.
//  Copyright © 2016 David Ruvinskiy. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.seeker.com/2-ways-to-scam-your-friends-with-no-objects-at-all-1791396677.html")
        webView.loadRequest(URLRequest(url: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
