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
    @IBOutlet weak var restaurantInfos: UITextView!
    
    var restaurant: Restaurant! {
        didSet{
            self.updateUI()
            
        }
    }
    func updateUI(){
        
        let catPictureURL = URL(string: "\(restaurant.imageName)")!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        self.restaurantImageView.image = UIImage(data: imageData)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        
        restaurantNameLabel.text = restaurant.name
        print(restaurant.address)
        restaurantInfos.text = restaurant.address
        //restaurantImageView.image = UIImage(named: "vignette_hippo")
        downloadPicTask.resume()
        
    }
}
