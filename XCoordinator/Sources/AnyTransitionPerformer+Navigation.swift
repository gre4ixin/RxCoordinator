//
//  AnyTransitionPerformer+Navigation.swift
//  XCoordinator
//
//  Created by Paul Kraft on 12.09.18.
//

extension AnyTransitionPerformer where TransitionType.RootViewController: UINavigationController {
    func push(_ viewController: UIViewController, with options: TransitionOptions, animation: Animation?, completion: PresentationHandler?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        viewController.transitioningDelegate = animation
        rootViewController.pushViewController(viewController, animated: options.animated)

        CATransaction.commit()
    }

    func pop(with options: TransitionOptions, toRoot: Bool, animation: Animation?, completion: PresentationHandler?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        let currentVC = rootViewController.visibleViewController
        currentVC?.transitioningDelegate = animation
        if toRoot {
            rootViewController.popToRootViewController(animated: options.animated)
        } else {
            rootViewController.popViewController(animated: options.animated)
        }

        CATransaction.commit()
    }
}
