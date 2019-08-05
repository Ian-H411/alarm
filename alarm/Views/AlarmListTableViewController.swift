//
//  AlarmListTableViewController.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.alarmCollection.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as? SwitchTableViewCell else {return UITableViewCell()}
        let alarm = AlarmController.sharedInstance.alarmCollection[indexPath.row]
        cell.alarm = alarm
        cell.delegate = self
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlarmController.sharedInstance.delete(alarm: AlarmController.sharedInstance.alarmCollection[indexPath.row])
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
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
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "toDetail"{
            if let index = tableView.indexPathForSelectedRow {
                if let toDetailVC = segue.destination as? AlarmDetailTableViewController{
                    let objectToSend = AlarmController.sharedInstance.alarmCollection[index.row]
                    toDetailVC.alarmLanding = objectToSend
                }
            }
        }
     }

    
}
extension AlarmListTableViewController: SwitchTableViewCellDelegate{
    func cellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm, let indexPath = tableView.indexPath(for: cell) else {return}
        AlarmController.sharedInstance.toggleEnabled(for: alarm)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

