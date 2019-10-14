//
//  ViewController.swift
//  mactestnew2
//
//  Created by Felix 05 on 04/10/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet weak var textname1: UITextField!
    
    
    @IBOutlet weak var textname2: UITextField!
    
    @IBAction func insertitem(_ sender: UIButton) {
        
        let insertQuery = "insert into ManufactringTable(P_Name, P_Rate) values ('\(textname1.text!)','\(textname2.text!)')"
        let issuccess = databaselib.shareObj.executeQuery(query:insertQuery )
        if issuccess
        {
            print("insert success")
        }
        else
        {
            print("insert failed")
        }
    }
    
    
    
    @IBAction func next(_ sender: UIButton) {
        
        let next = storyboard?.instantiateViewController(withIdentifier: "nextViewController") as! nextViewController
        navigationController?.pushViewController(next, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

