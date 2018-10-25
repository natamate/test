//
//  MasterViewController.swift
//  WeatherAdvanced
//
//  Created by Student on 25.10.2561 BE.
//  Copyright © 2561 BE agh. All rights reserved.
//

import UIKit

struct Record{
    var city = ""
    var temp = 0.0
    var image = UIImage()
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Record]()


    @IBOutlet weak var buttonAdd: UIBarButtonItem!
    
    let url = URL(string: "https://www.metaweather.com/api/")
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func initRecords() {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "ttps://www.metaweather.com/api/") {
            
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    DispatchQueue.main.async {
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        self.initRecordList(recordListArgs: json as! [[String : AnyObject]])
                        self.tableView.reloadData()
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    func initRecordList(recordListArgs:[[String: AnyObject]]){
        var argCity = String()
        var argTemp = Float()
        var argImage = UIImage()
        
        for recordListArg in recordListArgs {
            if let city = recordListArg[""] as? String {
                argCity=city
            } else {
                argCity=""
            }
            
            if let temperature = recordListArg[""] as? Float{
            //    argTemp=temperature
            } else {
                argTemp=0.0
            }
            
            if let image = recordListArg[""] as? UIImage{
                argImage=image
            } else {
                argImage=UIImage()
            }
      //      self.records.append(Record(city: argCity, temp: argTemp, image: argImage))
        }
        
   //     Record.saveRecordsToUserDefaults(records: records)
    }
    
    func applicationWillResignActive(_ notification: Notification){
   //     Record.saveRecordsToUserDefaults(records: records)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     /*   if let retreivedRecords = Record.loadRecordsFromUserDefaults() {
            print("loaded \(retreivedRecords.count) records from NSUserDefaults")
            if(retreivedRecords.count>0){
                records=retreivedRecords
            }else{
                self.initRecords()
            }
            
        } else {
            self.initRecords()
        }
        */
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        /*navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }*/
    }

    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnAddPressed(_ sender: Any) {
        self.objects.append(Record(city: "#NEW_RECORD", temp: 0.0, image: UIImage()))
        self.tableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //object.setCount(countArg: indexPath.row)
                //object.setMaxCount(maxCountArg: objects.count)
                //controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let record = objects[indexPath.row]
        //cell.textLabel!.text = record.city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }



}

