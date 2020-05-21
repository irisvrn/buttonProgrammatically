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
    var digitsColor = Int()
    var digitsDirection = Bool()
    var monkey = Bool()
    var monkeyDigits = Int()
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
    //в обезьяне не правильно работает restart
    //adv контроллер добавить слайдер и текст с картинками что делать на весь экран. смотри тесты
    
    
    @IBOutlet weak var restartBtn: UIBarButtonItem!
    
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
        
        
        DispatchQueue.main.async {
            self.stackView.removeArrangedSubview(self.view)
            self.view.addSubview(self.stackView)
            self.stackView.axis = .vertical
            self.stackView.distribution = .fillEqually
            self.stackView.spacing = 10
            self.setStackViewCinstrains()
            self.setTempStackView(numberOfRow: numberOfBut)
        }
               
            
       
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
                
                var str = digit[index-1]
                print("::\(str)")
                if str.contains("c") {
                    str = str.replacingOccurrences(of: "c", with: "")
                    bigButton.setTitleColor(.red, for: .normal)
                }
                if str == "" {
                    bigButton.backgroundColor = .systemYellow
                }
                bigButton.setTitle("\(str)", for: .normal)
                if monkey == true {
                    delayButtonHidden(bibbigbutton: bigButton)
                }
                bigButton.addTarget(self, action: #selector(buttonClicked(bb :)), for: .touchUpInside)
                stackViewTemp.addArrangedSubview(bigButton)
               
            }
        }
    }
    
    func setStackViewCinstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                            = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height-view.frame.width-100).isActive              = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive      = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive   = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive       = true
    
    }
    

    
    func generateDigitArray(countDigitArray:Int) {
        var size = Int(countDigitArray*countDigitArray)
        var stRandom = String()
        var result = [String]()
        digit = [] //обнуление массива
        
        if digitsColor == 1 {size = size/2}
        for j in 1...size {
            if monkey == false {
                digit.append(String(j))
            } else {
                if j > monkeyDigits {
                    digit.append("")
                } else {
                    digit.append(String(j))
                }
            }
            if digitsColor == 1 {
                digit.append(String(j) + "c")
            }
        }
        digit.shuffle()
       // print(digit)
    }
    
    
    func startTimer() {
        sec = 0
           timer = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(ViewController.tic), userInfo: nil, repeats: true)
           timer?.fire()
        
    }
    
    @objc func buttonClicked(bb :UIButton) {
        var pressed = Int()
        
        totalPressed = totalPressed + 1
        print("totalPressed = \(totalPressed)")
       
        if bb.titleLabel!.text != nil {
            print("Pressed \(bb.titleLabel!.text)")
            pressed = Int(bb.titleLabel!.text!)!
        } else {
            print("Pressed 0")
            pressed = 0
        }
        
       
         if totalPressed == 1 {
           // print("Start")
            print(intDirection)
                self.startTimer()
        }
           
        if intDirection == 1 {
            if digitsColor != 1 {
            //прямой отсчет
                if monkey {
                    //monkey
                    if (pressed == Int(monkeyDigits)) && (self.lastPressed+intDirection == pressed) && (bb.titleColor(for: .normal) == .purple) {
                                           timer?.invalidate()
                                       
                                       DispatchQueue.main.async {
                                            self.resLabel.text = "Finished! Your time is \(self.timeLbl.text!) sec"
                                            bb.backgroundColor = .systemYellow
                                            bb.setTitleColor(.systemYellow, for: .normal)
                                            self.playSound(playSound: "finish")
                                       }
                          }
                          
                    if (self.lastPressed+intDirection == pressed) && (pressed != Int(monkeyDigits) && (bb.titleColor(for: .normal) == .purple)) {
                        self.lastPressed = pressed
                          
                              DispatchQueue.main.async {
                                  self.resLabel.text = "ok, next is \(Int(bb.titleLabel!.text!)! + self.intDirection)"
                                  bb.backgroundColor = .systemYellow
                                  bb.setTitleColor(.systemYellow, for: .normal)
                                  self.playSound(playSound: "Ok")
                                  }
                          
                          } else
                              if (self.lastPressed+intDirection != pressed) && (pressed != Int(monkeyDigits)) {
                                  print("Error. last \(self.lastPressed)")
                                  self.totalError = self.totalError+1
                              DispatchQueue.main.async {
                                  self.resLabel.text = "Error : \(self.totalError). next is \(self.lastPressed + self.intDirection)"
                                  self.playSound(playSound: "Error")
                                  }
                              } else if (bb.titleColor(for: .normal) != .purple) || (bb.titleLabel == nil) {
                                print("Error. last \(self.lastPressed)")
                                    self.totalError = self.totalError+1
                                DispatchQueue.main.async {
                                    self.resLabel.text = "Error : \(self.totalError). next is \(self.lastPressed + self.intDirection)"
                                    self.playSound(playSound: "Error")
                                }
                    }
                } else {
                    //нормальный режим
                    if (pressed == Int(self.countGlobal*self.countGlobal)) && (self.lastPressed+intDirection == pressed) {
                                     timer?.invalidate()
                                 
                                 DispatchQueue.main.async {
                                     self.resLabel.text = "Finished! Your time is \(self.timeLbl.text!) sec"
                                     self.playSound(playSound: "finish")
                                 }
                    }
                    
                    if (self.lastPressed+intDirection == pressed) && (pressed != Int(self.countGlobal*self.countGlobal)) {
                        self.lastPressed = pressed
                    
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
                }
                
            } else {
                //2 цвета
                
                if (pressed == Int(self.countGlobal*self.countGlobal/2)) && (self.lastPressed+intDirection == pressed) && (bb.titleColor(for: .normal) == .white) {
                    
                                 timer?.invalidate()
                                 DispatchQueue.main.async {
                                     self.resLabel.text = "Finished! Your time is \(self.timeLbl.text!) sec"
                                     self.playSound(playSound: "finish")
                                 }
                         }
        
                    if (self.lastPressed+intDirection == pressed) && (pressed != Int(self.countGlobal*self.countGlobal/2)) && (bb.titleColor(for: .normal) == .white) {
                        self.lastPressed = pressed
                    
                        DispatchQueue.main.async {
                            self.resLabel.text = "ok, next is white \(Int(bb.titleLabel!.text!)! + self.intDirection)"
                            self.playSound(playSound: "Ok")
                            }
                    
                } else
                        if (self.lastPressed+intDirection != pressed) && (pressed != Int(self.countGlobal*self.countGlobal/2)) {
                            print("Error. last \(self.lastPressed)")
                            self.totalError = self.totalError+1
                        DispatchQueue.main.async {
                            self.resLabel.text = "Error : \(self.totalError). next is white \(self.lastPressed + self.intDirection)"
                            self.playSound(playSound: "Error")
                            }
                            //проверка ошибок на цвет
                }
                 if (bb.titleColor(for: .normal) != .white) {
                                           print("Error. last \(self.lastPressed)")
                                           self.totalError = self.totalError+1
                                       DispatchQueue.main.async {
                                           self.resLabel.text = "Error : \(self.totalError). next is white \(self.lastPressed + self.intDirection)"
                                           self.playSound(playSound: "Error")
                                           }
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
                           self.lastPressed = pressed
                       
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
      
        print("countglobal: \(countGlobal)")
        
        if digitsDirection {
            if digitsColor == 1 {
                 resLabel.text = "Push white 1"
            } else {
                resLabel.text = "Push 1"
            }
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
        
      //  delayButtonHidden
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

    func delayButtonHidden(bibbigbutton: UIButton) {
        //меняем цвет текста на кнопоках через 3 секунды
        let queue = DispatchQueue.global(qos: .utility)
        restartBtn.isEnabled = false
        queue.async {
            sleep(3)
            DispatchQueue.main.async {
                bibbigbutton.setTitleColor(.purple, for: .normal)
                self.restartBtn.isEnabled = true
            }
        }
    }

}



