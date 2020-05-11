//
//  InfoVC.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 11.05.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit
import WebKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class InfoVC: UIViewController {
let versionLbl = UILabel()
let aboutLbl = UILabel()
let  webViewFrame = WKWebView()
let indicator = UIActivityIndicatorView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        versionLabel()
        aboutLabel()
        webViewFrameCreate()
        indicatorCreate()
        
        DispatchQueue.global(qos: .utility).async {
            sleep(3)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
        }
    }
    
    func indicatorCreate() {
        indicator.startAnimating()
        indicator.style = .medium
        view.addSubview(indicator)
        
        indicator.layer.masksToBounds = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func webViewFrameCreate() {
        
        if let myURL = URL(string: "http://avsila.ru") {
                          let request = URLRequest(url: myURL)
                           webViewFrame.load(request)
                         }
        view.addSubview(webViewFrame)
        
        webViewFrame.layer.masksToBounds = true
        webViewFrame.translatesAutoresizingMaskIntoConstraints = false
        webViewFrame.topAnchor.constraint(equalTo: aboutLbl.bottomAnchor, constant: 20).isActive = true
        webViewFrame.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        webViewFrame.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        webViewFrame.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    
    func versionLabel() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
       // versionLbl.frame = CGRect(x: 20, y: 100, width: 200, height: 40)
        versionLbl.textColor = .black
        versionLbl.text = "Версия : " + appVersion!
        versionLbl.font = versionLbl.font.withSize(28)
        view.addSubview(versionLbl)
        
        versionLbl.layer.masksToBounds = true
        versionLbl.translatesAutoresizingMaskIntoConstraints = false
        versionLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        versionLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        versionLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        versionLbl.heightAnchor.constraint(equalToConstant: 40)
    }
    
    func aboutLabel() {
        aboutLbl.textColor = .systemGray
        aboutLbl.text = "Приложение не только позволит скоротать время но и разовьет внимательность, концетрацию. Особенно полезно детям любых возрастом от 5 лет. \nТаблица ШУЛЬТЕ - в 3-х вариациях. Простые с разными размерами до 8. Обратные. Двухцветные. \nТакже задание на память. Запомни где располагались цифры и нажми их по порядку."
        aboutLbl.numberOfLines = 0
        aboutLbl.font = versionLbl.font.withSize(17)
        view.addSubview(aboutLbl)
        
        aboutLbl.layer.masksToBounds = true
        aboutLbl.translatesAutoresizingMaskIntoConstraints = false
        aboutLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        aboutLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        aboutLbl.topAnchor.constraint(equalTo: versionLbl.bottomAnchor, constant: 20).isActive = true
        aboutLbl.heightAnchor.constraint(equalToConstant: 150)
        
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
