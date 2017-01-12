//
//  RestaurantsTableViewController.swift
//  O'Resto
//
//  Created by Developer on 10/01/2017.
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
        //self.dateFormatter.dateStyle = DateFormatter.Style.short
        self.dateFormatter.timeStyle = DateFormatter.Style.medium
        refreshControl = refresher
        tableViewResto!.addSubview(refreshControl!)
        //self.refreshControl?.addTarget(self, action: Selector(handleRefresh()), for: UIControlEvents.valueChanged)
        downloadJsonWithUrl(url: urlRestaurants)
        dateLabel.text = "mis à jour : " + self.dateFormatter.string(from: NSDate() as Date)
        tableViewResto.dataSource = self
        tableViewResto.estimatedRowHeight = 376
        tableViewResto.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        /*let newMovie = Restaurant(name :"Hippopotamus", address :"31 Rue Marie-Andrée Lagroua Weill-Hallé, 75013 Paris", imageName : "http://api.gregoirejoncour.xyz/images/Apricot.jpg", id : 10, description : "ddd")
        restaurantsArray.append(newMovie)*/
        let now = NSDate()
        let updateString = "mis à jour : " + self.dateFormatter.string(from: now as Date)
        print(updateString)
        dateLabel.text = updateString
        restaurantsArray.removeAll()
        downloadJsonWithUrl(url: urlRestaurants)
        
        refreshControl.endRefreshing()
    }
    
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

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/
    
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueTest") {
            if let indexPath = self.tableViewResto.indexPathForSelectedRow {
                let svc = segue.destination as! RestaurantViewController;
                svc.restaurant = restaurantsArray[indexPath.row]
            }
        }
    }

}
