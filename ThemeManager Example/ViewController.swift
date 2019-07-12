//
//  ViewController.swift
//  ThemeManager Example
//
//  Created by 王要正 on 2019/6/15.
//  Copyright © 2019 王要正. All rights reserved.
//

import UIKit
import ThemeManager

class ViewController: UIViewController {

    @IBOutlet weak var mainColorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var defaultThemeButton: UIButton!
    @IBOutlet weak var theme1Button: UIButton!
    @IBOutlet weak var theme2Button: UIButton!

    var withAnimation = true


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)

        themeManager.setup(view) { (view, theme) in
            view.backgroundColor = theme.backgroundColor
        }

        themeManager.setup(mainColorLabel) { (label, theme) in
            label.textColor = theme.mainColor
        }

        themeManager.setup(titleLabel) { (label, theme) in
            label.textColor = theme.textColor
            label.font = theme.titleFont
        }

        themeManager.setup(subtitleLabel) { (label, theme) in
            label.textColor = theme.textColor
            label.font = theme.subtitleFont
        }

        themeManager.setup(defaultThemeButton) { (button, theme) in
            button.setTitleColor(theme.buttonTitleColor, for: .normal)
            button.setTitleColor(theme.buttonTitleHighlightcolor, for: .highlighted)
        }

        themeManager.setup(theme1Button) { (button, theme) in
            button.setTitleColor(theme.buttonTitleColor, for: .normal)
            button.setTitleColor(theme.buttonTitleHighlightcolor, for: .highlighted)
        }

        themeManager.setup(theme2Button) { (button, theme) in
            button.setTitleColor(theme.buttonTitleColor, for: .normal)
            button.setTitleColor(theme.buttonTitleHighlightcolor, for: .highlighted)
        }

        themeManager.setup(navigationItem) { (item, theme) in
            item.title = theme.title
        }

        themeManager.setup(navigationController?.navigationBar) { (bar, theme) in
            bar.tintColor = theme.mainColor
            bar.barTintColor = theme.backgroundColor
        }
    }

    @IBAction func changeToDefaultTheme(_ sender: Any) {
        themeManager.apply(MyTheme(), animated: withAnimation)
    }

    @IBAction func changeToTheme1(_ sender: Any) {
        var theme = MyTheme()
        theme.backgroundColor = .red
        theme.buttonTitleColor = .green
        theme.buttonTitleHighlightcolor = .purple
        theme.mainColor = .blue
        theme.subtitleFont = .systemFont(ofSize: 12)
        theme.titleFont = .boldSystemFont(ofSize: 24)
        theme.textColor = .blue
        theme.title = "Theme 1"
        theme.barTintColor = .orange
        themeManager.apply(theme, animated: withAnimation)

    }

    @IBAction func changeTheme2(_ sender: Any) {
        var theme = MyTheme()
        theme.backgroundColor = .blue
        theme.buttonTitleColor = .red
        theme.buttonTitleHighlightcolor = .yellow
        theme.mainColor = .darkText
        theme.subtitleFont = .systemFont(ofSize: 24)
        theme.titleFont = .boldSystemFont(ofSize: 36)
        theme.textColor = .green
        theme.title = "Theme 2"
        theme.barTintColor = .brown
        themeManager.apply(theme, animated: withAnimation)
    }

    @IBAction func switched(_ sender: UISwitch) {
        withAnimation = sender.isOn
    }
}

