//
//  SKToastView.swift
//  Pods
//
//  Created by Sachin on 29/12/17.
//

import Foundation
import UIKit

public class SKToast: NSObject {
    
    public typealias completionHandlerType = () -> Swift.Void
    
    // MARK: - Custom Properties
    var window          : UIWindow?
    var toastView       : UIVisualEffectView?
    var statusLabel     : UILabel?
    var toastViewHeight : CGFloat = 50
    
    
    /// HUD Customization Properties
    fileprivate var messageFont              : UIFont            = UIFont.systemFont(ofSize  : 16, weight  : .regular)
    fileprivate var messageTextColor         : UIColor           = UIColor.white
    fileprivate var toastViewBackgroundStyle : UIBlurEffectStyle = .dark
    
    
    // MARK: - Singleton Accessors
    fileprivate static let shared: SKToast = {
        let instance = SKToast()
        return instance
    }()
    
    
    // MARK: - Initialization
    private override init() {
        super.init()
        let delegate: UIApplicationDelegate = UIApplication.shared.delegate!
        if let windowObj = delegate.window {
            window = windowObj
        } else {
            window = UIApplication.shared.keyWindow
        }
        
        toastView = nil
        statusLabel = nil
    }
    
    
    // MARK: - Display Methods
    /**
     Display toast with status message
     
     - parameter message : status message to display
     */
    public static func show(withMessage message:String) {
        DispatchQueue.main.async {
            self.shared.createToastView(message, completionHandler: nil)
        }
    }
    
    /**
     Display toast with status message and completion handler to perform task after toast disappear.
     
     - parameter message : status message to display
     */
    public static func show(withMessage message:String, completionHandler: (@escaping completionHandlerType)) {
        DispatchQueue.main.async {
            self.shared.createToastView(message, completionHandler: {
                completionHandler()
            })
        }
    }
    
    
    // MARK: - Configure Toastview
    fileprivate func createToastView(_ statusMessage:String, completionHandler: (completionHandlerType)? = nil) {
        /// Setup Toast View
        if toastView == nil {
            let blurEffect = UIBlurEffect(style: toastViewBackgroundStyle)
            toastView = UIVisualEffectView(effect: blurEffect)
            toastView!.frame    = CGRect.zero
            toastView!.layer.cornerRadius = 12
            toastView!.layer.masksToBounds = true
            registerForKeyboardNotificatoins()
        }
        
        /// Setup Message Label
        if statusLabel == nil {
            statusLabel                     = UILabel.init(frame : CGRect.zero)
            statusLabel!.font               = messageFont
            statusLabel!.textColor          = messageTextColor
            statusLabel!.backgroundColor    = UIColor.clear
            statusLabel!.textAlignment      = .center
            statusLabel!.baselineAdjustment = .alignCenters
            statusLabel!.numberOfLines      = 0
        }
        if statusLabel?.superview == nil {
            toastView?.contentView.addSubview(statusLabel!)
        }
        
        if toastView?.superview == nil {
            window!.addSubview(toastView!)
        }
        
        statusLabel?.text = statusMessage
        
        /// Setup ToastView Size & Position
        if statusMessage.count < 1 {
            return
        } else {
            setToastViewSize()
            setToastViewPosistion(notification: nil)
            showToastView()
            
            if completionHandler != nil {
                let myDelay = DispatchTime.now()+4
                DispatchQueue.main.asyncAfter(deadline: myDelay, execute: {
                    completionHandler!()
                })
            }
        }
    }
    
    
    // MARK: - Configure ToastView
    fileprivate func setToastViewSize() {
        let screen    : CGRect  = UIScreen.main.bounds
        var rectLabel : CGRect  = CGRect.zero
        let toastViewWidth  : CGFloat = (screen.size.width)-30
        
        if let statusMessage =  statusLabel?.text, statusMessage.count != 0 {
            
            let attributes = [NSAttributedStringKey.font: statusLabel?.font]
            let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
            rectLabel = (statusLabel?.text?.boundingRect(with: CGSize(width: toastViewWidth-10, height: 300),
                                                         options: options, attributes: attributes as [NSAttributedStringKey : AnyObject],
                                                         context: nil))!
            
            toastViewHeight = rectLabel.size.height + 18
            
            if toastViewHeight < 50 {
                toastViewHeight = 50
            }
            rectLabel.origin.x = (toastViewWidth - rectLabel.size.width) / 2
            rectLabel.origin.y = (toastViewHeight - rectLabel.size.height) / 2
        }
        
        toastView?.bounds    = CGRect(x  : 0, y  : 0, width  : toastViewWidth, height  : toastViewHeight)
        toastView?.center    = CGPoint(x : window!.center.x, y : (screen.size.height-(25+toastViewHeight)))
        statusLabel?.frame = rectLabel
    }
    
    
    // MARK: - ToastView Position
    @objc fileprivate func setToastViewPosistion(notification: NSNotification?) {
        var keyboardHeight: CGFloat = 0.0
        if notification?.name == .UIApplicationDidChangeStatusBarOrientation {
            setToastViewSize()
        }
        
        if notification != nil {
            if let keyboardFrame: NSValue = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                if (notification!.name == NSNotification.Name.UIKeyboardWillShow || notification!.name == NSNotification.Name.UIKeyboardDidShow) {
                    keyboardHeight    = keyboardRectangle.height
                }
            }
        } else {
            keyboardHeight = 0.0
        }
        let screen: CGRect = UIScreen.main.bounds
        let center: CGPoint = CGPoint(x: screen.size.width/2, y: (screen.size.height-keyboardHeight)-(25+toastViewHeight))
        
        UIView.animate(withDuration: 0, delay: 0, options: [.allowUserInteraction], animations: {
            self.toastView?.center = CGPoint(x: center.x, y: center.y)
        }, completion: nil)
    }
    
    
    // MARK: - Show
    fileprivate func showToastView() {
        if toastView != nil {
            toastView!.alpha = 0
            
            UIView.animate(withDuration:0.50 , delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.toastView?.alpha = 1
            }, completion: {(success) in
                self.hideToastView()
            })
        }
    }
    
    
    // MARK: - Hide
    fileprivate func hideToastView() {
        if toastView != nil && toastView?.alpha == 1 {
            
            UIView.animate(withDuration: 0.15, delay: 3, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.toastView?.alpha = 0
            }, completion: { (succes) in
                self.destroyToastView()
            })
        }
    }
    
    
    // MARK: - Deallocate ToastView
    fileprivate func destroyToastView() {
        NotificationCenter.default.removeObserver(self)
        statusLabel?.removeFromSuperview()
        statusLabel = nil
        toastView?.removeFromSuperview()
        toastView = nil
    }
    
    
    // MARK: - Keyboard Notifications
    func registerForKeyboardNotificatoins() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.setToastViewPosistion), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setToastViewPosistion), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setToastViewPosistion), name: .UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setToastViewPosistion), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setToastViewPosistion), name: .UIKeyboardDidShow, object: nil)
    }
    
    
    // MARK: - Customization Methods
    public static func messageFont(_ font: UIFont) {
        self.shared.messageFont = font
    }
    
    public static func messageTextColor(_ color: UIColor) {
        self.shared.messageTextColor = color
    }
    
    public static func backgroundStyle(_ backgroundStyle: UIBlurEffectStyle) {
        self.shared.toastViewBackgroundStyle = backgroundStyle
    }
}

