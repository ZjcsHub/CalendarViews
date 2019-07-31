//
//  CalendarCollectionView.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/25.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit

class CalendarCollectionView: UICollectionView {

   
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        super.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        self.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)

    }
    
    override func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        super.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
}
