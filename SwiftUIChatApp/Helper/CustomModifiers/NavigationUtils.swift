//
//  NavigationUtils.swift
//  GETTR
//
//  Created by Manish Mishra on 06/05/23.
//

import Foundation
import SwiftUI

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(
            viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}
