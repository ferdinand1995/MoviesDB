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
        //        return vm.photosResult.count
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: MovieContentCell.self, for: indexPath)
//        guard let imageUrls = vm.photosResult[indexPath.row].urls?.smallS3 else { return cell }
//        guard let color = vm.photosResult[indexPath.row].color else { return cell }
//        cell.confiCell(photoURL: imageUrls, color: color)
        return cell
    }
}

// MARK: CollectionView Delegate
extension MoviesVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

//        guard indexPath.row == self.vm.photosResult.count - 1 else { return }
//        vm.fetchListPhotos()
    }
}

// MARK: Dynamic Height CollectionView
extension MoviesVC: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
//        guard let width = vm.photosResult[indexPath.item].width else { return .zero }
//        let height = (vm.photosResult[indexPath.item].height ?? 400) / (width / 400)
//        return CGFloat(height)
        return 0
    }
}


