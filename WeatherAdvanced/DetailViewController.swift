//
//  DetailViewController.swift
//  WeatherAdvanced
//
//  Created by Student on 25.10.2561 BE.
//  Copyright © 2561 BE agh. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var detailItem: UILabel!


    @IBOutlet weak var tfAuthor: UITextField!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    
    @IBOutlet weak var recordXzY: UINavigationItem!
    
    @IBOutlet weak var btnRemove: UIBarButtonItem!
    override func numberOfSections(in TableView: UITableView) -> Int{
        return 3
    }
    func configureView() {
        // Update the user interface for the detail item.
       // self.tfAuthor.text=detailItem!.author
       // self.tfTitle.text=detailItem!.title
       // self.tfYear.text=String(detailItem!.year)
       // self.recordXzY.title="Edit Record " + String(detailItem!.count+1) + " of "+String(detailItem!.maxCount)
    }
    @IBAction func tfAuthorEdited(_ sender: Any) {
       // detailItem!.author=tfAuthor.text!
    }
    
    @IBAction func tfTitleEdited(_ sender: Any) {
       // detailItem!.author=tfTitle.text!
    }
    @IBAction func tfYearEdited(_ sender: Any) {
       // let yearString : String = tfYear.text!
      //  if let yearInt = Int(yearString) {
       //     detailItem!.year=yearInt
       // }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnRemovePressed(_ sender: Any) {
        // detailItem!.records.remove(detailItem!.count)
        self.dismiss(animated: true, completion: nil)
    }
    
    //var detailItem:Record? {
    //    didSet {
            
     //   }
   // }


}

