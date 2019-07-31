//
//  OplayerCollectionLayOut.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/25.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit

class OplayerCollectionLayOut: UICollectionViewFlowLayout {

    var opsectionInsets:UIEdgeInsets = UIEdgeInsets.zero
    var opminiLineSpace:CGFloat = 0
    var opminiInterItemSpace:CGFloat = 0
    var opeachItemSize:CGSize = .zero
    var scrollAnimation:Bool = true /**<是否有分页动画*/
    var lastOffset:CGPoint = .zero
    
    
    
    override init() {
        super.init()
        
    }
    
    convenience init(insets:UIEdgeInsets,miniLineSpace:CGFloat,miniInterItemSpace:CGFloat,itemSize:CGSize) {
        self.init()
        self.opsectionInsets = insets
        self.opminiLineSpace = miniLineSpace
        self.opminiInterItemSpace = miniInterItemSpace
        self.opeachItemSize = itemSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
        self.sectionInset = opsectionInsets
        self.minimumLineSpacing = opminiLineSpace
        self.minimumInteritemSpacing = opminiInterItemSpace
        self.itemSize = opeachItemSize
//        self.collectionView?.decelerationRate = .fast
    }
    
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        var proposedContentOffset = proposedContentOffset
//        let pageSpace = opeachItemSize.width // 步距
//        let offsetMax = self.collectionView?.contentSize.width ?? 0 - (pageSpace + self.sectionInset.right + self.minimumLineSpacing)
//        let offsetMin:CGFloat = 0.0
//        if lastOffset.x < offsetMin {
//            lastOffset.x = offsetMin
//        }else if (lastOffset.x > offsetMax){
//            lastOffset.x = offsetMax
//        }
//        let offsetForCurrentPointX = abs(proposedContentOffset.x - lastOffset.x)
//        let velocityX = velocity.x
//        let direction:Bool = (proposedContentOffset.x - lastOffset.x) > 0
//        if (offsetForCurrentPointX > pageSpace/8.0 && lastOffset.x >= offsetMin && lastOffset.x <= offsetMax){
//            var paheFactor = 0
//            if velocityX != 0 {
//                paheFactor = Int(abs(velocityX))
//            }else{
//                paheFactor = Int(abs(offsetForCurrentPointX/pageSpace))
//            }
//            paheFactor = paheFactor < 1 ? 1:(paheFactor < 3 ? 1:2)
//            let paheOffSetX = pageSpace * CGFloat(paheFactor)
//            proposedContentOffset = CGPoint(x: lastOffset.x + (direction ? paheOffSetX : -paheOffSetX ), y: proposedContentOffset.y)
//        }else{
//            proposedContentOffset = CGPoint(x: lastOffset.x, y: lastOffset.y)
//        }
//        lastOffset.x = proposedContentOffset.x
//        return proposedContentOffset
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let arr = self.getCopyOfAttributes(attributes: super.layoutAttributesForElements(in: rect))
        if self.scrollAnimation {
            let centerX = (self.collectionView?.contentOffset.x ?? 0) + (self.collectionView?.bounds.size.width ?? 0)/2.0
            for attributes in arr {
                let distance = abs(attributes.center.x - centerX)
                let apartScale = distance / (self.collectionView?.bounds.size.width ?? VIEW_WIDTH)
                let scale = fabs(cos(Double(apartScale) * Double.pi/2))
                var plane_3d = CATransform3DIdentity
                plane_3d = CATransform3DScale(plane_3d, 1, CGFloat(scale), 1)
                attributes.transform3D = plane_3d                
            }
        }
        return arr
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    
    func getCopyOfAttributes(attributes:Array<UICollectionViewLayoutAttributes>?) -> Array<UICollectionViewLayoutAttributes> {
        var copyArr = Array<UICollectionViewLayoutAttributes>()
        guard attributes != nil else {
            return copyArr
        }
        for attribute in attributes! {
            copyArr.append(attribute)
        }
        return copyArr
    }
}
