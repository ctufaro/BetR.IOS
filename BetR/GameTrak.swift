//
//  GameTrak.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 10/3/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class GameTrak: NSObject {
    var TeamHome: String
    var TeamVisiting: String
    var EventDate: String
    var SpreadHome: String
    var SpreadVisiting: String
    var TotalPoints: String
    var OverAdjust: String
    var UnderAdjust: String
    var MoneyLineHome: String
    var MoneyLineVisiting: String
    
    init (TeamHome: String, TeamVisiting: String, EventDate:String, SpreadHome:String, SpreadVisiting:String, TotalPoints:String, OverAdjust:String, UnderAdjust:String, MoneyLineHome:String, MoneyLineVisiting:String) {
        self.TeamHome = TeamHome
        self.TeamVisiting = TeamVisiting
        self.EventDate = EventDate
        self.SpreadHome = SpreadHome
        self.SpreadVisiting = SpreadVisiting
        self.TotalPoints = TotalPoints
        self.OverAdjust = OverAdjust
        self.UnderAdjust = UnderAdjust
        self.MoneyLineHome = MoneyLineHome
        self.MoneyLineVisiting = MoneyLineVisiting
    }
    
    override init(){
        self.TeamHome = ""
        self.TeamVisiting = ""
        self.EventDate = ""
        self.SpreadHome = ""
        self.SpreadVisiting = ""
        self.TotalPoints = ""
        self.OverAdjust = ""
        self.UnderAdjust = ""
        self.MoneyLineHome = ""
        self.MoneyLineVisiting = ""
    }
}

struct GameTrakButtonStates {
    var buttonHomeMoney : Bool
    var buttonHomeSpread : Bool
    var buttonHomeOU : Bool
    var buttonVisitMoney : Bool
    var buttonVisitSpread : Bool
    var buttonVisitOU : Bool
    
    init() {
        self.buttonHomeMoney = false
        self.buttonHomeSpread = false
        self.buttonHomeOU = false
        self.buttonVisitMoney = false
        self.buttonVisitSpread = false
        self.buttonVisitOU = false
    }
    
}

class GameTrakSelections{
    var Team : String
    var Versus : String
    var GameDate : String
    var Data : String
    var Amount : Float?
    var Juice : Float?
    var ToWin : Float?
    var ORow : Int?
    var Button : UIButton
    
    init(Team: String, Versus: String, GameDate:String, Data:String, Amount:Float?, Juice:Float?, ToWin:Float?, ORow:Int?, Button:UIButton){
        self.Team = Team
        self.Versus = Versus
        self.GameDate = GameDate
        self.Data = Data
        self.Amount = Amount
        self.Juice = Juice
        self.ToWin = ToWin
        self.ORow = ORow
        self.Button = Button
    }
    
    func Equalz(Team: String, Versus: String, GameDate: String, Data: String) -> Bool {
        return self.Team == Team && self.Versus == Versus && self.GameDate == GameDate && self.Data == Data
    }
    
}
