//
//  AdvVC.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 21.05.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AdvVC: UIViewController {

    @IBAction func close(_ sender: Any) {
        Model.shared.setSettings(switcherAdv: true)
           let mainPage = self.storyboard?.instantiateViewController(identifier: "navCV") as! UINavigationController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = mainPage
               
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
