//
//  Animation+TabBar.swift
//  XCoordinator
//
//  Created by Paul Kraft on 16.09.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

class TabBarControllerAnimationDelegate: NSObject, UITabBarControllerDelegate {

    // MARK: - Stored properties

    var animation: Animation?
    weak var delegate: UITabBarControllerDelegate?

    // MARK: - Overrides

    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print(#function)
        return animation?.presentationAnimation as? UIViewControllerInteractiveTransitioning
    }

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print(#function)
        return animation?.presentationAnimation
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        delegate?.tabBarController?(tabBarController, didSelect: viewController)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return delegate?.tabBarController?(tabBarController, shouldSelect: viewController) ?? true
    }

    func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        delegate?.tabBarController?(tabBarController, willBeginCustomizing: viewControllers)
    }

    func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return delegate?.tabBarControllerSupportedInterfaceOrientations?(tabBarController)
            ?? tabBarController.selectedViewController?.supportedInterfaceOrientations
            ?? .all
    }

    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        delegate?.tabBarController?(tabBarController, didEndCustomizing: viewControllers, changed: changed)
    }

    func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return delegate?.tabBarControllerPreferredInterfaceOrientationForPresentation?(tabBarController)
            ?? tabBarController.selectedViewController?.preferredInterfaceOrientationForPresentation
            ?? .unknown
    }

    func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        delegate?.tabBarController?(tabBarController, willEndCustomizing: viewControllers, changed: changed)
    }
}

extension UITabBarController {
    internal var animationDelegate: TabBarControllerAnimationDelegate? {
        return delegate as? TabBarControllerAnimationDelegate
    }

    public var coordinatorDelegate: UITabBarControllerDelegate? {
        return animationDelegate?.delegate
    }
}