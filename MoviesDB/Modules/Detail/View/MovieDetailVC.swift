//
//  MovieDetailVC.swift
//  MoviesDB
//
//  Created by Ferdinand on 19/11/22.
//

import UIKit
import SDWebImage

class MovieDetailVC: UIViewController {

    /// Outlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var backgroundContentView: UIView!
    @IBOutlet private weak var movieBannerImageView: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    var presenter: MovieDetailPresentation?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initView()
    }
    
    private func initView() {
        self.view.backgroundColor = UIColor.brokenWhiteDarkMode
        self.backgroundContentView.backgroundColor = UIColor.brokenWhiteDarkMode
        self.movieTitle.text = nil
        self.movieTitle.textColor = UIColor.softBlackDarkMode
        self.movieGenre.text = nil
        self.movieGenre.textColor = UIColor.softBlackDarkMode
        self.movieReleaseDate.text = nil
        self.movieReleaseDate.textColor = UIColor.softBlackDarkMode
        self.movieDescription.text = nil
        self.movieDescription.textColor = UIColor.softBlackDarkMode
        self.underlineView.backgroundColor = UIColor.darkGrayDarkMode
        self.backButton.setImage(UIImage(named: "ic_back")?.withColor(UIColor.softBlackDarkMode), for: .normal)
        self.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        presenter?.popToListPage()
    }
}

extension MovieDetailVC: MovieDetailView {
    
    func showError(_ message: String) {
        let errorTitle: String = message.lowercased().contains("Incorrect IMDb ID") ? "Warning": "Error"
        let alertController = UIAlertController(title: errorTitle, message: message)
        self.present(alertController, animated: true)
    }
    
    func showMovieDetail(_ movies: OMDBResult?) {
        movieTitle.text = movies?.title
        movieGenre.text = movies?.genre
        movieReleaseDate.text = movies?.released
        let directorText: String = "Director:" + (movies?.director ?? "")
        let writerText: String = "Writer:" + (movies?.writer ?? "")
        let actorText: String = "Actors:" + (movies?.actors ?? "")
        let descriptionText: String =  directorText + "\n" + writerText + "\n" + actorText + "\n\n" + (movies?.plot ?? "")
        movieDescription.text = descriptionText
        
        guard let poster = movies?.poster,
              let url = URL(string: poster)
        else { return }
        movieBannerImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        movieBannerImageView.sd_imageIndicator?.startAnimatingIndicator()

        SDWebImageManager.shared.loadImage(
            with: url,
            options: [.scaleDownLargeImages, .continueInBackground, .lowPriority],
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, imageURL) in
                guard let strongSelf = self else { return }
                guard error == nil else { return }
                guard let image = image else { return }
                DispatchQueue.main.async {
                    strongSelf.movieBannerImageView.image = image
                    strongSelf.view.layoutSubviews()
                    strongSelf.movieBannerImageView.sd_imageIndicator?.stopAnimatingIndicator()
                    strongSelf.movieBannerImageView.addBorderGradients()
                }
            })
    }
    
    
}
