//
//  ZoomAndSnapFlowLayout.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

final class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Private Properties
    
    private let activeDistance: CGFloat = 100
    private let zoomFactor: CGFloat = 0.8
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        let cvHeight = collectionView.frame.height
        let cvWidth = collectionView.frame.width
        let cvTopInset = collectionView.adjustedContentInset.top
        let cvRightInset = collectionView.adjustedContentInset.right
        let cvLeftInset = collectionView.adjustedContentInset.left - itemSize.width
        let cvBottomInset = collectionView.adjustedContentInset.bottom - itemSize.height
        let verticalInsets = (cvHeight - cvTopInset - cvBottomInset) / 2
        let horizontalInsets = (cvWidth - cvRightInset - cvLeftInset) / 2
        
        sectionInset = UIEdgeInsets(
            top: verticalInsets,
            left: horizontalInsets,
            bottom: verticalInsets,
            right: horizontalInsets
        )
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super
            .layoutAttributesForElements(in: rect)!
            .map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }
        return rectAttributes
    }
    
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
        
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}
