//
//  NavigationBar.swift
//  PixelFlow
//
//  Created by Елизавета on 09.05.2021.
//

import UIKit

extension UIViewController {

    @objc
    func navigationBarClose() {
        self.dismiss(animated: true)
    }
}

class NavigationBar: UIView {

    enum LeftButtonMode {
        case unset
        case close
        case back
        case menu
        case action(image: UIImage, action: () -> Void)
    }

    enum RightButtonMode {
        case unset
        case action(image: UIImage, action: () -> Void)
        case gradientAction(image: UIImage, action: () -> Void)
        case gradientActionText(String, action: () -> Void)
    }

    enum TitleViewMode {
        case title(String?, fontSize: CGFloat? = nil)
        case titleDescription(String?, String?)
        case full(UIView)
    }

    weak var parent: UIViewController?

    private var bottomAnchorConstraintActive: NSLayoutConstraint?
    private var bottomAnchorConstraintInactive: NSLayoutConstraint?

//    var leftButtonMode = LeftButtonMode.unset {
//        didSet {
//            self.updateLeftButtonMode()
//        }
//    }

//    var rightButtonMode = RightButtonMode.unset {
//        didSet {
//            self.updateRightButtonMode()
//        }
//    }

    var titleViewMode = TitleViewMode.title(nil) {
        didSet {
            self.updateTitleViewMode()
        }
    }

    override var isHidden: Bool {
        didSet {
            self.updateNavigationBarState()
        }
    }

//    private lazy var overlayView: GradientView = {
//        let view = GradientView(gradient: Gradient(direction: .vertical, colors: [rgba(255, 255, 255, 0.8), rgba(255, 255, 255, 0)]))
//        return view
//    }()

//    var isOverlayEnabled: Bool = false {
//        didSet {
//            self.overlayView.isHidden = !self.isOverlayEnabled
//        }
//    }

    private(set) lazy var leftButton: Button = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "left_arrow"))
        let button = Button(type: .bulging, view: imageView)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 43)
        return button
    }()

    private(set) var rightButton: Button?

    private(set) var titleView: UIView?

    private(set) lazy var titleViewTap: GestureRecognizer<UITapGestureRecognizer> = {
        let recognizer = GestureRecognizer(of: UITapGestureRecognizer.self)
        recognizer.gestureRecognizer.cancelsTouchesInView = false
        return recognizer
    }()

    func add(toView view: UIView, controller: UIViewController) {
        view.addSubview(self)
        self.parent = controller

        self.layout.top.equal(to: view.layout.top)
        self.layout.left.equal(to: view.layout.left)
        self.layout.right.equal(to: view.layout.right)

        self.bottomAnchorConstraintActive = self.layout
            .bottom
            .equal(to: view.layout.safe.top,
                   offset: 68,
                   priority: .navigationMin,
                   removeExisting: false)
        self.bottomAnchorConstraintActive?.isActive = false

        self.bottomAnchorConstraintInactive = self.layout
            .bottom
            .equal(to: view.layout.top,
                   priority: .navigationMax,
                   removeExisting: false)

        self.updateNavigationBarState()

//        self.superview?.addSubview(self.overlayView)
//        self.overlayView.isUserInteractionEnabled = false
//        self.overlayView.layout.top.equal(to: self.layout.bottom)
//        self.overlayView.layout.left.equal(to: self.layout.left)
//        self.overlayView.layout.right.equal(to: self.layout.right)
//        self.overlayView.layout.height.equal(to: 80)
//        self.isOverlayEnabled = false
    }

    private func updateNavigationBarState() {
        guard self.superview != nil && self.parent != nil else { return }

        if self.isHidden {
            self.bottomAnchorConstraintActive?.isActive = false
            self.bottomAnchorConstraintActive?.priority = .navigationMin

            self.bottomAnchorConstraintInactive?.priority = .navigationMax
            self.bottomAnchorConstraintInactive?.isActive = true
        } else {
            self.bottomAnchorConstraintInactive?.isActive = false
            self.bottomAnchorConstraintInactive?.priority = .navigationMin

            self.bottomAnchorConstraintActive?.priority = .navigationMax
            self.bottomAnchorConstraintActive?.isActive = true
        }
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()

        defer {
       //     self.updateLeftButtonMode()
            self.updateRightButtonMode()
            self.updateTitleViewMode()
        }
  //      guard case .unset = self.leftButtonMode else { return }

   //     let numberOfControllers = self.parent?.navigationController?.viewControllers.count ?? 0

//        if numberOfControllers > 1 {
//            self.leftButtonMode = .back
//        } else {
//            self.leftButtonMode = .close
//        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    private func commonInit() {
        self.clipsToBounds = true
        self.backgroundColor = .white

        self.setupButtons()
    }

    private func setupButtons() {
        let selector = #selector(type(of: self).leftButtonAction(_:))
        self.addSubview(self.leftButton)
        self.leftButton.layout.top.equal(to: self.layout.safe, offset: 12)
        self.leftButton.layout.left.equal(to: self, offset: 16)
        self.leftButton.addTarget(self, action: selector, for: .touchUpInside)
    }

