//
//  MoviesRouter.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

final class MoviesRouter: MoviesWireframe {

    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = MoviesVC()
        let router = MoviesRouter()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        
        let navigation = UINavigationController(rootViewController: view)
        navigation.setNavigationBarHidden(true, animated: false)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    func presentDetails(forMovie movie: OMDBResult) {
        
    }
}
