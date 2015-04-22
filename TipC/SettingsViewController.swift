//
//  SettingsViewController.swift
//  TipC
//
//  Created by Lex Lacson on 4/12/15.
//  Copyright (c) 2015 Lex. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var tipControl: UISegmentedControl!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let defaults = NSUserDefaults.standardUserDefaults()
    let defaultTip = defaults.integerForKey("default_tip")
    tipControl.selectedSegmentIndex = defaultTip
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onTipChange(sender: AnyObject) {
    var defaults = NSUserDefaults.standardUserDefaults()
    let defaultTip = tipControl.selectedSegmentIndex
    defaults.setInteger(defaultTip, forKey: "default_tip")
    defaults.synchronize()
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
