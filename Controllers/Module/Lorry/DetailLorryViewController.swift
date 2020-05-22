//
//  DetailLorryViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class DetailLorryViewController: BaseViewController {
    var id = 0
    var item:Lorry? = nil
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var header: NavigationBar!
    var data = [Information]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        popupHandle() 
        tbView.dataSource = self
        tbView.delegate = self
        tbView.register(InformationDetailCell.nib, forCellReuseIdentifier: InformationDetailCell.identifier)
        
        getData()
    }
    
    func setupHeader() {
        header.title = "Chi Tiết"
        header.leftAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        header.rightAction = {
            if let vc = UIStoryboard.init(name: "Lorry", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateViewController") as? UpdateViewController {
                vc.data = self.item
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        header.changeUpdateIcon()
    }
    
    func popupHandle() {
        
        okAction = { [weak self] in
            
            self?.showLoading()
            MGConnection.requestRemove(APIRouter.renoveLorry(id: self!.id), ResponseDefault.self,completion: {(result, error) in
                self?.stopLoading()
                guard error == nil else {
                    
                    return
                }
                
                if let value = result {
                    print(value.message)
                    self?.showToast(content: "Xóa thành công")
                    self?.goBack()
                    return
                }
            })
        }
    }
    
    func getData() {
        showLoading()
        MGConnection.request(APIRouter.getLorryById(id: id), Lorry.self,completion: {(result, error) in
            self.stopLoading()
            guard error == nil else {
                
                return
            }
            
            if let value = result {
                self.item = value
                self.data.append(Information(pKey: "Thương hiệu",pValue: value.brand!))
                self.data.append(Information(pKey: "Model",pValue: value.model!))
                self.data.append(Information(pKey: "Biển số xe",pValue: value.plateNumber!))
                self.data.append(Information(pKey: "Trọng tải",pValue: value.capacity!))
                self.tbView.reloadData()
                return
            }
        })
    }
    
    
    
    @IBAction func remove(_ sender: Any) {
        showYesNoPopup(title: "Xóa", message: "Chắc chắn xóa?")
    }
}

extension DetailLorryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InformationDetailCell.identifier, for: indexPath) as! InformationDetailCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}
