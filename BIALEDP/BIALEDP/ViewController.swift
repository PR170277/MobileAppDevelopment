//
//  ViewController.swift
//  BIALEDP
//
//  Created by Prem Verma (INDIA - BAS) on 30/11/18.
//  Copyright © 2018 Prem Verma (INDIA - BAS). All rights reserved.
//

import UIKit
import Firebase
import FirebasePerformance
import Crashlytics
import FirebaseMessaging
import CloudKit

var xPOS = 0 as CGFloat
var yPOS = 0 as CGFloat
var width = 0 as CGFloat
var height = 40 as CGFloat
var heightSpace = 10 as CGFloat
var widthSpace = 30 as CGFloat



class ViewController: UIViewController {

    let publicDB = CKContainer.default().publicCloudDatabase
    let recordID = CKRecord.ID(recordName: "Student")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let trace = Performance.startTrace(name: "test trace")
        trace?.incrementMetric("retry", by: 1)
        trace?.stop()
        self.uiDesign()

    }

    
    func uiDesign() -> Void {
        xPOS = xPOS + self.view.frame.width*0.05
        yPOS = yPOS+self.view.frame.height*0.1
        width = self.view.frame.width-2*(self.view.frame.width*0.05)
        
        let crash = UIButton(type: .roundedRect)
        crash.frame = CGRect(x:xPOS, y:yPOS, width:width, height: height)
        crash.setTitle("Crash", for: [])
        crash.setTitleColor(UIColor.white, for: .normal)
        crash.backgroundColor = UIColor.red
        crash.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(crash)
        
        let cloud = UIButton(type: .roundedRect)
        cloud.frame = CGRect(x:xPOS, y:yPOS+height+heightSpace, width:width, height: height)
        cloud.setTitle("iCloud", for: [])
        cloud.setTitleColor(UIColor.white, for: .normal)
        cloud.backgroundColor = UIColor.red
        cloud.addTarget(self, action: #selector(self.cloudButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(cloud)
        
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        // FirebaseCrashMessage("Cause Crash button clicked")
        //fatalError()
        Crashlytics.sharedInstance().crash()
    }

    @IBAction func cloudButtonTapped(_ sender: AnyObject) {
        
        // Fetch Public Database
        publicDB.fetch(withRecordID: recordID) { fetchedStudent, error in
            let name = CKRecord(recordType: "StudentName", recordID: self.recordID)
            name["fname"] = "Prem" as String
            name["mname"] = "Nath" as String
            name["lname"] = "Verma" as String
            
            name["fname"] = "Vamsi" as String
            name["mname"] = "T" as String
            name["lname"] = "Krishna" as String
            
            name["fname"] = "Santosh" as String
            name["mname"] = "Kumar" as String
            name["lname"] = "Sharma" as String
            
            self.publicDB.save(name) { savedRecord, error in
                if error == nil {
                    // Perform actio
                    print("Success")
                
                } else {
                    // handle errors here
                    print(error.debugDescription)
                    
                }
            }
        }
    }
}
