//
//  model.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 21.05.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import Foundation
import UIKit

class Model: NSObject {
    var resultAlbums: [albums] = []
    var resultImage : [UIImage] = []
    
    
static let shared = Model()
    var advertImages = ["kvadrat","kvadrat","kvadrat"]
    var advertText = ["Текст для первого рекламного блока на белом фонеЮ будем рассказывать как для чего это все нужно ","Про обратные задания и так далее как важно постоянно тернироваться и на что это влияетт взять со страницы в интернете","самое сложное заджанеие- цифровая обезяна  - обезьяна возможно вставить видео о том как проверяют обеезьян"]
    
    struct albums {
        var collectionName: String //new
        var artworkUrl100: String //new
        
        init(dictionary:Dictionary<String, Any>) {
            collectionName = dictionary["collectionName"] as? String ?? ""
            artworkUrl100 = dictionary["artworkUrl100"] as? String ?? ""
        }
    }
    
    
    func setSettings(switcherAdv: Bool) {
             UserDefaults.standard.set(switcherAdv, forKey: "showAdv" )
             UserDefaults.standard.synchronize()
         }
       
    func getSettings() -> (Bool) {//получаем настройки
             print("\(UserDefaults.standard.bool(forKey: "showAdv"))")
             return (UserDefaults.standard.bool(forKey: "showAdv"))
             
         }
}
