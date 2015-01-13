//
//  DismissSegue.swift
//  Life Counter 3
//
//  Created by mitchell hudson on 12/21/14.
//  Copyright (c) 2014 mitchell hudson. All rights reserved.
//

import UIKit

@objc(DismissSegue)
class DismissSegue: UIStoryboardSegue {
    override func perform() {
        sourceViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
