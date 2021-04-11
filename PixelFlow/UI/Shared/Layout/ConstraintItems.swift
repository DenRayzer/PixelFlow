//
//  ConstraintItems.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

protocol SimpleConstraintItem {

    var view: UIView? { get }
    var item: Constrainable { get }
}

extension SimpleConstraintItem {

    func fixAutoresizing(with other: SimpleConstraintItem?) {
        guard let lhs = self.view else { return }

        if let rhs = other?.view, rhs.isDescendant(of: lhs) {
            rhs.translatesAutoresizingMaskIntoConstraints = false
        } else {
            lhs.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

protocol ConstraintAttributable {

    var raw: NSLayoutConstraint.Attribute { get }
}

extension ConstraintAttributable {

}

protocol AttributedConstraintItem: SimpleConstraintItem {

    associatedtype Attribute: ConstraintAttributable

    var attribute: Attribute { get }

    func from(_ item: Constrainable) -> Self
    func from(_ anchors: UIView.Anchors) -> Self
}

// MARK: - Shared Methods

extension AttributedConstraintItem {

    @discardableResult
    func equal(to other: Constrainable,
               offset: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .maximum,
               removeExisting: Bool = true,
               activated: Bool = true) -> NSLayoutConstraint {
        return self.equal(to: self.from(other),
                          offset: offset,
                          multiplier: multiplier,
                          priority: priority,
                          removeExisting: removeExisting,
                          activated: activated)
    }

    @discardableResult
    func equal(to other: UIView.Anchors,
               offset: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .maximum,
               removeExisting: Bool = true,
               activated: Bool = true) -> NSLayoutConstraint {
        return self.equal(to: self.from(other),
                          offset: offset,
                          multiplier: multiplier,
                          priority: priority,
                          removeExisting: removeExisting,
                          activated: activated)
    }

    @discardableResult
    func equal(to other: Self,
               offset: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .maximum,
               removeExisting: Bool = true,
               activated: Bool = true) -> NSLayoutConstraint {
        self.fixAutoresizing(with: other)

        if removeExisting {
            let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: other.item)
            existingConstraint?.isActive = false
        }

        let value = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                       relatedBy: .equal,
                                       toItem: other.item, attribute: other.attribute.raw,
                                       multiplier: multiplier, constant: offset)

        value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute))-\(String(describing: other.item.__view)))"
        value.priority = priority
        value.isActive = activated

        return value
    }

    @discardableResult
    func greater(than other: Constrainable,
                 offset: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .maximum,
                 removeExisting: Bool = true,
                 activated: Bool = true) -> NSLayoutConstraint {
        return self.greater(than: self.from(other),
                            offset: offset,
                            multiplier: multiplier,
                            priority: priority,
                            removeExisting: removeExisting,
                            activated: activated)
    }

    @discardableResult
    func greater(than other: UIView.Anchors,
                 offset: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .maximum,
                 removeExisting: Bool = true,
                 activated: Bool = true) -> NSLayoutConstraint {
        return self.greater(than: self.from(other),
                            offset: offset,
                            multiplier: multiplier,
                            priority: priority,
                            removeExisting: removeExisting,
                            activated: activated)
    }

    @discardableResult
    func greater(than other: Self,
                 offset: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .maximum,
                 removeExisting: Bool = true,
                 activated: Bool = true) -> NSLayoutConstraint {
        self.fixAutoresizing(with: other)

        if removeExisting {
            let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: other.item)
            existingConstraint?.isActive = false
        }

        let value = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                       relatedBy: .greaterThanOrEqual,
                                       toItem: other.item, attribute: other.attribute.raw,
                                       multiplier: multiplier, constant: offset)

        value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute.raw))-\(String(describing: other.item.__view)))"
        value.priority = priority
        value.isActive = activated
        return value
    }

    @discardableResult
    func less(than other: Constrainable,
              offset: CGFloat = 0,
              multiplier: CGFloat = 1,
              priority: UILayoutPriority = .maximum,
              removeExisting: Bool = true,
              activated: Bool = true) -> NSLayoutConstraint {
        return self.less(than: self.from(other),
                         offset: offset,
                         multiplier: multiplier,
                         priority: priority,
                         removeExisting: removeExisting,
                         activated: activated)
    }

    @discardableResult
    func less(than other: UIView.Anchors,
              offset: CGFloat = 0,
              multiplier: CGFloat = 1,
              priority: UILayoutPriority = .maximum,
              removeExisting: Bool = true,
              activated: Bool = true) -> NSLayoutConstraint {
        return self.less(than: self.from(other),
                         offset: offset,
                         multiplier: multiplier,
                         priority: priority,
                         removeExisting: removeExisting,
                         activated: activated)
    }

    @discardableResult
    func less(than other: Self,
              offset: CGFloat = 0,
              multiplier: CGFloat = 1,
              priority: UILayoutPriority = .maximum,
              removeExisting: Bool = true,
              activated: Bool = true) -> NSLayoutConstraint {
        self.fixAutoresizing(with: other)

        if removeExisting {
            let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: other.item)
            existingConstraint?.isActive = false
        }

        let value = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                       relatedBy: .lessThanOrEqual,
                                       toItem: other.item, attribute: other.attribute.raw,
                                       multiplier: multiplier, constant: offset)

        value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute.raw))-\(String(describing: other.item.__view)))"
        value.priority = priority
        value.isActive = activated

        return value
    }
}

