//
//  ViewConstraints.swift
//  MessageCell
//
//  Created on 2021/7/4.
//

import UIKit

extension UIView {
    
    @discardableResult
    func add(to superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func anchor(_ attribute: NSLayoutConstraint.Attribute,
                _ relation: NSLayoutConstraint.Relation = .equal,
                toItem: Any? = nil,
                itemAttribute: NSLayoutConstraint.Attribute,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relation,
                                            toItem: toItem,
                                            attribute: itemAttribute,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.isActive = true
        return self
    }
    
    // MARK: - NSLayoutAnchor
    @discardableResult
    func anchor<LayoutType: NSLayoutAnchor<AnchorType>, AnchorType> (
        _ keyPath: KeyPath<UIView, LayoutType>,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to anchor: LayoutType,
        constant: CGFloat = 0,
        multiplier: CGFloat? = nil,
        priority: UILayoutPriority = .required) -> Self {
        
        constraint(keyPath, relation, to: anchor, constant: constant, multiplier: multiplier, priority: priority)
        return self
    }
    
    @discardableResult
    func constraint
        <LayoutType: NSLayoutAnchor<AnchorType>, AnchorType>
        (_ keyPath: KeyPath<UIView, LayoutType>,
         _ relation: NSLayoutConstraint.Relation = .equal,
         to anchor: LayoutType,
         constant: CGFloat = 0,
         multiplier: CGFloat? = nil,
         priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        if let multiplier = multiplier,
            let dimension = self[keyPath: keyPath] as? NSLayoutDimension,
            let anchor = anchor as? NSLayoutDimension {
            
            switch relation {
            case .equal:
                constraint = dimension.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            case .greaterThanOrEqual:
                constraint = dimension.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            case .lessThanOrEqual:
                constraint = dimension.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            @unknown default:
                constraint = dimension.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            }
        } else {
            switch relation {
            case .equal:
                constraint = self[keyPath: keyPath].constraint(equalTo: anchor, constant: constant)
            case .greaterThanOrEqual:
                constraint = self[keyPath: keyPath].constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lessThanOrEqual:
                constraint = self[keyPath: keyPath].constraint(lessThanOrEqualTo: anchor, constant: constant)
            @unknown default:
            constraint = self[keyPath: keyPath].constraint(equalTo: anchor, constant: constant)
            }
        }
        translatesAutoresizingMaskIntoConstraints = false
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - NSLayoutDimension
    @discardableResult
    func anchor(_ anchor: KeyPath<UIView, NSLayoutDimension>,
                _ relation: NSLayoutConstraint.Relation = .equal,
                to constant: CGFloat,
                priority: UILayoutPriority = .required) -> Self {
        
        constraint(anchor, relation, to: constant, priority: priority)
        return self
    }
    
    @discardableResult
    func constraint(_ keyPath: KeyPath<UIView, NSLayoutDimension>,
                    _ relation: NSLayoutConstraint.Relation = .equal,
                    to constant: CGFloat = 0,
                    priority: UILayoutPriority) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self[keyPath: keyPath].constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            constraint = self[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            constraint = self[keyPath: keyPath].constraint(lessThanOrEqualToConstant: constant)
        @unknown default:
            constraint = self[keyPath: keyPath].constraint(equalToConstant: constant)
        }
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}


public extension NSObjectProtocol where Self: UIView {
    
    static func fromNib(named: String? = nil, index: Int = 0) -> Self {
        let named = named ?? "\(Self.self)"
        let nib = UINib(nibName: named, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[index] as? Self ?? Self()
    }
}

extension NSObject: ClassNameProtocol {}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension Array {
    typealias E = Element
    
    subscript(safe index: Int) -> E? {
        guard index >= 0, index < count else { return nil }
        let element = self[index]
        return element
    }
}
