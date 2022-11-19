//
//  MoviesContract.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

protocol MoviesView: AnyObject {
    var presenter: MoviesPresentation? { get set }
        
    func showErrorMessage()
    func showMoviesData()
}

protocol MoviesPresentation: AnyObject {
    var view: MoviesView? { get set }
    var interactor: MoviesUseCase? { get set }
    var router: MoviesWireframe? { get set }
    
    func viewDidLoad()
    func countMovies() -> Int
    func getPoster(movie index: IndexPath) -> String
    func searchMovies(_ title: String)
    func didSelectSearchView()
    func didSelectMovie(_ imdbId: String)
}

protocol MoviesUseCase: AnyObject {
    var output: MoviesInteractorOutput? { get set }
       
    func searchMovies(page: String, title: String)
}

protocol MoviesInteractorOutput: AnyObject {
    func moviesFetched(_ movies: OMDBResult)
    func moviesFetchFailed()
}

protocol MoviesWireframe: AnyObject {
    var viewController: UIViewController? { get set }
        
    func presentDetails(forMovie movie: OMDBResult)
    static func assembleModule() -> UIViewController
}
