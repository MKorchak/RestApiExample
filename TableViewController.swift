//
//  TableViewController.swift
//  RestApiExample
//
//  Created by Misha Korchak on 29.12.16.
//  Copyright © 2016 Misha Korchak. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let urlMenu = "http://admin.gjevass.com/cabaret/api/content/BESTia/menu"
    var menu = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDataToCell()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.posterImage?.image = menu[indexPath.row].poster
        cell.IDLabel?.text = "ID: \(menu[indexPath.row].id)"
        cell.numberLabel?.text = "number: \(menu[indexPath.row].number)"
        
        return cell
    }
    
    func addDataToCell() {
        let request = URLRequest(url: URL(string: urlMenu)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            //Parsing
            if let data = data {
                self.menu = self.parseJsonData(data)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.tableView.reloadData()
                })
            }
            
        })
        task.resume()
    }
    
    func parseJsonData(_ data: Data) -> [Menu] {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            
            print(jsonResult)

            print(jsonResult.value(forKey: "url"))
            print(jsonResult.value(forKey: "id"))
            
            for index in jsonResult {
                
                let page = Menu()
                let k = index as AnyObject
                var imageURL: String?
                imageURL = k.value(forKey: "url") as? String
                if let url = NSURL(string: imageURL!) {
                    if let data = NSData(contentsOf: url as URL) {
                        page.poster = UIImage(data: data as Data)
                    }
                }
                page.id = k.value(forKey: "id") as! Int
                page.number = k.value(forKey: "num") as! Int
                menu.append(page)
            }
            
        } catch {
            print(error)
        }
        
        return menu
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ViewController
                destinationController.myImage = menu[indexPath.row].poster
                destinationController.myTitle = "ID: \(menu[indexPath.row].id)"
            }
        }
    }
    

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

}
