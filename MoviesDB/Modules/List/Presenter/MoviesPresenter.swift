//
//  MoviesPresenter.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import Foundation

final class MoviesPresenter: MoviesPresentation {

    weak var view: MoviesView?
    var interactor: MoviesUseCase?
    var router: MoviesWireframe?
    
    private var moviesResult: OMDBResult?
    private var index: Int = 1
    
    func viewDidLoad() {
        view?.showMoviesData(moviesResult)
    }
    
    func searchMovies(_ title: String) {
        interactor?.searchMovies(page: String(index), title: title)
    }
    
    func countMovies() -> Int {
        guard let count = moviesResult?.search?.count else { return 0 }
        return count
    }
    
    func getPoster(movie index: IndexPath) -> String {
        guard let poster = moviesResult?.search?[index.item].poster else { return "" }
        return poster
    }
    
    func didSelect(movie index: IndexPath) {
        guard let imdbId = moviesResult?.search?[index.item].imdbID else { return }
        router?.presentDetails(movie: imdbId)
    }
}

extension MoviesPresenter: MoviesInteractorOutput {
    func moviesFetched(_ movies: OMDBResult) {
        self.moviesResult = movies
        view?.showMoviesData(movies)
    }
    
    func moviesFetchFailed() {
        self.moviesResult = nil
        view?.showMoviesData(moviesResult)
        view?.showErrorMessage()
    }
}
