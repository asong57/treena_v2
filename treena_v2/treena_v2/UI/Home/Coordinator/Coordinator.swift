//
//  HomeCoordinator.swift
//  treena_v2
//
//  Created by asong on 2022/02/16.
//

import Foundation

protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start()
}
