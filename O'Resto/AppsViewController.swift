//
//  AppsViewController.swift
//  O'Resto
//
//  Created by Allan Contaret on 11/12/2016.
//  Copyright © 2016 Allan Contaret. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var apps = TIBRestaurants.getAllRestaurants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension


    }

}

extension AppsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell") as! RestaurantTableViewCell
        let app = apps[indexPath.row]
        
        cell.restaurant = app
        
        return cell
    }
}

