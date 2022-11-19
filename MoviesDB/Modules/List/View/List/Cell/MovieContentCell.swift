//
//  PhotoContentCell.swift
//
//
//  Created by Ferdinand on 18/11/22.
//

import Foundation
import SDWebImage
import SnapKit

class MovieContentCell: UICollectionViewCell {

    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.sd_cancelCurrentImageLoad()
        contentImageView.image = nil
    }

    // MARK: Initialize
    private func initCell() {
        contentView.backgroundColor = .brokenWhiteDarkMode
        containerView.addSubview(contentImageView)
        contentView.addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: Public Interface
    func confiCell(photoURL: String) {
        /// - NOTE: Init UI
        guard let url = URL(string: photoURL) else { return }
        contentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        contentImageView.sd_imageIndicator?.startAnimatingIndicator()

        SDWebImageManager.shared.loadImage(
            with: url,
            options: [.scaleDownLargeImages, .continueInBackground, .lowPriority],
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, imageURL) in
                guard let strongSelf = self else { return }
                guard error == nil else { return }
                guard let image = image else { return }
                DispatchQueue.main.async {
                    strongSelf.contentImageView.image = image
                    strongSelf.layoutSubviews()
                    strongSelf.contentImageView.sd_imageIndicator?.stopAnimatingIndicator()
                }
            })
    }


}
