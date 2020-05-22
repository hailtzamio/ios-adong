//
//  UpdateViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
class UpdateViewController: BaseViewController {
    
    @IBOutlet weak var header: NavigationBar!
    var data:Lorry? = nil
    var isUpdate = true // if false Create
    @IBOutlet weak var tfBrand: RadiusTextField!
    @IBOutlet weak var tfCapacity: RadiusTextField!
    @IBOutlet weak var tfPlateNumber: RadiusTextField!
    @IBOutlet weak var tfModel: RadiusTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupHeader()
  
        if(data != nil) {
            tfBrand.text = data?.brand
            tfCapacity.text = data?.capacity
            tfPlateNumber.text = data?.plateNumber
            tfModel.text = data?.model
        }
    }
    
    
    func setupHeader() {
        header.title = "Cập Nhật"
        if(!isUpdate) {
            header.title = "Tạo Mới"
        }
        
        header.leftAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        header.isRightButtonHide = true
    }
    
    func checkValidate() {
        if ( tfBrand.text == "" || tfCapacity.text == "" || tfPlateNumber.text == "" || tfModel.text == "") {
            showToast(content: "Nhập thiếu thông tin")
            return
        }
    }
    
    @IBAction func createOrUpdate(_ sender: Any) {
        
        if ( tfBrand.text == "" || tfCapacity.text == "" || tfPlateNumber.text == "" || tfModel.text == "") {
            showToast(content: "Nhập thiếu thông tin")
            return
        }
        
        let dataRq = Lorry()
        dataRq.brand = tfBrand.text
        dataRq.model = tfModel.text
        dataRq.plateNumber = tfPlateNumber.text
        dataRq.capacity = tfCapacity.text
        
        if(isUpdate) {
            // Update
            dataRq.id = data?.id
            update(data: dataRq)
        } else {
            // Create
            create(data: dataRq)
        }
    }
    
    func update(data:Lorry) {
        showLoading()
        let parameters = [
            "brand": data.brand,
            "model": data.model,
            "plateNumber": data.plateNumber,
            "capacity": data.capacity
        ]
        
        let url = Production.BASE_URL +  "lorry/\(data.id!)"
        ServiceFactory.put(url: url, parameters: parameters as Parameters) { response in
            self.stopLoading()
            if response.result.isSuccess {
                if let res = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    
                    if(res.status == 1) {
                        self.goBack()
                        print("Thành công")
                    }
                }
            } else {
                print("Không thành công")
            }
        }
    }
    
    
    
    func create(data:Lorry) {
        showLoading()
        let parameters = [
            "brand": data.brand,
            "model": data.model,
            "plateNumber": data.plateNumber,
            "capacity": data.capacity
        ]
        
        let url = Production.BASE_URL +  "lorry"
        ServiceFactory.post(url: url, parameters: parameters as Parameters) { response in
            self.stopLoading()
            if response.result.isSuccess {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if( serverResponse.status == 1) {
                        self.goBack()
                        print("Thành công")
                    }
                }
            } else {
                print("Không thành công")
            }
        }
    }
}
