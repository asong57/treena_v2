//
//  CalendarCoordinator.swift
//  treena_v2
//
//  Created by asong on 2022/02/16.
//

import Foundation
import UIKit

protocol CalendarCoordinatorDelegate {
    func detailCalendar(_ coordinator: CalendarCoordinator)
}

class CalendarCoordinator: Coordinator, CalendarVCDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: CalendarCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CalendarVC()
        viewController.view.backgroundColor = .green
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
    func detailCalendar() {
        self.delegate?.detailCalendar(self)
    }
}
