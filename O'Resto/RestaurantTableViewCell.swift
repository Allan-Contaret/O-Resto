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
        
        restaurantImageView.downloadedFrom(link: restaurant.imageName)
        
        restaurantNameLabel.text = restaurant.name
        print(restaurant.address)
        restaurantInfos.text = restaurant.address
        //restaurantImageView.image = UIImage(named: "vignette_hippo")
        
        
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
