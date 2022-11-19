//
//  MovieDetailRouter.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

final class MovieDetailRouter: MovieDetailWireframe {

    weak var viewController: UIViewController?
    
    static func assembleModule(_ imdbId: String) -> UIViewController {
        let view = MovieDetailVC()
        let router = MovieDetailRouter()
//        let presenter = MovieDetailPresenter()
//        let interactor = MoviesInteractor()
        
        let navigation = UINavigationController(rootViewController: view)
        navigation.setNavigationBarHidden(true, animated: false)
        
//        view.presenter = presenter
        
//        presenter.view = view
//        presenter.interactor = interactor
//        presenter.router = router
        
//        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
}
