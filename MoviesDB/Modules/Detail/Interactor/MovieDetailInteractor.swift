//
//  MoviesInteractor.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import Foundation

final class MovieDetailInteractor: MovieDetailUseCase {

    weak var output: MovieDetailInteractorOutput?
    private let networkManager: NetworkManager

    init() {
        self.networkManager = NetworkManager()
    }

    func fetchMovieDetail(_ imdbId: String) {
        networkManager.fetchMovie(by: imdbId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                guard let responseMessage = response.response else {
                    strongSelf.output?.showError(message: "Something when wrong!")
                    return
                }
                if responseMessage.lowercased().contains("false") {
                    strongSelf.output?.showError(message: response.error ?? "Something when wrong!")
                } else {
                    strongSelf.output?.moviesFetched(response)
                }
            case .failure(let error):
                strongSelf.output?.showError(message: error.localizedDescription)
            }
        }
    }

}
