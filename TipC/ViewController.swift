//
//  ViewController.swift
//  TipC
//
//  Created by Lex Lacson on 4/12/15.
//  Copyright (c) 2015 Lex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var bar: UIView!

    let TEN_MINUTES = 600.0; //seconds

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        let defaults = NSUserDefaults.standardUserDefaults()
        let billAmountTime = (NSDate().timeIntervalSince1970 as Double) - defaults.doubleForKey("bill_amount_time")
        let billAmount = defaults.objectForKey("bill_amount") as? String

        if (billAmountTime < TEN_MINUTES) {
            billField.text = billAmount
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = billField.text._bridgeToObjectiveC().doubleValue
        let tip = billAmount * tipPercentage
        let totalAmount = billAmount + tip
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(totalAmount)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTip = defaults.integerForKey("default_tip")
        tipControl.selectedSegmentIndex = defaultTip
        tipControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        billField.becomeFirstResponder()
        
        
        UIView.animateWithDuration(1, animations: {
            // This causes first view to fade in and second view to fade out
            self.bar.frame.size.width = 288
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        let billAmount = billField.text
        defaults.setObject(billAmount, forKey: "bill_amount")
        defaults.setDouble(NSDate().timeIntervalSince1970 as Double, forKey: "bill_amount_time")
        defaults.synchronize()
        
        self.bar.frame.size.width = 0
    }
}

