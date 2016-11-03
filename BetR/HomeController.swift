//
//  ViewController.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 9/30/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate{

    
    var red = 115
    var green = 224
    var blue = 179
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    var items : [GameTrak] = []
    static var buttonStates = Dictionary<Int, GameTrakButtonStates>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.startAnimating()
        GetGameData()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let indexPath = self.tblView.indexPathForSelectedRow {
            self.tblView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func GetGameData(){
        var teamHome = ""
        var teamVisiting = ""
        var newEventDate = ""
        var spreadHome = ""
        var spreadVisiting = ""
        var totalPoints = ""
        var overAdjust = ""
        var underAdjust = ""
        var moneyLineHome = ""
        var moneyLineVisiting = ""
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string:"http://betrest.azurewebsites.net/api/games")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url){ (data,response,error) -> Void in
            
            if let urlContent = data{
                
                do{
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    if let events = jsonResult["events"] as? [[String: AnyObject]] {
                        for event in events {
                            
                            if let eventDate = event["event_datetimeGMT"] as? String {
                                print(eventDate)
                                newEventDate = eventDate
                            }
                            
                            //participants
                            if let participants = event["participants"] as? [[String: AnyObject]] {
                                for participant in participants {
                                    if let name = participant["participant_name"] as? String {
                                        if let homevist = participant["visiting_home_draw"] as? String{
                                            if homevist == "Home"{
                                                print ("Home:" + name)
                                                teamHome = name
                                            }
                                            else{
                                                print ("Visitor:" + name)
                                                teamVisiting = name
                                            }
                                        }
                                    }
                                }
                            }
                            
                            //periods
                            if let periods = event["periods"] as? [[String: AnyObject]] {
                                for period in periods {
                                    if let period_number = period["period_number"] as? String {
                                        if period_number == "0"{
                                            //spreads
                                            if let s = period["spread"]{
                                                if let spread_home = s["spread_home"] as? String{
                                                    print("spread home:" + String(spread_home))
                                                    spreadHome = String(spread_home)
                                                }
                                                if let spread_visiting = s["spread_visiting"] as? String{
                                                    print("spread visit:" + String(spread_visiting))
                                                    spreadVisiting = String(spread_visiting)
                                                }
                                            }
                                            //totals
                                            if let t = period["total"]{
                                                if let total_points = t["total_points"] as? String{
                                                    print("total points:" + String(total_points))
                                                    totalPoints = String(total_points)
                                                }
                                                if let over_adjust = t["over_adjust"] as? String{
                                                    print("over:" + String(over_adjust))
                                                    overAdjust = String(over_adjust)
                                                }
                                                if let under_adjust = t["under_adjust"] as? String{
                                                    print("under:" + String(under_adjust))
                                                    underAdjust = String(under_adjust)
                                                }
                                            }
                                            //moneyline
                                            if let m = period["moneyline"]{
                                                if let moneyline_home = m["moneyline_home"] as? String{
                                                    print("money home" + String(moneyline_home))
                                                    moneyLineHome = String(moneyline_home)
                                                }
                                                if let moneyline_visiting = m["moneyline_visiting"] as? String{
                                                    print("money vist" + String(moneyline_visiting))
                                                    moneyLineVisiting = String(moneyline_visiting)
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            self.items.append(GameTrak(TeamHome: teamHome, TeamVisiting: teamVisiting, EventDate: newEventDate, SpreadHome:spreadHome, SpreadVisiting:spreadVisiting, TotalPoints:totalPoints, OverAdjust:overAdjust, UnderAdjust:underAdjust, MoneyLineHome:moneyLineHome, MoneyLineVisiting:moneyLineVisiting))
                            print("----")
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tblView.reloadData()
                        self.actIndicator.stopAnimating()
                        self.actIndicator.hidesWhenStopped = true
                    })
                    
                } catch{
                    print("JSON Failed")
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if  segue.identifier == "ShowGameSegue", let destination = segue.destinationViewController as? GameSelectViewController,
            blogIndex = tblView.indexPathForSelectedRow?.row {
            destination.title1 = items[blogIndex].TeamHome
            destination.title2 = items[blogIndex].TeamVisiting
            destination.moneyHome = items[blogIndex].MoneyLineHome
            destination.spreadHome = items[blogIndex].SpreadHome
            destination.moneyVisit = items[blogIndex].MoneyLineVisiting
            destination.spreadVisit = items[blogIndex].SpreadVisiting
            destination.overUnder = items[blogIndex].OverAdjust
        }
        */
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GameTrakTableViewCell") as! GameTrakTableViewCell
        
        cell.btnHomeMoney.tag = indexPath.row
        cell.btnHomeSpread.tag = indexPath.row
        cell.btnHomeTotal.tag = indexPath.row
        cell.btnVisitMoney.tag = indexPath.row
        cell.btnVisitSpread.tag = indexPath.row
        cell.btnVisitTotal.tag = indexPath.row
        
        //insert entries into buttonstate dictionary
        let keyExists = HomeController.buttonStates[indexPath.row] != nil
        
        //REFACTOR THIS
        cell.btnHomeMoney.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        cell.btnHomeSpread.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        cell.btnHomeTotal.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        cell.btnVisitMoney.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        cell.btnVisitSpread.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        cell.btnVisitTotal.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
        
        if !keyExists{
            //just add it
            HomeController.buttonStates[indexPath.row] = GameTrakButtonStates()
        }
        else{
            CheckButtonStates(indexPath.row, cell: cell)
        }

        cell.lblFirst?.text = items[indexPath.row].TeamHome
        cell.lblSecond?.text = items[indexPath.row].TeamVisiting
        cell.lblDate?.text = items[indexPath.row].EventDate
        cell.btnHomeMoney?.setTitle(items[indexPath.row].MoneyLineHome, forState: UIControlState.Normal)
        cell.btnHomeSpread?.setTitle(items[indexPath.row].SpreadHome, forState: UIControlState.Normal)
        cell.btnHomeTotal?.setTitle("O " + items[indexPath.row].TotalPoints, forState: UIControlState.Normal)
        cell.btnVisitMoney?.setTitle(items[indexPath.row].MoneyLineVisiting, forState: UIControlState.Normal)
        cell.btnVisitSpread?.setTitle(items[indexPath.row].SpreadVisiting, forState: UIControlState.Normal)
        cell.btnVisitTotal?.setTitle("U " + items[indexPath.row].TotalPoints, forState: UIControlState.Normal)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print(items[row])
    }
    
    func CheckButtonStates(row:Int, cell:GameTrakTableViewCell){
        //REFACTOR THIS
        let buttonHomeMoneyState = HomeController.buttonStates[row]?.buttonHomeMoney
        if (buttonHomeMoneyState != nil){
            if buttonHomeMoneyState == true{
                cell.btnHomeMoney.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnHomeMoney.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
        
        let buttonHomeSpreadState = HomeController.buttonStates[row]?.buttonHomeSpread
        if (buttonHomeSpreadState != nil){
            if buttonHomeSpreadState == true{
                cell.btnHomeSpread.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnHomeSpread.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
        
        let buttonHomeTotalState = HomeController.buttonStates[row]?.buttonHomeOU
        if (buttonHomeTotalState != nil){
            if buttonHomeTotalState == true{
                cell.btnHomeTotal.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnHomeTotal.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
        
        let buttonVisitMoneyState = HomeController.buttonStates[row]?.buttonVisitMoney
        if (buttonVisitMoneyState != nil){
            if buttonVisitMoneyState == true{
                cell.btnVisitMoney.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnVisitMoney.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
        
        let buttonVisitSpreadState = HomeController.buttonStates[row]?.buttonVisitSpread
        if (buttonVisitSpreadState != nil){
            if buttonVisitSpreadState == true{
                cell.btnVisitSpread.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnVisitSpread.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
        
        let buttonVisitTotalState = HomeController.buttonStates[row]?.buttonVisitOU
        if (buttonVisitTotalState != nil){
            if buttonVisitTotalState == true{
                cell.btnVisitTotal.backgroundColor = UIColor(red: red, green: green, blue: blue)
            }
            else{
                cell.btnVisitTotal.backgroundColor = UIColor(red: 224, green: 224, blue: 224)
            }
        }
    }
    

    
    /*func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }*/
 
    


    
}