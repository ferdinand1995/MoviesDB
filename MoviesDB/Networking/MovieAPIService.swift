//
//  MovieAPIService.swift
//  
//
//  Created by Ferdinand on 18/11/22.
//

import Moya

enum MovieAPIService {
    case searchMovies(page: String, title: String)
}

extension MovieAPIService: TargetType {
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "OMDB-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'OMDB-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'OMDB-Info.plist'.")
            }
            return value
        }
    }

    var baseURL: URL {
        guard let url = URL(string: "http://www.omdbapi.com") else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .searchMovies(_, _):
            return "/"
        }
    }

    var method: Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .searchMovies(page, title):
            return .requestParameters(parameters: [
                "apikey": apiKey,
                "per_page": page,
                "s": title
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
