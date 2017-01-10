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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNav.title = restaurant.name
        addressLabel.text = restaurant.address
        descriptionTextView.text = restaurant.description
        imageView.downloadedFrom(link: restaurant.imageName)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/

}
