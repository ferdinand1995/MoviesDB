//
//  MoviesInteractor.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import Foundation

final class MovieDetailInteractor: MoviesUseCase {
    
    weak var output: MovieDetailInteractorOutput?
    private let networkManager: NetworkManager

    init() {
        self.networkManager = NetworkManager()
    }
    
    func searchMovies(page: String, title: String) {
        networkManager.fetchSearchMovies(page: page, title: title) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                guard let responseMessage = response.response else {
                    strongSelf.output?.moviesFetchFailed()
                    return
                }
                if responseMessage.lowercased().contains("false") {
                    strongSelf.output?.moviesFetchFailed()
                } else {
                    strongSelf.output?.moviesFetched(response)
                }
            case .failure(_):
                strongSelf.output?.moviesFetchFailed()
            }
        }
    }
    
}
