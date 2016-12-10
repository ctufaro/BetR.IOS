//
//  MockData.swift
//  ACTabScrollView
//
//  Created by Azure Chen on 5/21/16.
//  Copyright © 2016 AzureChen. All rights reserved.
//

import UIKit

class MockData {

    static let betArray = [
        News(id: 1, category: .parlays, title: "This wager combines 2 to 15 picks into one bet, increasing your potential payout"),
        News(id: 2, category: .teasers, title: "This wager combines 2 to 15 picks where you can adjust the odds by a predetermined amount of points"),
        News(id: 3, category: .straight, title: "Please add selections to your Bet Ticket. "),
        /*News(id: 4, category: .sport, title: "What makes Bayern so special?"),
        News(id: 5, category: .entertainment, title: "Happy 30th anniversary 'Top Gun'!"),
        News(id: 6, category: .travel, title: "How to cook like Asia's best female chef"),
        News(id: 7, category: .travel, title: "Nine reasons to visit Georgia right now"),
        News(id: 8, category: .tech, title: "Look out for self-driving Ubers"),
        News(id: 9, category: .style, title: "This house being built into a cliff, thanks to internet"),
        News(id: 10, category: .specials, title: "Inside Africa"),
        News(id: 11, category: .sport, title: "Hayne named in Fiji's London squad"),
        News(id: 12, category: .travel, title: "Airport security: How can terrorist attacks be prevented?"),
        News(id: 13, category: .specials, title: "Silk Road"),*/
        ]
    
}

enum BetCategory {
    case parlays
    case teasers
    case straight
    case all

    
    static func allValues() -> [BetCategory] {
        return [.parlays, .straight, .teasers, .all]
    }
}

struct News {
    let id: Int
    let category: BetCategory
    let title: String
}

