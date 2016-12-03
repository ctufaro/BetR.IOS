//
//  GameSelectViewController.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 10/8/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    
    var title1 = String()
    var title2 = String()
    var moneyHome = String()
    var spreadHome = String()
    var moneyVisit = String()
    var spreadVisit = String()
    var overUnder = String()
    var overUnder2 = String()
    
    let checkedImage = UIImage(named: "checkbox-sel")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox")! as UIImage
    
    @IBOutlet weak var txtMoneyHome: UITextField!
    
    @IBOutlet weak var txtSpreadHome: UITextField!
    
    @IBOutlet weak var txtMoneyVisit: UITextField!
    
    @IBOutlet weak var txtSpreadVisit: UITextField!
    
    @IBOutlet weak var txtOverUnder: UITextField!
    
    @IBOutlet weak var txtOverUnder2: UITextField!

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.text = title1
        lblTitle2.text = title2
        txtMoneyHome.text = moneyHome
        txtSpreadHome.text = spreadHome
        txtMoneyVisit.text = moneyVisit
        txtSpreadVisit.text = spreadVisit
        txtOverUnder.text = overUnder
        txtOverUnder2.text = overUnder
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
