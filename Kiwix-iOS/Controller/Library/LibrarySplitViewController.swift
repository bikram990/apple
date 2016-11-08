//
//  LibrarySplitViewController.swift
//  Kiwix
//
//  Created by Chris Li on 8/17/16.
//  Copyright © 2016 Chris. All rights reserved.
//

import UIKit

class LibrarySplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
        minimumPrimaryColumnWidth = 320.0
        delegate = self
        
        configureDismissButton()
    }
    
    func configureDismissButton() {
        guard let master = viewControllers.first as? UINavigationController else {return}
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "Cross"), style: .plain, target: self, action: #selector(dismiss(sender:)))
        master.topViewController?.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func dismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        let secondaryTopController = (secondaryViewController as? UINavigationController)?.topViewController
        if let _ = secondaryTopController as? LanguageFilterController {
            return false
        } else if (secondaryTopController as? BookDetailController)?.book != nil {
            return false
        } else {
            return true
        }
    }
    
    var isShowingLangFilter: Bool {
        return ((viewControllers[safe: 1] as? UINavigationController)?.topViewController is LanguageFilterController)
    }
}
