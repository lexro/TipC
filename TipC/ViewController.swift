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
  @IBOutlet weak var resultsView: UIView!
  
  private let cacheTime = 600.0; //seconds
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    tipLabel.text = "$0.00"
    totalLabel.text = "$0.00"
    billField.text = ""
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let billAmountTime = (NSDate().timeIntervalSince1970 as Double) - defaults.doubleForKey("bill_amount_time")
    let billAmount = defaults.objectForKey("bill_amount") as? String
    
    if (billAmountTime < cacheTime) {
      billField.text = billAmount
    }
    
    let billAmountNumber = billField.text._bridgeToObjectiveC().doubleValue
    
    if (billAmountNumber != 0) {
      showResultsView()
    } else {
      showBillView()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func updateView() {
    let tipPercentages = [0.18, 0.2, 0.22]
    let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
    
    let billAmount = billField.text._bridgeToObjectiveC().doubleValue
    let tip = billAmount * tipPercentage
    let totalAmount = billAmount + tip
    
    //format amounts by default user locale
    var numFormat = NSNumberFormatter();
    numFormat.numberStyle = .CurrencyStyle
    tipLabel.text = numFormat.stringFromNumber(tip)
    totalLabel.text = numFormat.stringFromNumber(totalAmount)
  }
  
  @IBAction func onBillFieldChanged(sender: AnyObject) {
    let billAmount = billField.text._bridgeToObjectiveC().doubleValue
    if (billAmount != 0) {
      showResultsAnimation()
    } else {
      showBillAnimation()
    }
    updateView()
  }
  
  @IBAction func onTipChanged(sender: AnyObject) {
    updateView()
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
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    var defaults = NSUserDefaults.standardUserDefaults()
    let billAmount = billField.text
    defaults.setObject(billAmount, forKey: "bill_amount")
    defaults.setDouble(NSDate().timeIntervalSince1970 as Double, forKey: "bill_amount_time")
    defaults.synchronize()
  }
  
  private func showBillView() {
    billField.frame.origin.y = 200
    tipControl.alpha = 0
    tipControl.frame.origin.y = 700
    resultsView.alpha = 0
    resultsView.frame.origin.y = 700
  }
  
  private func showResultsView() {
    billField.frame.origin.y = 100
    tipControl.alpha = 1
    tipControl.frame.origin.y = 170
    resultsView.alpha = 1
    resultsView.frame.origin.y = 220
  }
  
  private func showResultsAnimation() {
    UIView.animateWithDuration(0.3) {
      self.showResultsView()
    }
  }
  
  private func showBillAnimation() {
    UIView.animateWithDuration(0.3) {
      self.showBillView()
    }
  }
}

