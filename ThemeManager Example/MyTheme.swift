//
//  MyTheme.swift
//  ThemeManager Example
//
//  Created by 王要正 on 2019/6/15.
//  Copyright © 2019 王要正. All rights reserved.
//

import UIKit
import ThemeManager

struct MyTheme: Theme {
    var backgroundColor = UIColor.gray
    var mainColor = UIColor.orange

    var titleFont = UIFont.preferredFont(forTextStyle: .headline)
    var subtitleFont = UIFont.preferredFont(forTextStyle: .subheadline)
    var textColor = UIColor.red

    var buttonTitleColor = UIColor.orange
    var buttonTitleHighlightcolor = UIColor.red
}
