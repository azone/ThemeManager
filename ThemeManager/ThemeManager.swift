//
//  ThemeManager.swift
//  ThemeManager
//
//  Created by 王要正 on 2019/6/15.
//  Copyright © 2019 王要正. All rights reserved.
//

import UIKit

public protocol Theme {}

open class ThemeManager<T: Theme> {
    private var theme: T

    public init(_ theme: T) {
        self.theme = theme
    }

    public var animationDuration: TimeInterval = 0.3

    public struct ThemeItem {
        public typealias ApplyBlockType = (UIView, T) -> Void

        public private(set) weak var view: UIView?
        public private(set) var applyBlock: ApplyBlockType

        public init(view: UIView, applyBlock: @escaping ApplyBlockType) {
            self.view = view
            self.applyBlock = applyBlock
        }
    }

    private class DeallocObserver {
        var viewAddress: Int

        var viewDealloced: ((Int) -> Void)?

        deinit {
            viewDealloced?(viewAddress)
        }

        init(_ viewAddress: Int) {
            self.viewAddress = viewAddress
        }
    }

    private var managedItems = [Int: [ThemeItem]]()

    open func setup<V: UIView>(_ view: V, applyBlock: @escaping (V, T) -> Void) {
        let viewAddress = unsafeBitCast(view, to: Int.self)

        let viewDeallocObserver = DeallocObserver(viewAddress)
        viewDeallocObserver.viewDealloced = {
            self.managedItems.removeValue(forKey: $0)
        }
        objc_setAssociatedObject(view, "DeallocObserverKey", viewDeallocObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        let themeItem = ThemeItem(view: view) { (view, theme) in
            applyBlock(view as! V, theme)
        }
        managedItems[viewAddress, default: []].append(themeItem)

        applyBlock(view, theme)
    }

    open func apply(_ theme: T, animated: Bool = true) {
        self.theme = theme
        managedItems.forEach { (_, items) in
            items.forEach { (themeItem) in
                guard let view = themeItem.view else {
                    return
                }

                if animated && view.window != nil {
                    UIView.animate(withDuration: animationDuration) {
                        themeItem.applyBlock(view, theme)
                    }
                } else {
                    themeItem.applyBlock(view, theme)
                }
            }
        }
    }
}
