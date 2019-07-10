//
//  PointAddingViewController.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit

class PointAddingViewController: UIViewController {

    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    
    
    
    var types:[String]=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.typeSelect.delegate = self
//        self.typeSelect.dataSource = self
        types=["Fontana","Statua","Monumento","Palazzo","Costruzione"]
        // Do any additional setup after loading the view.
    }
    var poi:PointOfInterest!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text=poi.title
        streetField.text=poi.locationName
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        do{
        poi.title=nameField.text!
        poi.locationName=streetField.text!
        /*
        poi.type=pickerView(typeSelect, titleForRow: typeSelect.selectedRow(inComponent: 1),forComponent: 1)
        }catch is NSException{
          */
        }
        
    }
    

    @IBAction func deleteAnnotation(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("deleteAnnotation"), object: nil)
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "deleteAnnotation":
            let dstview=segue.destination as! MapViewController
            dstview.location=poi
        default:
            print("ao")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return types[row]
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return types.count
    }


}
