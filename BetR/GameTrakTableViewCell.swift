//
//  GameTrakTableViewCell.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 10/2/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit
import QuartzCore

class GameTrakTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var btnHomeMoney: UIButton!
    @IBOutlet weak var btnHomeSpread: UIButton!
    @IBOutlet weak var btnHomeTotal: UIButton!
    @IBOutlet weak var btnVisitMoney: UIButton!
    @IBOutlet weak var btnVisitSpread: UIButton!
    @IBOutlet weak var btnVisitTotal: UIButton!
    
    var red = 115
    var green = 224
    var blue = 179
    
    
    @IBAction func btnHomeMoneyClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "HomeMoney")
    }
    
    @IBAction func btnHomeSpreadClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "HomeSpread")
    }
    
    
    @IBAction func btnHomeTotalClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "HomeTotal")
    }
    
    
    @IBAction func btnVisitMoneyClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "VisitMoney")
    }

    @IBAction func btnVisitSpreadClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "VisitSpread")
    }
    
    @IBAction func btnVisitTotalClick(sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row, field: "VisitTotal")
    }
    
    
    func WireButton(button:UIButton, row:Int, field:String){
        
        //REFACTOR THIS
        
        var toggle:Bool = false
        
        if button.backgroundColor == UIColor(red: red, green: green, blue: blue){
            
            toggle = false
            button.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            
        }
        else{
            toggle = true
            button.backgroundColor = UIColor(red: red, green: green, blue: blue)
        }
        
        switch field {
        case "HomeMoney":
            HomeController.buttonStates[row]!.buttonHomeMoney = toggle
        case "HomeSpread":
            HomeController.buttonStates[row]!.buttonHomeSpread = toggle
        case "HomeTotal":
            HomeController.buttonStates[row]!.buttonHomeOU = toggle
        case "VisitMoney":
            HomeController.buttonStates[row]!.buttonVisitMoney = toggle
        case "VisitSpread":
            HomeController.buttonStates[row]!.buttonVisitSpread = toggle
        case "VisitTotal":
            HomeController.buttonStates[row]!.buttonVisitOU = toggle
        default:
            toggle = true
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnHomeMoney.layer.cornerRadius = 5;
        btnHomeSpread.layer.cornerRadius = 5;
        btnHomeTotal.layer.cornerRadius = 5;
        btnVisitMoney.layer.cornerRadius = 5;
        btnVisitSpread.layer.cornerRadius = 5;
        btnVisitTotal.layer.cornerRadius = 5;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
