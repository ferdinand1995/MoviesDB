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
    private var pageCount: Int = 1
    private var allowedToFetchNewData: Bool = false
    private var title = String()
    
    func viewDidLoad() {
        view?.showMoviesData(moviesResult)
    }
    
    func searchMovies(_ title: String) {
        if self.title != title {
            pageCount = 1
        }
        self.title = title
        view?.showActivityIndicator()
        interactor?.searchMovies(page: String(pageCount), title: title)
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
    
    func validatePagination(index: IndexPath) {
        guard let searchItem = moviesResult?.search,
              index.row == searchItem.count - 1 else { return }
        allowedToFetchNewData = true
    }
    
    func paginateList() {
        guard allowedToFetchNewData else { return }
        pageCount += 1
        view?.showActivityIndicator()
        interactor?.searchMovies(page: String(pageCount), title: title)
    }
}

extension MoviesPresenter: MoviesInteractorOutput {
    func moviesFetched(_ movies: OMDBResult) {
        if allowedToFetchNewData {
            self.allowedToFetchNewData = false
            guard let searchItem = movies.search else { return }
            self.moviesResult?.search?.append(contentsOf: searchItem)
        } else {
            self.moviesResult = movies
        }
        view?.hideActivityIndicator()
        view?.showMoviesData(movies)
    }
    
    func moviesFetchFailed() {
        self.moviesResult = nil
        self.allowedToFetchNewData = false
        view?.hideActivityIndicator()
        view?.showMoviesData(moviesResult)
        view?.showErrorMessage()
    }
}
