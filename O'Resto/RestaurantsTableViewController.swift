//
//  RestaurantsTableViewController.swift
//  O'Resto
//
//  Created by Grégoire Joncour on 10/01/2017.
//  Copyright © 2017 Allan Contaret. All rights reserved.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {
    
    @IBOutlet weak var tableViewResto: UITableView!
    @IBOutlet weak var refreshRestaurantsButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    
    var restaurantsArray = [Restaurant]()
    var dateFormatter = DateFormatter()
    let refresher = UIRefreshControl()
    
    let urlRestaurants = "http://api.gregoirejoncour.xyz/restaurant"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.addTarget(self, action: #selector(RestaurantsTableViewController.handleRefresh), for: .valueChanged)

        self.dateFormatter.timeStyle = DateFormatter.Style.medium
        refreshControl = refresher
        tableViewResto!.addSubview(refreshControl!)
        
        downloadJsonWithUrl(url: urlRestaurants)
        dateLabel.text = "mis à jour : " + self.dateFormatter.string(from: NSDate() as Date)
        tableViewResto.dataSource = self
        tableViewResto.estimatedRowHeight = 376
        tableViewResto.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {

        
        let now = NSDate()
        let updateString = "mis à jour : " + self.dateFormatter.string(from: now as Date)
        print(updateString)
        dateLabel.text = updateString
        restaurantsArray.removeAll()
        downloadJsonWithUrl(url: urlRestaurants)
        
        refreshControl.endRefreshing()
    }
    
    // fonction recupération json de l'api REST maison de restaurants
    func downloadJsonWithUrl(url: String){
        
        let urlString = url /*"http://api.gregoirejoncour.xyz/restaurant"*/
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
                                        return "\(address!), \(postalCode!) \(city!)"
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
                            
                            let descriptionStr: String = {
                                if let description = restaurantDict.value(forKey: "description") {
                                    return description as! String
                                }
                                return "no"
                            }()
                            
                            self.restaurantsArray.append(Restaurant(name: nameStr, address: addressStr, imageName: imageStr, id: idInt, description: descriptionStr))
                            
                            OperationQueue.main.addOperation ({
                                self.tableViewResto.reloadData()
                            })
                        }
                    }
                }
                self.restaurantsArray.sort() { $0.name < $1.name }
            }
        }).resume()
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell") as! RestaurantTableViewCell

        cell.restaurant = restaurantsArray[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueInfos") {
            if let indexPath = self.tableViewResto.indexPathForSelectedRow {
                let svc = segue.destination as! RestaurantViewController;
                svc.restaurant = restaurantsArray[indexPath.row]
            }
        }
    }

}
