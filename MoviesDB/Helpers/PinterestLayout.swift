//
//  PinterestLayout.swift
//
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

public class PinterestLayout: UICollectionViewLayout {

    weak var delegate: PinterestLayoutDelegate?

    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8

    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    public override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            autoreleasepool {
                let indexPath = IndexPath(item: item, section: 0)

                let photoHeight = delegate?.collectionView(
                    collectionView: collectionView,
                    heightForPhotoAtIndexPath: indexPath) ?? 0
                let height = cellPadding * 2 + photoHeight
                let frame = CGRect(x: xOffset[column],
                    y: yOffset[column],
                    width: columnWidth,
                    height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height

                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
        }
    }

    public override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        for attributes in cache {
            autoreleasepool {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        return visibleLayoutAttributes
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    public override func invalidateLayout() {
        self.cache.removeAll()
        super.invalidateLayout()
    }
}
