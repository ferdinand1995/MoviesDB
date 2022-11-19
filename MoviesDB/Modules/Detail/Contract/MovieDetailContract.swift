//
//  MovieDetailContract.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

protocol MovieDetailView: AnyObject {
    var presenter: MovieDetailPresentation? { get set }
        
    func showErrorMessage()
    func showMovieDetail(_ movies: OMDBResult?)
}

protocol MovieDetailPresentation: AnyObject {
    var view: MovieDetailView? { get set }
    var interactor: MovieDetailUseCase? { get set }
    var router: MovieDetailWireframe? { get set }
    
    func viewDidLoad()
}

protocol MovieDetailUseCase: AnyObject {
    var output: MovieDetailInteractorOutput? { get set }
       
    func fetchMovieDetail(imdbId: String)
}

protocol MovieDetailInteractorOutput: AnyObject {
    func moviesFetched(_ movies: OMDBResult)
    func moviesFetchFailed()
}

protocol MovieDetailWireframe: AnyObject {
    var viewController: UIViewController? { get set }

    static func assembleModule(_ imdbId: String) -> UIViewController
}
