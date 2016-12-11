//
//  GameSelectViewController.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 10/8/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource  {

    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var tabScrollView: ACTabScrollView!
    var contentViews: [UIView] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // set ACTabScrollView, all the following properties are optional
        tabScrollView.defaultPage = 1
        tabScrollView.arrowIndicator = true
        tabScrollView.delegate = self
        tabScrollView.dataSource = self
        
        // create content views from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        for category in BetCategory.allValues() {
            let vc = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            vc.category = category
            
            addChildViewController(vc) // don't forget, it's very important
            contentViews.append(vc.view)
        }
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        print(index)
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
        return BetCategory.allValues().count
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        label.text = String(describing: BetCategory.allValues()[index]).uppercased()
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        } else {
            label.font = UIFont.systemFont(ofSize: 16)
        }
        label.textColor = UIColor(red: 77.0 / 255, green: 79.0 / 255, blue: 84.0 / 255, alpha: 1)
        label.textAlignment = .center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 36) // add some paddings
        
        return label
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index]
    }
}
