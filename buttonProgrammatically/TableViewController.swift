//
//  TableViewController.swift
//  buttonProgrammatically
//
//  Created by Eugene Izotov on 23.10.2019.
//  Copyright © 2019 Eugene Izotov. All rights reserved.
//

import UIKit
import Foundation

@available(iOS 13.0, *)
class TableViewController: UITableViewController {
    var task = ["Таблица Шульте 2x2","3x3","4x4","5x5","6x6","7x7","8x8","3x3 обратный","4x4 обратный","5x5 обратный","6x6 обратный", "4x4 красный/белый", "6x6 красный/белый", "8x8 красный/белый","Обезьяна 3", "Обезьяна 4", "Обезьяна 5", "Обезьяна 6", "Обезьяна 7", "Обезьяна 8", "Обезьяна 9", "Обезьяна 10"]
 
    var sss = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return task.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.listLbl.text = task[indexPath.row] //+ " index:" + String(indexPath.row)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed \(indexPath.row+2 )")
        sss = String(indexPath.row+2)
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTask", let destination = segue.destination as? ViewController,
            let sIndex = tableView.indexPathForSelectedRow?.row {
            //условия заданий
            switch sIndex {
            case 7...10:
                destination.digitsDirection = false //обратный отсчет
                destination.selectedTaskIndex = String(sIndex-4) //задания с обратным отсчетом
                destination.digitsColor = 0
                destination.monkey = false
            case 11:
                destination.digitsDirection = true //прямой отсчет, два цвета
                destination.selectedTaskIndex = String(sIndex-7)
                destination.digitsColor = 1
                destination.monkey = false
            case 12:
                destination.digitsDirection = true //прямой отсчет, два цвета
                destination.selectedTaskIndex = String(sIndex-6)
                destination.digitsColor = 1
                destination.monkey = false
            case 13:
                destination.digitsDirection = true //прямой отсчет, два цвета
                destination.selectedTaskIndex = String(sIndex-5)
                destination.digitsColor = 1
                destination.monkey = false
            case 14...21:
                destination.digitsDirection = true //monkey
                destination.selectedTaskIndex = String(5)
                destination.digitsColor = 0
                destination.monkey = true
                destination.monkeyDigits = sIndex - 11
            default:
                destination.selectedTaskIndex = String(sIndex+2) //обычные задания
                destination.digitsDirection = true
                destination.digitsColor = 0
            }
            
          }
     }
    
        

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
