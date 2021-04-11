//
//  UIView+Anchors.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

extension UIView {

    var layout: Anchors {
        return Anchors(owner: .view(self))
    }
}

extension UIView {

    struct Anchors {

        var insets: UIEdgeInsets {
            switch self.owner {
            case .view: return .zero
            case .layoutGuide(let guide):
                if #available(iOS 11, *) {
                    return guide.owningView?.safeAreaInsets ?? .zero
                }
                return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            }
        }

        enum Owner {
            case view(UIView)
            case layoutGuide(UILayoutGuide)
        }

        private(set) var owner: Owner

        var safe: Anchors {
            if #available(iOS 11, *) {
                switch self.owner {
                case .view(let view):
                    return Anchors(owner: .layoutGuide(view.safeAreaLayoutGuide))
                case .layoutGuide:
                    return self
                }
            } else {
                switch self.owner {
                case .view(let view):
                    if let guide = view.layoutGuides.first(where: { $0 is __SafeLayoutGuide } ) {
                        return Anchors(owner: .layoutGuide(guide))
                    } else {
                        guard let topViewController = SceneDelegate.main?.window?.topViewController else {
                            preconditionFailure("no top view controller")
                        }

                        let layoutGuide = __SafeLayoutGuide()
                        layoutGuide.applyOn(view: view, controller: topViewController)

                        return Anchors(owner: .layoutGuide(layoutGuide))
                    }
                case .layoutGuide:
                    return self
                }
            }
        }

        var center: Centers {
            switch self.owner {
            case .view(let view): return Centers(view: view, item: view)
            case .layoutGuide(let guide): return Centers(view: guide.owningView, item: guide)
            }
        }

        var all: Sides {
            switch self.owner {
            case .view(let view): return Sides(view: view, item: view)
            case .layoutGuide(let guide): return Sides(view: guide.owningView, item: guide)
            }
        }

        var size: Sizes {
            switch self.owner {
            case .view(let view): return Sizes(view: view, item: view)
            case .layoutGuide(let guide): return Sizes(view: guide.owningView, item: guide)
            }
        }

        var top: YAxis {
            switch self.owner {
            case .view(let view): return YAxis(view: view, item: view, attribute: .top)
            case .layoutGuide(let guide): return YAxis(view: guide.owningView, item: guide, attribute: .top)
            }
        }

        var bottom: YAxis {
            switch self.owner {
            case .view(let view): return YAxis(view: view, item: view, attribute: .bottom)
            case .layoutGuide(let guide): return YAxis(view: guide.owningView, item: guide, attribute: .bottom)
            }
        }

        var centerY: YAxis {
            switch self.owner {
            case .view(let view): return YAxis(view: view, item: view, attribute: .center)
            case .layoutGuide(let guide): return YAxis(view: guide.owningView, item: guide, attribute: .center)
            }
        }

        var left: XAxis {
            switch self.owner {
            case .view(let view): return XAxis(view: view, item: view, attribute: .left)
            case .layoutGuide(let guide): return XAxis(view: guide.owningView, item: guide, attribute: .left)
            }
        }

        var right: XAxis {
            switch self.owner {
            case .view(let view): return XAxis(view: view, item: view, attribute: .right)
            case .layoutGuide(let guide): return XAxis(view: guide.owningView, item: guide, attribute: .right)
            }
        }

        var centerX: XAxis {
            switch self.owner {
            case .view(let view): return XAxis(view: view, item: view, attribute: .center)
            case .layoutGuide(let guide): return XAxis(view: guide.owningView, item: guide, attribute: .center)
            }
        }

        var width: Dimmention {
            switch self.owner {
            case .view(let view): return Dimmention(view: view, item: view, attribute: .width)
            case .layoutGuide(let guide): return Dimmention(view: guide.owningView, item: guide, attribute: .width)
            }
        }

        var height: Dimmention {
            switch self.owner {
            case .view(let view): return Dimmention(view: view, item: view, attribute: .height)
            case .layoutGuide(let guide): return Dimmention(view: guide.owningView, item: guide, attribute: .height)
            }
        }

        var horizontal: XLines {
            switch self.owner {
            case .view(let view): return XLines(view: view, item: view)
            case .layoutGuide(let guide): return XLines(view: guide.owningView, item: guide)
            }
        }

        var vertical: YLines {
            switch self.owner {
            case .view(let view): return YLines(view: view, item: view)
            case .layoutGuide(let guide): return YLines(view: guide.owningView, item: guide)
            }
        }
    }
}
