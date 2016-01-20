//
//  SettingsViewController.swift
//  Life Counter 3
//
//  Created by mitchell hudson on 12/21/14.
//  Copyright (c) 2014 mitchell hudson. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func setStartCount(n: Int)
}

class SettingsViewController: UIViewController {
    
    var counter = 20
    var panDistance = 0.0
    var panDelta = 0
    
    var delegate: SettingsViewControllerProtocol!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // self.view.backgroundColor = UIColor.darkGrayColor()
        setupGestures()
        updateDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "onPan:")
        self.view.addGestureRecognizer(panGesture)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        panGesture.requireGestureRecognizerToFail(swipeRight)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // let touch = touches.anyObject() as! UITouch
        let touch = touches.first
        _ = touch!.locationInView(self.view)
        panDelta = counter
    }
    
    
    func onPan(gesture: UIPanGestureRecognizer) {
        // get the Gesture cast as pan gesture
        let pan = gesture
        // Find the distance moved on the y
        let point = pan.translationInView(self.view)
        let newCount = panDelta - Int((point.y * 0.1))
        counter = newCount
        updateDisplay()
    }
    
    func onSwipe(gestuer: UISwipeGestureRecognizer) {
        if delegate != nil {
            delegate.setStartCount(counter)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func updateDisplay() {
        counterLabel.text = "\(counter)"
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
