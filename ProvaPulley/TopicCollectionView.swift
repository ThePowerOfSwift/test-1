//
//  TopicCollectionView.swift
//  BatChat
//
//  Created by Lorenzo Caso on 24/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class TopicCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    

    
   
    


}
