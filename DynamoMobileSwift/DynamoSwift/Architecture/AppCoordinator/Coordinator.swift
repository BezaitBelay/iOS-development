//
//  Coordinator.swift
//  Skeleton
//
//  Created by Martin Vasilev on 1.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation

protocol CoordinatableViewModel {
    
    /// Starts the viewModel logic
    func start()
}

extension CoordinatableViewModel {
    
    func start() {
        
    }
}

class Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    /// Start The Coordinator !!! SHOULD BE OVERRIDEN IN EACH SUBCLASS !!!
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    /// Finish The Coordinator !!! SHOULD BE OVERRIDEN IN EACH SUBCLASS !!!
    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    /// Adds a child coordinator to the current childCoordinators array
    ///
    /// - Parameter coordinator: the coordinator to add
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func addChildCoordinators(_ coordinators: [Coordinator]) {
        childCoordinators.append(contentsOf: coordinators)
    }
    
    /// Removes a child coordinator if such exists from the childCoordinators array
    ///
    /// - Parameter coordinator: the coordinator to remove
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
    
    /// Removes all child coordinators of a generic type if they exist from the childCoordinators array
    ///
    /// - Parameter type: the type by which the array is filtered
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    /// Removes all child coordinators from the childCoordinators array
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}

extension Coordinator: Equatable {
    
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    
}
