//
//  ThemeManager.swift
//  ThemeManager
//
//  Created by 王要正 on 2019/6/15.
//  Copyright © 2019 王要正. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let ThemeDidChange = Notification.Name("ThemeDidChangeNotification")
}

public protocol Theme {}

open class ThemeManager<T: Theme> {

    open private(set) var theme: T {
        didSet {
            NotificationCenter.default.post(name: .ThemeDidChange, object: theme)
        }
    }

    public init(_ theme: T) {
        self.theme = theme
    }

    public var animationDuration: TimeInterval = 0.3
    private var internalAnimationBlock: ((@escaping () -> Void) -> Void)?
    open var animationBlock: (@escaping () -> Void) -> Void {
        set {
            internalAnimationBlock = newValue
        }
        get {
            if internalAnimationBlock == nil {
                internalAnimationBlock = {
                    UIView.animate(withDuration: self.animationDuration, animations: $0)
                }
            }

            return internalAnimationBlock!
        }
    }

    public struct ThemeItem {
        public typealias ApplyBlockType = (AnyObject, T) -> Void

        public private(set) weak var item: AnyObject?
        public private(set) var applyBlock: ApplyBlockType

        public init(item: AnyObject, applyBlock: @escaping ApplyBlockType) {
            self.item = item
            self.applyBlock = applyBlock
        }
    }

    private class DeallocObserver {
        var itemAddress: Int

        var itemDealloced: ((Int) -> Void)?

        deinit {
            itemDealloced?(itemAddress)
        }

        init(_ itemAddress: Int) {
            self.itemAddress = itemAddress
        }
    }

    private var managedItems = [Int: [ThemeItem]]()

    open func setup<OBJ: AnyObject>(_ item: OBJ?, applyBlock: @escaping (OBJ, T) -> Void) {
        guard let item = item else {
            return
        }

        let itemAddress = unsafeBitCast(item, to: Int.self)

        let itemDeallocObserver = DeallocObserver(itemAddress)
        itemDeallocObserver.itemDealloced = {
            self.managedItems.removeValue(forKey: $0)
        }
        objc_setAssociatedObject(item, "DeallocObserverKey", itemDeallocObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        let themeItem = ThemeItem(item: item) { (item, theme) in
            applyBlock(item as! OBJ, theme)
        }
        managedItems[itemAddress, default: []].append(themeItem)

        applyBlock(item, theme)
    }

    open func apply(_ theme: T, animated: Bool = true) {
        self.theme = theme
        managedItems.forEach { (_, items) in
            items.forEach { (themeItem) in
                guard let item = themeItem.item else {
                    return
                }

                if animated, let view = item as? UIView, view.window != nil {
                    self.animationBlock {
                        themeItem.applyBlock(item, theme)
                    }
                } else {
                    themeItem.applyBlock(item, theme)
                }
            }
        }
    }
}
