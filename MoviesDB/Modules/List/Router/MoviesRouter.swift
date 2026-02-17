//
//  MoviesRouter.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

final class MoviesRouter: @MainActor MoviesWireframe {

    weak var viewController: UIViewController?
    
    @MainActor static func assembleModule() -> UIViewController {
        let view = MoviesVC()
        let router = MoviesRouter()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        
        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.isHidden = true
        
        view.presenter = presenter
        
//        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    @MainActor func presentDetails(movie imdbId: String) {
        let detailsModuleViewController = MovieDetailRouter.assembleModule(imdbId)
        viewController?.navigationController?.pushViewController(detailsModuleViewController, animated: true)
    }
}
