//
//  NetworkManager.swift
//  
//
//  Created by Ferdinand on 18/11/22.
//

import Moya

enum NetworkClientError: Error {
    case clientSideError(statusCode: Int, errorMessage: String)
    case serverSideError(statusCode: Int, errorMessage: String)
    case undefinedError
  }

// MARK: register network services
protocol Networkable {
    var provider: MoyaProvider<MovieAPIService> { get }
    func fetchSearchMovies(page: String, title: String, completion: @escaping (Result<OMDBResult, NetworkClientError>) -> ())
}

final class NetworkManager: Networkable {
    var provider = MoyaProvider<MovieAPIService>(plugins: [NetworkLoggerPlugin()])
    
    func fetchSearchMovies(page: String, title: String, completion: @escaping (Result<OMDBResult, NetworkClientError>) -> ()) {
        request(target: .searchMovies(page: page, title: title), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: MovieAPIService, completion: @escaping (Result<T, NetworkClientError>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(self.handleErrorResponse(response)))
                    return
                }
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(NetworkClientError.undefinedError))
                }
            case let .failure(error):
                guard let response = error.response else { return }
                completion(.failure(self.handleErrorResponse(response)))
            }
        }
    }

    func handleErrorResponse(_ r: Response) -> NetworkClientError {
        switch r.statusCode {
        case 400...499:
            return NetworkClientError.clientSideError(statusCode: r.statusCode, errorMessage: "Invalid Access")
        case 500...503:
            return NetworkClientError.serverSideError(statusCode: r.statusCode, errorMessage: "Something went wrong!")
        default:
            return NetworkClientError.undefinedError
        }
    }
}
