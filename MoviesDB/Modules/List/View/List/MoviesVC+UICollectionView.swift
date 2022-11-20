//
//  MoviesVC+UICollectionView.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

// MARK: CollectionView Data Source
extension MoviesVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.countMovies() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withClass: MovieContentCell.self, for: indexPath)
        guard let imageUrls = presenter?.getPoster(movie: indexPath) else { return cell }
        cell.confiCell(photoURL: imageUrls)
        return cell
    }
}

// MARK: CollectionView Delegate
extension MoviesVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.validatePagination(index: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(movie: indexPath)
    }

    private var isScrolledToBottomWithBuffer: Bool {
        let buffer = collectionView.bounds.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        let maxVisibleY = collectionView.contentOffset.y + self.collectionView.bounds.size.height
        let actualMaxY = collectionView.contentSize.height + collectionView.contentInset.bottom
        return maxVisibleY + buffer >= actualMaxY
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height != 0, isScrolledToBottomWithBuffer else { return }
        presenter?.paginateList()
    }

}

// MARK: Dynamic Height CollectionView
extension MoviesVC: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
    }
}


