//
//  MoviesPresenter.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import Foundation

final class MovieDetailPresenter: MovieDetailPresentation {

    weak var view: MovieDetailView?
    var interactor: MovieDetailUseCase?
    var router: MovieDetailWireframe?
    
    private var moviesResult: OMDBResult?
    
    func viewDidLoad() {
        view?.showMovieDetail(moviesResult)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutput {
    func moviesFetched(_ movies: OMDBResult) {
        self.moviesResult = movies
        view?.showMovieDetail(movies)
    }
    
    func moviesFetchFailed() {
        self.moviesResult = nil
        view?.showMovieDetail(moviesResult)
        view?.showErrorMessage()
    }
}
