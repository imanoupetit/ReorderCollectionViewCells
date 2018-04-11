//
//  ViewController.swift
//  ReorderCollectionAndPages
//
//  Created by Imanou on 10/04/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    
    let collectionDataSource = CollectionDataSource(model: Model())
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reorder cells"
        installsStandardGestureForInteractiveMovement = false

        guard let collectionView = collectionView else { fatalError() }
        collectionView.collectionViewLayout = ReordableLayout()
        collectionView.dataSource = collectionDataSource
        collectionView.allowsMultipleSelection = true
    }
        
}
