//
//  RestaurantTableViewCell.swift
//  O'Resto
//
//  Created by Allan Contaret on 12/12/2016.
//  Copyright © 2016 Allan Contaret. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

   

    
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    var restaurant: Restaurant! {
        didSet{
            self.updateUI()
        }
    }
    func updateUI(){
        restaurantImageView.image = UIImage(named: restaurant.imageName)
        restaurantNameLabel.text = restaurant.name
        
        
    }
}
