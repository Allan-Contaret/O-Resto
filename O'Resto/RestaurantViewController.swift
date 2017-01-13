//
//  RestaurantViewController.swift
//  O'Resto
//
//  Created by Developer on 09/01/2017.
//  Copyright © 2017 Allan Contaret. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    var restaurant:Restaurant!

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var restaurantNav: UINavigationItem!
    @IBOutlet weak var mapView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemMap: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNav.title = restaurant.name
        addressLabel.text = restaurant.address
        descriptionTextView.text = restaurant.description
        imageView.downloadedFrom(link: restaurant.imageName)
        let urladdress = restaurant.address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        mapView.downloadedFrom(link: "https://maps.googleapis.com/maps/api/staticmap?center=\(urladdress)&maptype=roadmap&markers=color:orange%7Clabel:R%7C\(urladdress)&zoom=16&scale=2&size=400x200&key=AIzaSyA4rAT0fdTZLNkJ5o0uaAwZ89vVPQpr_Kc")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueMap") {
            let svc = segue.destination as! MapViewController;
            svc.namePlace = "\(restaurant.name)+\(restaurant.address)"
        }
    }

}