// MARK: - Position Anchors

extension UIView.Anchors {

    struct XAxis: AttributedConstraintItem {

        func from(_ item: Constrainable) -> XAxis {
            return type(of: self).init(view: item.__view, item: item, attribute: self.attribute)
        }

        func from(_ anchors:
                    UIView.Anchors) -> XAxis {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        enum Attribute: ConstraintAttributable {
            case left
            case right
            case center

            var raw: NSLayoutConstraint.Attribute {
                switch self {
                case .left:
                    return .left
                case .right:
                    return .right
                case .center:
                    return .centerX
                }
            }
        }

        private(set) var view: UIView?
        private(set) var item: Constrainable
        private(set) var attribute: Attribute
    }

    struct YAxis: AttributedConstraintItem {

        func from(_ item: Constrainable) -> YAxis {
            return type(of: self).init(view: item.__view, item: item, attribute: self.attribute)
        }

        func from(_ anchors: UIView.Anchors) -> YAxis {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        enum Attribute: ConstraintAttributable {
            case top
            case bottom
            case center

            var raw: NSLayoutConstraint.Attribute {
                switch self {
                case .top:
                    return .top
                case .bottom:
                    return .bottom
                case .center:
                    return .centerY
                }
            }
        }

        private(set) var view: UIView?
        private(set) var item: Constrainable
        private(set) var attribute: Attribute
    }

    struct Centers: SimpleConstraintItem {

        private(set) var view: UIView?
        private(set) var item: Constrainable

        func from(_ item: Constrainable) -> Centers {
            return type(of: self).init(view: item.__view, item: item)
        }

        func from(_ anchors: UIView.Anchors) -> Centers {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: CGPoint = .zero,
                   removeExisting: Bool = true)
        -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              removeExisting: removeExisting)
        }
        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: CGPoint = .zero,
                   removeExisting: Bool = true)
        -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: Centers,
                   offset: CGPoint = .zero,
                   removeExisting: Bool = true) -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
            self.fixAutoresizing(with: other)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .centerX, appliedTo: other.item)
                existingConstraint?.isActive = false
            }

            let x = NSLayoutConstraint(item: self.item, attribute: .centerX,
                                       relatedBy: .equal,
                                       toItem: other.item, attribute: .centerX,
                                       multiplier: 1.0, constant: offset.x)
            x.identifier = "Layout: \(String(describing: self.item.__view))-.centerX-\(String(describing: other.item.__view)))"
            x.isActive = true

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .centerY, appliedTo: other.item)
                existingConstraint?.isActive = false
            }

            let y = NSLayoutConstraint(item: self.item, attribute: .centerY,
                                       relatedBy: .equal,
                                       toItem: other.item, attribute: .centerY,
                                       multiplier: 1.0, constant: offset.y)
            y.identifier = "Layout: \(String(describing: self.item.__view))-.centerY-\(String(describing: other.item.__view)))"
            y.isActive = true

            return (x, y)
        }
    }
}

// MARK: - Size Anchors

extension UIView.Anchors {

    struct Dimmention: AttributedConstraintItem {

        func from(_ item: Constrainable) -> Dimmention {
            return type(of: self).init(view: item.__view, item: item, attribute: self.attribute)
        }

        func from(_ anchors: UIView.Anchors) -> Dimmention {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        enum Attribute: ConstraintAttributable {
            case width
            case height

            var raw: NSLayoutConstraint.Attribute {
                switch self {
                case .width:
                    return .width
                case .height:
                    return .height
                }
            }
        }

        private(set) var view: UIView?
        private(set) var item: Constrainable
        private(set) var attribute: Attribute

        @discardableResult
        func equal(to value: CGFloat,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true) -> NSLayoutConstraint {
            self.fixAutoresizing(with: nil)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: nil)
                existingConstraint?.isActive = false
            }

            let value = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                           relatedBy: .equal,
                                           toItem: nil, attribute: .notAnAttribute,
                                           multiplier: 1.0, constant: value)

