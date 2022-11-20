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
    private let imdbId: String
    init(_ imdbId: String) {
        self.imdbId = imdbId
    }
    
    func viewDidLoad() {
        interactor?.fetchMovieDetail(imdbId)
    }
    
    func popToListPage() {
        router?.popToListPage()
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutput {
    
    func moviesFetched(_ movies: OMDBResult) {
        self.moviesResult = movies
        view?.showMovieDetail(movies)
    }
    
    func showError(message: String) {
        view?.showError(message)
    }
}
