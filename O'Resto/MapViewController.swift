//
//  MapViewController.swift
//  O'Resto
//
//  Created by Developer on 12/01/2017.
//  Copyright © 2017 Allan Contaret. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    var namePlace:String!
    
    @IBOutlet weak var webViewMap: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let q = namePlace.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        webViewMap.loadRequest(URLRequest(url: NSURL(string: "https://www.google.com/maps/place/\(q)") as! URL))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
