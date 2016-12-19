//
//  ViewController.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 9/30/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate{

    //custom cyanish color
    var red = 115
    var green = 224
    var blue = 179
    
    //main table for gamelines
    @IBOutlet weak var tblView: UITableView!
    
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    
    //main array to store loaded gamelines
    var items : [GameTrak] = []
    
    static var sharedGames : [GameTrak] = []
    
    static var buttonStates = Dictionary<Int, GameTrakButtonStates>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.startAnimating()
        tblView.allowsSelection = false
        GetGameData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = self.tblView.indexPathForSelectedRow {
            self.tblView.deselectRow(at: indexPath, animated: true)
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
        let url = URL(string:"http://betrest.azurewebsites.net/api/games")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data,response,error) -> Void in
            
            if let urlContent = data{
                
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
                    //let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let events = jsonResult["SportsBookMain"] as? [[String: AnyObject]] {
                        for event in events {
                            
                            if let eDate = event["EventDate"] as? String {
                                newEventDate = eDate
                            }
                            
                            if let tHome = event["TeamHome"] as? String {
                                teamHome = tHome
                            }
                            
                            if let hSpread = event["SpreadHome"] as? String {
                                spreadHome = hSpread
                            }
                            
                            if let mHome = event["MoneyLineHome"] as? String {
                                moneyLineHome = mHome
                            }
                            
                            if let tVisting = event["TeamVisiting"] as? String {
                                teamVisiting = tVisting
                            }
                            
                            if let mlVisiting = event["MoneyLineVisiting"] as? String {
                                moneyLineVisiting = mlVisiting
                            }
                            
                            if let sVisiting = event["SpreadVisiting"] as? String {
                                spreadVisiting = sVisiting
                            }
                            
                            if let uAdjust = event["UnderAdjust"] as? String {
                                underAdjust = uAdjust
                            }
                            
                            if let oAdjust = event["OverAdjust"] as? String {
                                overAdjust = oAdjust
                            }
                            
                            if let tPoints = event["TotalPoints"] as? String {
                                totalPoints = tPoints
                            }
                        
                            
 
                            self.items.append(GameTrak(TeamHome: teamHome, TeamVisiting: teamVisiting, EventDate: newEventDate, SpreadHome:spreadHome, SpreadVisiting:spreadVisiting, TotalPoints:totalPoints, OverAdjust:overAdjust, UnderAdjust:underAdjust, MoneyLineHome:moneyLineHome, MoneyLineVisiting:moneyLineVisiting))
                            //print("----")
                        }
                    }
                    DispatchQueue.main.async(execute: {
                        self.tblView.reloadData()
                        self.actIndicator.stopAnimating()
                        self.actIndicator.hidesWhenStopped = true
                        HomeController.sharedGames = self.items
                    })
                    
                } catch{
                    print("JSON Failed")
                }
            }
        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTrakTableViewCell") as! GameTrakTableViewCell
        
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
        cell.btnHomeMoney?.setTitle(items[indexPath.row].MoneyLineHome, for: UIControlState())
        cell.btnHomeSpread?.setTitle(items[indexPath.row].SpreadHome, for: UIControlState())
        cell.btnHomeTotal?.setTitle("O " + items[indexPath.row].TotalPoints, for: UIControlState())
        cell.btnVisitMoney?.setTitle(items[indexPath.row].MoneyLineVisiting, for: UIControlState())
        cell.btnVisitSpread?.setTitle(items[indexPath.row].SpreadVisiting, for: UIControlState())
        cell.btnVisitTotal?.setTitle("U " + items[indexPath.row].TotalPoints, for: UIControlState())

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        print(items[row])
    }
    
    func CheckButtonStates(_ row:Int, cell:GameTrakTableViewCell){
        
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
