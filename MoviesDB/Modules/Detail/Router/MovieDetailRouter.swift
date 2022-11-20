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
        let presenter = MovieDetailPresenter(imdbId)
        let interactor = MovieDetailInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
    
    func popToListPage() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
