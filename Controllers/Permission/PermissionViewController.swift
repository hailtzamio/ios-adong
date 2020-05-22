//
//  PermissionViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/20/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class PermissionViewController: UINavigationController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    override func viewDidLoad() {
        super.viewDidLoad()

//     collectionView.dataSource = self
//     collectionView.delegate = self
    }

}

extension PermissionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PermissionCollectionViewCell.identifier, for: indexPath as IndexPath) as! PermissionCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print(indexPath.item + 1)
        let vc = UIStoryboard.init(name: "Lorry", bundle: Bundle.main).instantiateViewController(withIdentifier: "LorryListViewController") as? LorryListViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        navigationController?.pushViewController(vc!, animated: true)
       }
    
}
