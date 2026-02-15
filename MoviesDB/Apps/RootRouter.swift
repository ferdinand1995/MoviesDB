//
//  RootRouter.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

protocol RootWireframe: AnyObject {
    func presentMainScreen(in window: UIWindow)
}

final class RootRouter: @MainActor RootWireframe {
    
    @MainActor func presentMainScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = MoviesRouter.assembleModule()
    }
}
