//
//  MovieDetailVC.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import UIKit

class MovieDetailVC: UIViewController {

    /// Outlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var backgroundContentView: UIView!
    @IBOutlet private weak var movieBannerImageView: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieRating: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    @IBOutlet private weak var underlineView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