            value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute.raw))-self)"
            value.priority = priority
            value.isActive = true
            return value
        }

        @discardableResult
        func greater(than value: CGFloat,
                     priority: UILayoutPriority = .maximum,
                     removeExisting: Bool = true) -> NSLayoutConstraint {
            self.fixAutoresizing(with: nil)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: nil)
                existingConstraint?.isActive = false
            }

            let value = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                           relatedBy: .greaterThanOrEqual,
                                           toItem: nil, attribute: .notAnAttribute,
                                           multiplier: 1.0, constant: value)

            value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute.raw))-self)"
            value.priority = priority
            value.isActive = true
            return value
        }

        @discardableResult
        func less(than value: CGFloat,
                  priority: UILayoutPriority = .maximum,
                  removeExisting: Bool = true) -> NSLayoutConstraint {
            self.fixAutoresizing(with: nil)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: self.attribute.raw, appliedTo: nil)
                existingConstraint?.isActive = false
            }

            let value
                = NSLayoutConstraint(item: self.item, attribute: self.attribute.raw,
                                     relatedBy: .lessThanOrEqual,
                                     toItem: nil, attribute: .notAnAttribute,
                                     multiplier: 1.0, constant: value)

            value.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: self.attribute.raw))-self)"
            value.priority = priority
            value.isActive = true
            return value
        }
    }

    struct Sizes: SimpleConstraintItem {

        private(set) var view: UIView?
        private(set) var item: Constrainable

        @discardableResult
        func equal(to size: CGSize,
                   removeExisting: Bool = true) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
            self.fixAutoresizing(with: nil)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .width, appliedTo: nil)
                existingConstraint?.isActive = false
            }

            let width = NSLayoutConstraint(item: self.item, attribute: .width,
                                           relatedBy: .equal,
                                           toItem: nil, attribute: .notAnAttribute,
                                           multiplier: 1.0, constant: size.width)

            width.identifier = "Layout: \(String(describing: self.item.__view))-.width-self)"
            width.isActive = true

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .height, appliedTo: nil)
                existingConstraint?.isActive = false
            }

            let height = NSLayoutConstraint(item: self.item, attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil, attribute: .notAnAttribute,
                                            multiplier: 1.0, constant: size.height)

            height.identifier = "Layout: \(String(describing: self.item.__view))-.height-self"
            height.isActive = true

            return (width, height)
        }
    }
}

extension UIView.Anchors {

    struct Sides: SimpleConstraintItem {

        struct ConstraintGroup {

            fileprivate(set) var top: NSLayoutConstraint?
            fileprivate(set) var left: NSLayoutConstraint?
            fileprivate(set) var bottom: NSLayoutConstraint?
            fileprivate(set) var right: NSLayoutConstraint?
        }

        struct Elements: OptionSet {
            let rawValue: Int

            static let top = Elements(rawValue: 1 << 0)
            static let left = Elements(rawValue: 1 << 1)
            static let bottom = Elements(rawValue: 1 << 2)
            static let right = Elements(rawValue: 1 << 3)

            static let all: Elements = [.top, .left, .bottom, .right]
        }

        struct PriorityGroup {

            static let maximum = PriorityGroup()

            var top: UILayoutPriority
            var left: UILayoutPriority

            var bottom: UILayoutPriority
            var right: UILayoutPriority

            init(top: UILayoutPriority = .maximum,
                 left: UILayoutPriority = .maximum,
                 bottom: UILayoutPriority = .maximum,
                 right: UILayoutPriority = .maximum) {
                self.top = top
                self.left = left
                self.bottom = bottom
                self.right = right
            }
        }

        private(set) var view: UIView?
        private(set) var item: Constrainable
        private(set) var elements = Elements.all

        init(view: UIView?, item: Constrainable, elements: Elements = .all) {
            self.view = view
            self.item = item
            self.elements = elements
        }

        func from(_ item: Constrainable) -> Sides {
            return type(of: self).init(view: item.__view, item: item, elements: self.elements)
        }

