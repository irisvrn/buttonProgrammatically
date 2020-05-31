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
    @IBOutlet weak var advCollectionView: UICollectionView!
    
    @IBAction func close(_ sender: Any) {
        Model.shared.setSettings(switcherAdv: true)
           let mainPage = self.storyboard?.instantiateViewController(identifier: "navCV") as! UINavigationController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = mainPage
               
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        advCollectionView.dataSource = self
        advCollectionView.delegate = self

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

@available(iOS 13.0, *)
extension AdvVC:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.advertText.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AdvCollectionViewCell {
            /* if indexPath.row == 0 {
                cell.backgroundColor = .red
            } else if indexPath.row == 1 {
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .blue
            }*/
            cell.titleLblCell.textColor = .systemGray
            cell.titleLblCell.text = Model.shared.advertText[indexPath.row]
            cell.imageViewCell.image = UIImage(named: Model.shared.advertImages[indexPath.row])
         /*cell.interestTitleLabel.text = imagesStr[indexPath.row]
         cell.featuredImageView.image = UIImage(named: imagesStr[indexPath.row])
         
         cell.featuredImageView.topAnchor.constraint(equalTo: cell.backgroundColorView.topAnchor, constant: 1).isActive = true
         cell.featuredImageView.bottomAnchor.constraint(equalTo: cell.backgroundColorView.bottomAnchor, constant: -1).isActive = true
         cell.featuredImageView.leftAnchor.constraint(equalTo: cell.backgroundColorView.leftAnchor, constant: 1).isActive = true
         cell.featuredImageView.rightAnchor.constraint(equalTo: cell.backgroundColorView.rightAnchor, constant: -1).isActive = true
         
         if imageText[indexPath.row] != nil  {
             cell.interestTitleLabel.text = imageText[indexPath.row]
         }
         */
         return cell}
        return UICollectionViewCell()
    }
    
    
}
