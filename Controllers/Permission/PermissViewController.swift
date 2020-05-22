//
//  PermissViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/20/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class PermissViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var someProtocol = [String : Permission]()
    var permissions = [Permission]()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        collectionView.register(PermissionCollectionViewCell.nib, forCellWithReuseIdentifier: PermissionCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        Production.ACCESS_TOKEN = preferences.object(forKey: accessToken) as! String
        
        getData()
    }
    
    func getData() {
        MGConnection.requestDataList(APIRouter.getPermission, Permission.self,completion: {(result, error) in
            
            guard error == nil else {
                
                return
            }
            
            if let data = result {
                
                data.forEach { (value) in
                    self.someProtocol[value.appEntityCode] = value
                }
          
                for (key, value) in self.someProtocol {
                    print(key)
                    self.permissions.append(value)
                }
                
                self.collectionView.reloadData()
                return
            }
        })
    }
    
}

extension PermissViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return someProtocol.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PermissionCollectionViewCell.identifier, for: indexPath as IndexPath) as! PermissionCollectionViewCell
        cell.setData(data: permissions[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Lorry", bundle: Bundle.main).instantiateViewController(withIdentifier: "LorryListViewController") as? LorryListViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
         
    }
    
}

extension PermissViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 2.5
        
        let numberOfItemsPerRow: CGFloat = 2.0
        let itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        
        return CGSize(width: itemWidth, height: 40)
    }
}
