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
    
    static var sharedGames : [GameTrakSelections] = []
    
    var red = 115
    var green = 224
    var blue = 179
    
    
    @IBAction func btnHomeMoneyClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "HomeMoney")
    }
    
    @IBAction func btnHomeSpreadClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "HomeSpread")
    }
    
    
    @IBAction func btnHomeTotalClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "HomeTotal")
    }
    
    
    @IBAction func btnVisitMoneyClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "VisitMoney")
    }

    @IBAction func btnVisitSpreadClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "VisitSpread")
    }
    
    @IBAction func btnVisitTotalClick(_ sender: AnyObject) {
        let row = sender.tag;
        WireButton(sender as! UIButton, row: row!, field: "VisitTotal")
    }
    
    
    func WireButton(_ button:UIButton, row:Int, field:String){
        
        let selectedGameLine:GameTrak = HomeController.sharedGames[row]
        
        let HomeTeam : String = selectedGameLine.TeamHome
        let AwayTeam : String = selectedGameLine.TeamVisiting
        let GameDate : String = selectedGameLine.EventDate
        let Versus : String = HomeTeam + " vs " + AwayTeam
        
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
            AddRemoveGames(toggle: toggle, team: HomeTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.MoneyLineHome)
            HomeController.buttonStates[row]!.buttonHomeMoney = toggle
        case "HomeSpread":
            AddRemoveGames(toggle: toggle, team: HomeTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.SpreadHome)
            HomeController.buttonStates[row]!.buttonHomeSpread = toggle
        case "HomeTotal":
            AddRemoveGames(toggle: toggle, team: HomeTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.OverAdjust)
            HomeController.buttonStates[row]!.buttonHomeOU = toggle
        case "VisitMoney":
            AddRemoveGames(toggle: toggle, team: AwayTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.MoneyLineVisiting)
            HomeController.buttonStates[row]!.buttonVisitMoney = toggle
        case "VisitSpread":
            AddRemoveGames(toggle: toggle, team: AwayTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.SpreadVisiting)
            HomeController.buttonStates[row]!.buttonVisitSpread = toggle
        case "VisitTotal":
            AddRemoveGames(toggle: toggle, team: AwayTeam, versus: Versus, gameDate: GameDate, data: selectedGameLine.OverAdjust)
            HomeController.buttonStates[row]!.buttonVisitOU = toggle
        default:
            toggle = true
        }
        
    }
    
    func AddRemoveGames(toggle: Bool, team: String, versus:String, gameDate:String, data:String){
        let selItem : GameTrakSelections = GameTrakSelections(Team:team,Versus:versus,GameDate:gameDate,Data:data, Amount:nil, Juice:nil, ToWin:nil)
        let selInd = GameTrakTableViewCell.sharedGames.index(where: {$0.Equalz(Team: team, Versus: versus, GameDate: gameDate, Data: data)})

        if toggle{
            GameTrakTableViewCell.sharedGames.append(selItem)
        }
        else{
            GameTrakTableViewCell.sharedGames.remove(at: selInd!)
        }
        
        print("-----------------")
        for item in GameTrakTableViewCell.sharedGames {
            print(item.Team + " : " + item.Versus + " : " + item.GameDate + " : " + item.Data)
        }
        print("-----------------")
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
