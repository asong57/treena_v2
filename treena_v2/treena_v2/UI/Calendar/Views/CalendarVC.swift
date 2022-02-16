//
//  CalendarVC.swift
//  treena_v2
//
//  Created by asong on 2022/02/15.
//

import Foundation
import UIKit

class CalendarVC: UIViewController {
    var delegate: CalendarVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

protocol CalendarVCDelegate {
    func detailCalendar()
}