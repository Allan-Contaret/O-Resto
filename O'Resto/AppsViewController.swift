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
    
    var restaurantsArray = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadJsonWithUrl()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueTest") {
            /*restaurantsArray.removeAll()
            self.downloadJsonWithUrl()*/
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let svc = segue.destination as! RestaurantViewController;
                svc.toPass = "\(restaurantsArray[indexPath.row].name)"
            }
        }
    }
    
    func downloadJsonWithUrl(){

        let urlString = "http://api.gregoirejoncour.xyz/restaurant"
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with:(url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let restaurants = parsedData!.value(forKey: "restaurants") as? NSArray {
                    for restaurant in restaurants {
                        if let restaurantDict = restaurant as? NSDictionary {
                            let nameStr: String = {
                                if let name = restaurantDict.value(forKey: "name") {
                                    return name as! String
                                }
                                return "no"
                            }()
                            
                            let addressStr: String = {
                                if let location = restaurantDict.value(forKey: "location") {
                                    if let locationDict = location as? NSDictionary {
                                        let address = locationDict.value(forKey: "address")
                                        let city = locationDict.value(forKey: "city")
                                        let postalCode = locationDict.value(forKey: "postal_code")
                                        return "\(address!) - \(city!) - \(postalCode!)"
                                    }
                                    return "no"
                                }
                                return "no"
                            }()
                            
                            let imageStr: String = {
                                if let image = restaurantDict.value(forKey: "image") {
                                    return "http://api.gregoirejoncour.xyz/images/\(image)"
                                }
                                return "no"
                            }()
                            
                            let idInt: Int = {
                                if let id = restaurantDict.value(forKey: "id") {
                                    let idd:Int = Int(id as! String)!
                                    return idd
                                }
                                return 0
                            }()
                            
                            self.restaurantsArray.append(Restaurant(name: nameStr, address: addressStr, imageName: imageStr, id: idInt))
                            
                            OperationQueue.main.addOperation ({
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }).resume()
    }


}

extension AppsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell") as! RestaurantTableViewCell
        
        cell.restaurant = restaurantsArray[indexPath.row]
        
        return cell
    }
}

