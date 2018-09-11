//
//  Transition.swift
//  XCoordinator
//
//  Created by Stefan Kofler on 30.04.18.
//  Copyright © 2018 Stefan Kofler. All rights reserved.
//

public struct Transition<RootViewController: UIViewController>: TransitionProtocol {
    public typealias Perform = (TransitionOptions, AnyTransitionPerformer<Transition<RootViewController>>, PresentationHandler?) -> Void
    private var _presentable: Presentable?
    private var _perform: Perform

    public var presentable: Presentable? {
        return _presentable
    }

    public init(presentable: Presentable?, perform: @escaping Perform) {
        self._presentable = presentable
        self._perform = perform
    }

    public func perform<C: Coordinator>(options: TransitionOptions, coordinator: C, completion: PresentationHandler?) where C.TransitionType == Transition<RootViewController> {
        let anyPerformer = AnyTransitionPerformer(coordinator)
        _perform(options, anyPerformer, completion)
    }

    public static func generateRootViewController() -> RootViewController {
        return RootViewController()
    }
}

extension Transition {
    public static func present(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        return .init(presentable: presentable) { options, performer, completion in
            presentable.presented(from: performer)
            performer.present(presentable.viewController, with: options, animation: animation, completion: completion)
        }
    }

    public static func embed(_ presentable: Presentable, in container: Container) -> Transition {
        return .init(presentable: presentable) { options, performer, completion in
            presentable.presented(from: performer)
            performer.embed(presentable.viewController, in: container, with: options, completion: completion)
        }
    }

    public static func dismiss(animation: Animation? = nil) -> Transition {
        return .init(presentable: nil) { options, performer, completion in
            performer.dismiss(with: options, animation: animation, completion: completion)
        }
    }

    public static func none() -> Transition {
        return .init(presentable: nil) { options, performer, completion in
            completion?()
        }
    }

    public static func multiple(_ transitions: [Transition<RootViewController>], completion: PresentationHandler?) -> Transition {
        return .init(presentable: nil) { _, _, _ in }
    }

    public static func registerPeek<C: Coordinator>(for source: Container, route: C.RouteType, coordinator: C) -> Transition where C.TransitionType == Transition {
        let transition = coordinator.prepareTransition(for: route)
        return .init(presentable: transition.presentable) { options, performer, completion in
            return performer.registerPeek(from: source.view, transition: transition, completion: completion)
        }
    }
}