        func from(_ anchors: UIView.Anchors) -> Sides {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        func except(_ elementsToExclude: Elements) -> Sides {
            var new = self
            new.elements.subtract(elementsToExclude)
            return new
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: UIEdgeInsets = .zero,
                   priority: PriorityGroup = .maximum,
                   removeExisting: Bool = true) -> ConstraintGroup {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: UIEdgeInsets = .zero,
                   priority: PriorityGroup = .maximum,
                   removeExisting: Bool = true) -> ConstraintGroup {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: Sides,
                   offset: UIEdgeInsets = .zero,
                   priority: PriorityGroup = .maximum,
                   removeExisting: Bool = true) -> ConstraintGroup {
            self.fixAutoresizing(with: other)

            var result = ConstraintGroup()

            let array = zip([Elements.top, Elements.left, Elements.bottom, Elements.right],
                            [(NSLayoutConstraint.Attribute.top, offset.top, priority.top),
                             (NSLayoutConstraint.Attribute.left, offset.left, priority.left),
                             (NSLayoutConstraint.Attribute.bottom, -offset.bottom, priority.bottom),
                             (NSLayoutConstraint.Attribute.right, -offset.right, priority.right)
                            ])

            for (element, (attribute, offset, priority)) in array where self.elements.contains(element) {

                if removeExisting {
                    let existingConstraint = self.item.constraint(for: attribute, appliedTo: other.item)
                    existingConstraint?.isActive = false
                }

                let constraint = NSLayoutConstraint(item: self.item, attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: other.item, attribute: attribute,
                                                    multiplier: 1.0, constant: offset)

                constraint.identifier = "Layout: \(String(describing: self.item.__view))-\(String(describing: attribute))-\(String(describing: other.item.__view)))"
                constraint.priority = priority
                constraint.isActive = true

                switch element {
                case .top:
                    result.top = constraint
                case .left:
                    result.left = constraint
                case .bottom:
                    result.bottom = constraint
                case .right:
                    result.right = constraint
                default:
                    continue
                }
            }

            return result
        }
    }

    struct YLines: SimpleConstraintItem {

        private(set) var view: UIView?
        private(set) var item: Constrainable

        func from(_ item: Constrainable) -> YLines {
            return type(of: self).init(view: item.__view, item: item)
        }

        func from(_ anchors: UIView.Anchors) -> YLines {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority)
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: YLines,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: YLines,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            self.fixAutoresizing(with: other)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .top, appliedTo: other.item)
                existingConstraint?.isActive = false
            }

            let first = NSLayoutConstraint(item: self.item, attribute: .top,
                                           relatedBy: .equal,
                                           toItem: other.item, attribute: .top,
                                           multiplier: 1.0, constant: offset.first)

            first.identifier = "Layout: \(String(describing: self.item.__view))-.top-\(String(describing: other.item.__view)))"
            first.priority = priority
            first.isActive = true

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .bottom, appliedTo: other.item)
                existingConstraint?.isActive = false
            }

            let second = NSLayoutConstraint(item: self.item, attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: other.item, attribute: .bottom,
                                            multiplier: 1.0, constant: -offset.second)

            second.identifier = "Layout: \(String(describing: self.item.__view))-.bottom-\(String(describing: other.item.__view)))"
            second.priority = priority
            second.isActive = true

            return (first, second)
        }
    }

    struct XLines: SimpleConstraintItem {

        private(set) var view: UIView?
        private(set) var item: Constrainable

        func from(_ item: Constrainable) -> XLines {
            return type(of: self).init(view: item.__view, item: item)
        }

        func from(_ anchors: UIView.Anchors) -> XLines {
            switch anchors.owner {
            case .view(let view): return self.from(view)
            case .layoutGuide(let guide): return self.from(guide)
            }
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: Constrainable,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: UIView.Anchors,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: self.from(other),
                              offset: offset,
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: XLines,
                   offset: CGFloat = 0,
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            return self.equal(to: other,
                              offset: (offset, offset),
                              priority: priority,
                              removeExisting: removeExisting)
        }

        @discardableResult
        func equal(to other: XLines,
                   offset: (first: CGFloat, second: CGFloat),
                   priority: UILayoutPriority = .maximum,
                   removeExisting: Bool = true)
        -> (first: NSLayoutConstraint, second: NSLayoutConstraint) {
            self.fixAutoresizing(with: other)

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .left, appliedTo: other.item)
                existingConstraint?.isActive = false
            }
            let first = NSLayoutConstraint(item: self.item, attribute: .left,
                                           relatedBy: .equal,
                                           toItem: other.item, attribute: .left,
                                           multiplier: 1.0, constant: offset.first)

            first.identifier = "Layout: \(String(describing: self.item.__view))-.left-\(String(describing: other.item.__view)))"
            first.priority = priority
            first.isActive = true

            if removeExisting {
                let existingConstraint = self.item.constraint(for: .right, appliedTo: other.item)
                existingConstraint?.isActive = false
            }

            let second = NSLayoutConstraint(item: self.item, attribute: .right,
                                            relatedBy: .equal,
                                            toItem: other.item, attribute: .right,
                                            multiplier: 1.0, constant: -offset.second)

            second.identifier = "Layout: \(String(describing: self.item.__view))-.right-\(String(describing: other.item.__view)))"
            second.priority = priority
            second.isActive = true

            return (first, second)
        }
    }
}

