//
//  Constrainable.swift
//  PixelFlow
//
//  Created by Елизавета on 05.04.2021.
//

import UIKit

protocol Constrainable {

    var layout: UIView.Anchors { get }
    var __view: UIView? { get } // swiftlint:disable:this identifier_name

    func constraint(for firstAttribute: NSLayoutConstraint.Attribute, appliedTo secondItem: Constrainable?) -> NSLayoutConstraint?
}

extension Constrainable {

    func constraint(for firstAttribute: NSLayoutConstraint.Attribute, appliedTo secondItem: Constrainable?) -> NSLayoutConstraint? {
        return self.__view?.firstConstraint(for: firstAttribute, appliedTo: secondItem)
    }
}

extension UIView {

    func firstConstraint(for firstAttribute: NSLayoutConstraint.Attribute, appliedTo secondItem: Constrainable?) -> NSLayoutConstraint? {
        let constraints: [NSLayoutConstraint] = UIView.allConstraints(for: self)
        guard let firstConstraint = constraints
            .first(where: { UIView.matchConstraint($0,
                                                   firstItem: self,
                                                   firstAttribute: firstAttribute,
                                                   secondItem: secondItem?.__view) }) else { return nil }

        return firstConstraint
    }

    private static func allConstraints(for viewToCheck: UIView) -> [NSLayoutConstraint] {
        var superviews = [viewToCheck]
        var view = viewToCheck
        while let superview = view.superview {
            superviews.append(superview)
            view = superview
        }

        return superviews
            .flatMap { $0.constraints }
            .filter { constraint in
                let views = UIView.constraintViews(constraint)
                return views.first === viewToCheck || views.second === viewToCheck
        }
    }

    private static func constraintViews(_ constraint: NSLayoutConstraint) -> (first: UIView?, second: UIView?) {
        var firstView, secondView: UIView?

        switch constraint.firstItem {
        case let view as UIView:
            firstView = view
        case let guide as UILayoutGuide:
            firstView = guide.owningView
        default:
            break
        }

        switch constraint.secondItem {
        case let view as UIView:
            secondView = view
        case let guide as UILayoutGuide:
            secondView = guide.owningView
        default:
            break
        }

        return (firstView, secondView)
    }

    private static func matchConstraint(_ constraint: NSLayoutConstraint, firstItem: UIView, firstAttribute: NSLayoutConstraint.Attribute, secondItem: UIView?) -> Bool {
        let (firstView, secondView) = UIView.constraintViews(constraint)

        return (firstView === firstItem && firstAttribute == constraint.firstAttribute && secondView === secondItem)
            || (secondView === firstItem && firstAttribute == constraint.secondAttribute && firstView == secondItem)
    }
}

extension UIView: Constrainable {

    var __view: UIView? { return self } // swiftlint:disable:this identifier_name
}

extension UILayoutGuide: Constrainable {

    var layout: UIView.Anchors {
        return UIView.Anchors(owner: .layoutGuide(self))
    }

    var __view: UIView? { return self.owningView } // swiftlint:disable:this identifier_name
}

extension UIView.Anchors: Constrainable {

    var layout: UIView.Anchors {
        return self
    }

    var __view: UIView? { // swiftlint:disable:this identifier_name
        switch self.owner {
        case .view(let view):
            return view.__view
        case .layoutGuide(let guide):
            return guide.__view
        }
    }
}