//    private func updateLeftButtonMode() {
//        switch self.leftButtonMode {
//        case .unset:
//            preconditionFailure("should never be used")
//  //      case .menu:
////            self.leftButton.setImage(#imageLiteral(resourceName: "il_navigation_menu"))
////        case .close:
////            self.leftButton.setImage(#imageLiteral(resourceName: "il_navigation_close"))
////        case .back:
////            self.leftButton.setImage(#imageLiteral(resourceName: "il_navigation_back"))
////        case .action(let image, _):
////            self.leftButton.setImage(image)
//        }
//    }

    private func updateRightButtonMode() {
        self.rightButton?.removeFromSuperview()

//        switch self.rightButtonMode {
//        case .unset:
//            self.rightButton = nil
//        case .action(let image, _):
//            self.rightButton = Button(type: .gray)
//            self.rightButton?.setImage(image)
//        case .gradientAction(let image, _):
//            self.rightButton = Button(type: .defaultGradientLowShadow)
//            self.rightButton?.setImage(image)
//        case .gradientActionText(let text, _):
//            self.rightButton = Button(type: .defaultGradientLowShadow)
//            self.rightButton?.titleLabel?.font = .font(family: .blogger, size: 16)
//            self.rightButton?.setTitle(text)
//        }

        if let button = self.rightButton {
            let selector = #selector(type(of: self).rightButtonAction(_:))
            self.addSubview(button)

//            if button.currentImage != nil {
//                button.layout.size.equal(to: CGSize(side: 40))
//            } else {
//                button.layout.size.equal(to: CGSize(width: 80, height: 40))
//            }

            button.layout.top.equal(to: self.layout.safe, offset: 12)
            button.layout.right.equal(to: self, offset: -16)
            button.addTarget(self, action: selector, for: .touchUpInside)
        }

        self.updateTitleViewMode()
    }

    private func updateTitleViewMode() {
        UIView.performWithoutAnimation {
            self.titleView?.removeGestureRecognizer(self.titleViewTap.gestureRecognizer)
            self.titleView?.removeFromSuperview()
            switch self.titleViewMode {
            case .title(let string, let fontSize):
                let title = Label(type: .title, textMode: .uppercase, text: string)
                title.adjustsFontSizeToFitWidth = true
                title.minimumScaleFactor = 0.75
                self.addSubview(title)
                title.layout.left.equal(to: self.leftButton.layout.right, offset: 16)
                title.layout.top.equal(to: self.layout.safe.top, offset: 12)
                title.layout.bottom.equal(to: self, offset: -12)

                if let fontSize = fontSize { title.font = title.font.withSize(fontSize) }
                if self.rightButton == nil {
                    title.layout.centerX.equal(to: self)
                } else {
                    title.layout.right.equal(to: self, offset: -72)
                }
                self.titleView = title
            case .full(let view):
                self.addSubview(view)
                view.layout.left.equal(to: self.leftButton.layout.right, offset: 16)
                view.layout.top.equal(to: self.layout.safe.top, offset: 12)
                view.layout.bottom.equal(to: self.layout.bottom, offset: -12)

                if let button = self.rightButton {
                    view.layout.right.equal(to: button.layout.left, offset: -16)
                } else {
                    view.layout.right.equal(to: self.layout.right, offset: -16)
                }
                self.titleView = view
            case .titleDescription(let upperText, let lowerText):
                let container = UIView()
                self.addSubview(container)
                container.layout.left.equal(to: self.leftButton.layout.right, offset: 16)
                container.layout.top.equal(to: self.layout.safe.top, offset: 12)
                container.layout.bottom.equal(to: self, offset: -12)

                if let button = self.rightButton {
                    container.layout.right.equal(to: button.layout.left, offset: -16)
                } else {
                    container.layout.right.equal(to: self, offset: -72)
                }

                let title = Label(type: .title, textMode: .uppercase, text: upperText)
                title.textColor = UIColor.PF.regularText
                title.numberOfLines = 1

//                if let text = upperText {
//                    let attributedUpperText = NSMutableAttributedString(string: text)
//                    attributedUpperText.kern(at: NSRange(location: 0, length: attributedUpperText.length), 1.4)
//                    title.attributedText = attributedUpperText
//                }

                let description = Label(type: .title, text: lowerText)
                description.textColor = UIColor.PF.regularText
                description.numberOfLines = 1

                if let text = lowerText {
                    let attributedUpperText = NSMutableAttributedString(string: text)
                  //  attributedUpperText.kern(at: NSRange(location: 0, length: attributedUpperText.length), 1.2)
                    description.attributedText = attributedUpperText
                }

                container.addSubview(title)
                container.addSubview(description)
                title.layout.bottom.equal(to: container.layout.centerY, offset: -2)
                title.layout.left.equal(to: container)
                title.layout.right.equal(to: container)
                description.layout.top.equal(to: container.layout.centerY, offset: 2)
                description.layout.left.equal(to: container)
                description.layout.right.equal(to: container)
                self.titleView = container
            }
            self.titleView?.setNeedsLayout()
            self.titleView?.layoutIfNeeded()
        }

        self.titleView?.isUserInteractionEnabled = true
        self.titleView?.addGestureRecognizer(self.titleViewTap.gestureRecognizer)
        self.titleView?.layer.removeAllAnimations()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
   //     self.updateGradient()
    }

    @objc
    func leftButtonAction(_ sender: Any?) {
//        switch self.leftButtonMode {
//        case .unset:
//            preconditionFailure("should never be used")
//        case .menu:
//            self.parent?
//                .navigationController?
//                .menu?
//                .open()
//        case .close:
//            self.parent?.navigationBarClose()
//        case .back:
//            self.parent?
//                .navigationController?
//                .popViewController(animated: true)
//        case .action(_, let action):
//            action()
//        }
    }

    @objc
    func rightButtonAction(_ sender: Any?) {
//        switch self.rightButtonMode {
//        case .unset:
//            break
//        case .action(_, let action):
//            action()
//        case .gradientAction(_, let action):
//            action()
//        case .gradientActionText(_, let action):
//            action()
//        }
    }
}
