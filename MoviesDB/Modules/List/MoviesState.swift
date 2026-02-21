//
//  MoviesState.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 21/02/26.
//

import Foundation

struct Movie: Identifiable, Hashable {
    private(set) var id: UUID = .init()
    var title: String
    var posterURL: String
}

struct MoviesState: Equatable, Sendable {
    var movies: [Movie] = [
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
        .init(title: "Trying", posterURL: "https://m.media-amazon.com/images/M/MV5BMzdhZTBlZTgtOGRlNC00ZGVmLWI0NjYtNzljMWE0YzM3Nzg2XkEyXkFqcGc@._V1_SX300.jpg"),
    ]
    var isLoading: Bool = false
    var errorMessage: String? = nil
}
