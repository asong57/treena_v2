//
//  HomeCoordinator.swift
//  treena_v2
//
//  Created by asong on 2022/02/16.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator, HomeVCDelegate {

    var childCoordinators: [Coordinator] = []
    var delegate: HomeCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeVC()
        viewController.view.backgroundColor = .white
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
    func calendar() {
        self.delegate?.didTouchedCalendar(self)
    }
}

protocol HomeCoordinatorDelegate {
    func didTouchedCalendar(_ coordinator: HomeCoordinator)
}
