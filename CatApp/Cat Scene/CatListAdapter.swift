//
//  CatListAdapter.swift
//  CatApp
//
//  Created by Henrique Lima on 26/11/19.
//  Copyright © 2019 Henrique Lima. All rights reserved.
//

import UIKit

class CatListAdapter: NSObject {
    var dataSource: [URL] = []
    var collectionView: UICollectionView
    let spacing: CGFloat = 24.0
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = spacing
        layout?.minimumInteritemSpacing = spacing
    }
    
    func setData(_ data: [URL]) {
        dataSource = data
        collectionView.reloadData()
    }
}

/// MARK: DataSource
extension CatListAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! CatCollectionViewCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}

/// MARK: Flow Layout Delegate
extension CatListAdapter: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - spacing)/2
        return CGSize(width: itemSize, height: itemSize)
     }
}

/// MARK: Prefetching Data Source
extension CatListAdapter: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // TODO: Prefetch images to improve performance
    }
}


