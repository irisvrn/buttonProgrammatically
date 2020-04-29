//
//  ViewController.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 03/10/2019.
//  Copyright © 2019 Eugene Izotov. All rights reserved.
//

import UIKit
import AVFoundation // необходимо для проигрывания звука

//var audioPlayer:AVAudioPlayer?
var audioPlayer:AVAudioPlayer!
var timer:Timer?
var sec:Int = 0
var mmsec:Double = 0



class ViewController: UIViewController {
    var selStr = String()
    var digit = [String]()
    var stackView = UIStackView()
    var countGlobal = Int()
    var lastPressed = Int()
    var totalError = 0
    var selectedTaskIndex = String()
    var digitsColor = String()
    var digitsDirection = Bool()
    var intDirection: Int {
        if digitsDirection {
            return 1
        } else {
            return -1
        }
    }
    var totalPressed: Int = 0
    /* https://shkolabuduschego.ru/school/diagnostika-vnimaniya-shkolnikov-s-pomoshhyu-tablits.html */
    //таблицы Шульте
 // присотанавливать таймер ПАУЗА если больше 5 минут - человек ушел
// при переворачивании пересчитывать constraints viewstack
    //легкий режим с подсветкой после третьего раза
    //режим для алфавита)))
    //красный белый
    //обезьяна
    //
    
    
    
    @IBAction func resstartButton(_ sender: Any) {
        stackView = UIStackView() //обнуление stackView
              generateDigitArray(countDigitArray: countGlobal)
              configureStackView(numberOfBut: countGlobal)
              timer?.invalidate()
              mmsec = 0
              timeLbl.text = String(format:"%.2f",mmsec)
        if intDirection == 1 {
            lastPressed = 0
        } else {
            lastPressed = Int(countGlobal*countGlobal) + 1
        }
              
              playSound(playSound: "restart")
              totalPressed = 0
    }
    
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var resLabel: UILabel!
    
    func configureStackView(numberOfBut: Int) {
        
        print("number of button \(numberOfBut)")
        stackView.removeArrangedSubview(view)
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        setStackViewCinstrains()
        setTempStackView(numberOfRow: numberOfBut)
    }
    
