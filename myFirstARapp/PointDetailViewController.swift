//
//  PointDetailViewController.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit

class PointDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var poi:PointOfInterest?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        nameLabel.text=poi?.title
        streetLabel.text=poi?.locationName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
