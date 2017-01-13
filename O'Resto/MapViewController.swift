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
        /*webViewMap.loadHTMLString("<html><body style='margin:0; padding:0;'><iframe style='width:100%; height:100%; border:none;' src='https://www.google.com/maps/embed/v1/place?q=\(q)&zoom=17&key=AIzaSyD4iE2xVSpkLLOXoyqT-RuPwURN3ddScAI'></iframe></body></html>", baseURL: nil)*/
        webViewMap.loadRequest(URLRequest(url: NSURL(string: "https://www.google.com/maps/place/\(q)") as! URL))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