    func setTempStackView(numberOfRow: Int) {
      
        for j in 1...numberOfRow {
            
            var stackViewTemp = UIStackView()
            
            stackView.addArrangedSubview(stackViewTemp) //add horizontal stackView in vertical stackView
            stackViewTemp.axis = .horizontal
            stackViewTemp.distribution = .fillEqually
            stackViewTemp.backgroundColor = .blue
            stackViewTemp.spacing = 5
                
            for i in 1...numberOfRow {
                let bigButton = surveyButton()
                var index = (j * numberOfRow - numberOfRow + 1) + i - 1
                bigButton.setTitle("\(digit[index-1])", for: .normal)
                bigButton.addTarget(self, action: #selector(buttonClicked(bb :)), for: .touchUpInside)
                stackViewTemp.addArrangedSubview(bigButton)
               
            }
        
           // setStackViewTempCinstrains()
        }
    }
    
    func setStackViewCinstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                            = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height-view.frame.width-100).isActive              = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive      = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive   = true
      //  stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive       = true
       // stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height/2+40).isActive       = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive       = true
    
        
    }
    
    func setStackViewTempCinstrains() {
    /*    stackViewTemp.translatesAutoresizingMaskIntoConstraints                                                            = false
        stackViewTemp.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor, constant: 2).isActive              = true
        stackViewTemp.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 2).isActive      = true
        stackViewTemp.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: -2).isActive   = true
        stackViewTemp.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -2).isActive       = true
         */
    }
    
  /*  func addButtonToStackView(numberof:Int) {
         
        for i in 1...numberof {
            let button = surveyButton()
            button.setTitle("\(digit[i-1])", for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(bb :)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }*/
    
    func generateDigitArray(countDigitArray:Int) {
        let size = Int(countDigitArray*countDigitArray)
        var stRandom = String()
        var result = [String]()
        digit = [] //обнуление массива
        
        for j in 1...size {
             digit.append(String(j))
        }
        
        digit.shuffle()
        //print(digit)
    }

    func customButton(_ text:String,_ yline:Double) {
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: 50.0, y:yline, width: 50.0, height: 20.0)
        button.setTitle(text, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.black
        button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(buttonClicked(bb :)), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func startTimer() {
        sec = 0
           timer = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(ViewController.tic), userInfo: nil, repeats: true)
           timer?.fire()
        
    }
    
    @objc func buttonClicked(bb :UIButton) {
        
        totalPressed = totalPressed + 1
        print("totalPressed = \(totalPressed)")
       
        print("Pressed \(bb.titleLabel!.text!)")
        var pressed = Int(bb.titleLabel!.text!)
       
         if totalPressed == 1 {
            print("Start")
            print(intDirection)
                self.startTimer()
        }
           
        if intDirection == 1 {
            //прямой отсчет
            if (pressed == Int(self.countGlobal*self.countGlobal)) && (self.lastPressed+intDirection == pressed) {
                             timer?.invalidate()
                         
                         DispatchQueue.main.async {
                             self.resLabel.text = "Finished! Your time is \(self.timeLbl.text!) sec"
                             self.playSound(playSound: "finish")
                         }
                         
                 }
            
            if (self.lastPressed+intDirection == pressed) && (pressed != Int(self.countGlobal*self.countGlobal)) {
                self.lastPressed = pressed!
            
                DispatchQueue.main.async {
                    self.resLabel.text = "ok, next is \(Int(bb.titleLabel!.text!)! + self.intDirection)"
                    self.playSound(playSound: "Ok")
                    }
            
        } else
                if (self.lastPressed+intDirection != pressed) && (pressed != Int(self.countGlobal*self.countGlobal)) {
                    print("Error. last \(self.lastPressed)")
                    self.totalError = self.totalError+1
                DispatchQueue.main.async {
                    self.resLabel.text = "Error : \(self.totalError). next is \(self.lastPressed + self.intDirection)"
                    self.playSound(playSound: "Error")
                    }
        }
        } else {
            //обратный отсчет
            if (pressed == 1) && (self.lastPressed+intDirection == pressed) {
                         print("Finish")
                             timer?.invalidate()
                         
                         DispatchQueue.main.async {
                             
                             self.resLabel.text = "Finished! Your time is \(self.timeLbl.text!) sec"
                             self.playSound(playSound: "finish")
                         }
                         
                 }
            
            
            if (self.lastPressed+intDirection == pressed) && (pressed != 1) {
                           self.lastPressed = pressed!
                       
                           DispatchQueue.main.async {
                               self.resLabel.text = "ok, next is \(Int(bb.titleLabel!.text!)! + self.intDirection)"
                               self.playSound(playSound: "Ok")
                               }
                       
                   } else
                           if (self.lastPressed+intDirection != pressed) && (pressed != 1) {
                               print("Error. last \(self.lastPressed)")
                               self.totalError = self.totalError+1
                           DispatchQueue.main.async {
                            self.resLabel.text = "Error : \(self.totalError). next is \(self.lastPressed + self.intDirection)"
                               self.playSound(playSound: "Error")
                               }
                   }
        }
        
        
    }
    
    override func viewDidLoad() {
        
        var sizeSmall = Int(selectedTaskIndex)!
        
        countGlobal = sizeSmall
        generateDigitArray(countDigitArray: countGlobal ) //генерация массива с данными
        timer?.invalidate()
      
        if digitsDirection {
                 resLabel.text = "Push 1"
             }
             else {
                resLabel.text = "Push " + String(countGlobal*countGlobal)
                lastPressed = Int(countGlobal*countGlobal) + 1
             }
//        print("Высота экрана \(view.frame.height)")
//              print("Ширина экрана \(view.frame.width)")
//
        super.viewDidLoad()
    
        configureStackView(numberOfBut: sizeSmall)
        mmsec = 0
    
    }
    
   
    
    
  
    func playSound(playSound: String) {
          var url = Bundle.main.url(forResource: "click", withExtension: "mp3")
        
        switch playSound {
        case "Ok":
             url = Bundle.main.url(forResource: "click", withExtension: "mp3")
        case "Error":
            url = Bundle.main.url(forResource: "poo", withExtension: "mp3")
        case "restart":
            url = Bundle.main.url(forResource: "restart", withExtension: "mp3")
        case "finish":
            url = Bundle.main.url(forResource: "finish", withExtension: "mp3")
      
        default:
            url = Bundle.main.url(forResource: "click", withExtension: "mp3")
        }
 
        
        //проверка если url = nil - прерываем
        guard url != nil else {
            return
        }
        
        //пробуем найти файл по пути url и воспроизвести его
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
        } catch {
            print("Error sound file")
        }
    }
    
     func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        
        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
    }
    
    
    @objc func tic(){ //функция расчета времени
          
        mmsec += 0.09
          if mmsec >= 600 {
              timer?.invalidate()
              mmsec = 0
          } else {
                var tSt = prodTimeString(time: mmsec)
            //print("Поток :\(Thread.current)")
           // print("время \(mmsec)")
                    self.timeLbl.text = tSt
          }
      }


}



