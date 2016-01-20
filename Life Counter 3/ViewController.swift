//
//  ViewController.swift
//  Life Counter 3
//
//  Created by mitchell hudson on 12/20/14.
//  Copyright (c) 2014 mitchell hudson. All rights reserved.
//

import UIKit
                                                                // **** UIALertviewDelegate deprecated in iOS 8
class ViewController: UIViewController, SettingsViewControllerProtocol, UIAlertViewDelegate {
    
    // MARK: - Variable Constants
    
    let insetPercent:CGFloat = 0.1
    let viewAColor = UIColor(red: 249/255, green: 252/255, blue: 249/255, alpha: 1.0) // UIColor(hue: 1.0, saturation: 0.5, brightness: 0.9, alpha: 1.0)
    let viewBColor = UIColor(red: 249/255, green: 252/255, blue: 249/255, alpha: 1.0) // UIColor(hue: 0.5, saturation: 0.5, brightness: 0.9, alpha: 1.0)
    let fontColor  = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    let labelInset: CGFloat = 20
    
    let transitionDuration  = 0.4
    let transitionUpStyle   = UIViewAnimationOptions.TransitionCurlUp
    let transitionDownStyle = UIViewAnimationOptions.TransitionCurlDown
    
    let transitionDirectionUp = "up"
    let transitionDirectionDown = "down"
    
    // MARK: - Variables 
    
    var count = 0
    var startingCount = 20
    
    let container = UIView()
    let viewA = UIView()
    let viewB = UIView()
    
    let labelA = UILabel()
    let labelB = UILabel()
    
    var rect: CGRect!
    
    let kSavedStartingCountKey = "startingCount"

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loadDefaults()
        
        resetCount()
        setupViews()
        setupGestures()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // addConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper functions
    
    
    func loadDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedStartingCount: AnyObject = defaults.objectForKey(kSavedStartingCountKey) {
            startingCount = Int(savedStartingCount as! NSNumber)
        }
    }
    
    
    func setStartCount(n: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(startingCount, forKey: kSavedStartingCountKey)
        defaults.synchronize()
        startingCount = n
    }
    
    
    func setupViews() {
    
        let margin = self.view.frame.width * insetPercent
        let size = self.view.frame.width - (margin * 2)
        
        rect = CGRectMake(0, 0, size, size)
        self.container.frame = rect
        self.container.frame.origin = CGPoint(x: margin, y: margin * 2)
        self.viewA.frame = rect
        self.viewB.frame = rect
        
        self.container.backgroundColor = UIColor.redColor()
        self.viewA.backgroundColor = viewAColor
        self.viewB.backgroundColor = viewBColor
        
        configureLabel(labelA, str: "\(startingCount)")
        configureLabel(labelB, str: "\(startingCount)")
        
        self.viewA.addSubview(labelA)
        self.viewB.addSubview(labelB)
        
        self.container.addSubview(viewA)
        self.view.addSubview(container)
        
    }
    
    func addConstraints() {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        let views: Dictionary = ["viewA":self.viewA, "viewB":self.viewB]
        let hca:[NSLayoutConstraint]! = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[viewA]-|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let vca:[NSLayoutConstraint]! = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[viewA]-|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        viewA.addConstraints(hca)
        viewA.addConstraints(vca)
    }
    
    func resetCount() {
        count = startingCount
        updateCounter(transitionDirectionUp)
    }
    
    func configureLabel(label: UILabel, str: String) {
        label.frame = rect.insetBy(dx: labelInset, dy: labelInset)
        label.font = UIFont.boldSystemFontOfSize(rect.width)
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        label.textColor = fontColor
        label.textAlignment = NSTextAlignment.Center
        label.text = str
    }
    
    // MARK: - Gestures
    
    func setupGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "onSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "onTap:")
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        
    }
    
    func onSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Up:
                    count++
                    updateCounter(transitionDirectionUp)
                
                case UISwipeGestureRecognizerDirection.Down:
                    count--
                    updateCounter(transitionDirectionDown)
                
                case UISwipeGestureRecognizerDirection.Left:
                    self.performSegueWithIdentifier("ShowSettingsSegue", sender: self)
                
                default:
                    break
            }
        }
    }
    
    func onTap(gesture: UITapGestureRecognizer) {
        // *** UIAlertController only available in iOS 8.0
        /*let alertController = UIAlertController(title: "Reset", message: "Reset counter?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.Default, handler: {(action) in
            self.resetCount()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil) */
        
        let alert = UIAlertView(title: "Reset", message: "Reset counter to \(startingCount)?", delegate: self, cancelButtonTitle: "Cancel")
        alert.addButtonWithTitle("Reset")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print("Alert: \(buttonIndex)")
        switch buttonIndex {
        case 0:
            print("Reset alert canceled")
        case 1:
            self.resetCount()
        default:
            break
        }
    }
    
    
    // MARK: - Counter Display
    
    func updateCounter(direction: String) {
        var views: (frontView: UIView, backView: UIView)
        if self.viewA.superview != nil {
            views = (frontView: self.viewA, backView: self.viewB)
            labelB.text = String(count)
        } else {
            views = (frontView: self.viewB, backView: self.viewA)
            labelA.text = String(count)
        }
        
        var options: UIViewAnimationOptions
        if direction == transitionDirectionUp {
            options = transitionUpStyle
        } else {
            options = transitionDownStyle
        }
        
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: transitionDuration, options: options, completion: nil)
    }
    
    
    // MARK: - Segue methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSettingsSegue" {
            print("VC prepare for segue set delegate")
            let vc = segue.destinationViewController as! SettingsViewController
            vc.delegate = self
            vc.counter = startingCount
        }
    }

}

