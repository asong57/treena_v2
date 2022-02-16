//
//  AppCoordinator.swift
//  treena_v2
//
//  Created by asong on 2022/02/16.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator, HomeCoordinatorDelegate, CalendarCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
    
    func start() {
        //
        self.showHomeViewController()
    }
    
    private func showHomeViewController() {
        let coordinator = HomeCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    private func showCalendarViewController() {
        let coordinator = CalendarCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func didTouchedCalendar(_ coordinator: HomeCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showCalendarViewController()
    }
    
    func detailCalendar(_ coordinator: CalendarCoordinator) {
        
    }
}
