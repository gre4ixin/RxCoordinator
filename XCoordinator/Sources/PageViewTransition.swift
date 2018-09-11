//
//  PageViewTransition.swift
//  XCoordinator
//
//  Created by Paul Kraft on 29.07.18.
//

public typealias PageViewTransition = Transition<UIPageViewController>

extension Transition where RootViewController: UIPageViewController {
    public static func set(_ presentables: [Presentable], direction: UIPageViewControllerNavigationDirection, animation: Animation? = nil) -> PageViewTransition {
        return PageViewTransition(presentable: nil) { options, performer, completion in
            performer.set(presentables.map { $0.viewController }, direction: direction, with: options, animation: animation, completion: completion)
        }
    }
}
