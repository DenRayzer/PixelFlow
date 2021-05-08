//
//  FloatyBible.swift
//  PixelFlow
//
//  Created by Elizaveta on 5/6/21.
//

import Foundation
import UIKit

extension UIView {
    func addDragging(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func draggedAction(_ pan:UIPanGestureRecognizer){
        
        let translation = pan.translation(in: self.superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: self.superview)
    }
}


/**
 KCFloatingActionButton dependent on UIWindow.
 */
class FloatyWindow: UIWindow {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.clear
    self.windowLevel = UIWindow.Level.normal
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let floatyViewController = rootViewController as? FloatyViewController
    if let floaty = floatyViewController?.floaty {
      if floaty.closed == false {
        return true
      }
      
      if floaty.frame.contains(point) == true {
        return true
      }
      
      for item in floaty.items {
        let itemFrame = self.convert(item.frame, from: floaty)
        if itemFrame.contains(point) == true {
          return true
        }
      }
    }
    
    return false
  }
}


/**
 KCFloatingActionButton dependent on UIWindow.
 */
open class FloatyViewController: UIViewController {
  public let floaty = Floaty()
  var statusBarStyle: UIStatusBarStyle = .default
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(floaty)
  }
  
  override open var preferredStatusBarStyle: UIStatusBarStyle {
    get {
      return statusBarStyle
    }
  }
}


/**
 KCFloatingActionButton dependent on UIWindow.
 */
open class FloatyManager: NSObject {
  private static var __once: () = {
    StaticInstance.instance = FloatyManager()
  }()
  struct StaticInstance {
    static var dispatchToken: Int = 0
    static var instance: FloatyManager?
  }
  
  class func defaultInstance() -> FloatyManager {
    _ = FloatyManager.__once
    return StaticInstance.instance!
  }
  
  var _floatyWindow: FloatyWindow? = nil
  var floatyWindow: FloatyWindow {
    get {
      if _floatyWindow == nil {
        _floatyWindow = FloatyWindow(frame: UIScreen.main.bounds)
        _floatyWindow?.rootViewController = floatyController
      }
      return _floatyWindow!
    }
  }
  
  var _floatyController: FloatyViewController? = nil
  var floatyController: FloatyViewController {
    get {
      if _floatyController == nil {
        _floatyController = FloatyViewController()
      }
      return _floatyController!
    }
  }
  
  
  open var button: Floaty {
    get {
      return floatyController.floaty
    }
  }
  
  private let fontDescriptor: UIFontDescriptor
  private var _font: UIFont
  
  public override init() {
    fontDescriptor = UIFont.systemFont(ofSize: 20.0).fontDescriptor
    _font = UIFont(descriptor: fontDescriptor, size: 20)
  }
  
  open var font: UIFont {
    get {
      return _font
    }
    set {
      _font = newValue
    }
  }
  
  private var _rtlMode = false
  open var rtlMode: Bool {
    get {
      return _rtlMode
    }
    set{
      _rtlMode = newValue
    }
  }
  
  open func show(_ animated: Bool = true) {
    if animated == true {
      floatyWindow.isHidden = false
      UIView.animate(withDuration: 0.3, animations: { () -> Void in
        self.floatyWindow.alpha = 1
      })
    } else {
      floatyWindow.isHidden = false
    }
  }
  
  open func hide(_ animated: Bool = true) {
    if animated == true {
      UIView.animate(withDuration: 0.3, animations: { () -> Void in
        self.floatyWindow.alpha = 0
      }, completion: { finished in
        self.floatyWindow.isHidden = true
      })
    } else {
      floatyWindow.isHidden = true
    }
  }
  
  open func toggle(_ animated: Bool = true) {
    if floatyWindow.isHidden == false {
      self.hide(animated)
    } else {
      self.show(animated)
    }
  }
  
  open var hidden: Bool {
    get {
      return floatyWindow.isHidden
    }
  }
}


@objc public enum FloatyItemLabelPositionType: Int {
  case left
  case right
}
