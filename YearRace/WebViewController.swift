//
//  WebViewController.swift
//  YearRace
//
//  Created by David Ruvinskiy on 6/4/16.
//  Copyright © 2016 David Ruvinskiy. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "webToDirections", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://www.seeker.com/2-ways-to-scam-your-friends-with-no-objects-at-all-1791396677.html")
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
