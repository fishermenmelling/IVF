//
//  ViewController.swift
//  Contacts
//
//  Created by mark melling on 12/14/21.
//

import UserNotifications
import UIKit


//in file scope
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


//in file scope
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        
        return cell
    }
}

//in file scope
struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
    
}





//========================================VIEW CONTROLLER CLASS==============================================

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet var table: UITableView!
    
    //variable based on instance of "MyReminder" struct outside of this class
    var models = [MyReminder]()
    
    
    
    
    
    
    //================================VIEW CONTROLLER CLASS FUNCTION====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        //table.delegate = self
        //table.dataSource = self
        // Do any additional setup after loading the view.
    }
    //===================================================END===================================================
    
    
    
    
    
    
    //DIDTAPADD()
    //================================VIEW CONTROLLER CLASS FUNCTION====================================
    @IBAction func didTapAdd() {  //START 4
        
        
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else {
                return
        } //START 3
        
        
        vc.title = "New Reminder" //START 3
        
        
        vc.navigationItem.largeTitleDisplayMode = .never //START 3
        
        
        vc.completion = { title, body, date in //START 3
            
            
            DispatchQueue.main.async { //START 2
                
                self.navigationController?.popToRootViewController(animated: true) //START 1
                let new = MyReminder(title: title, date: date, identifier: "id_\(title)") //START 1
                self.models.append(new) //START 1
                self.table.reloadData() //START 1
                let content = UNMutableNotificationContent() //START 1
                content.title = title //START 1
                content.sound = .default //START 1
                content.body = body //START 1
                let targetDate = date //START 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false) //START 1
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                //START 1
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in //START 1
                    if error != nil { //START 0
                        print("something went wrong")
                    } //END 0
                }) //END 1
            
            } //END 2
        
        
        } //END 3
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    } //END 4
    //===================================================END===================================================
    
    
    
    
    
    
    
    
    
    //DIDTAPTEST()
    //================================VIEW CONTROLLER CLASS FUNCTION====================================
    @IBAction func didTapTest() {
        //fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                //schedule test
                self.scheduleTest()
            }
            else if  error != nil {
                print("error occured")
            }
        })
        
    }
    
    //===================================================END===================================================
    
    
    
    
    
    
    
    //SCHEDULETEST()
    //================================VIEW CONTROLLER CLASS FUNCTION====================================
    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "Testing"
        
        let targetDate = Date().addingTimeInterval(10)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                                                    
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                                  
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")}
            
        })
    
                                                    
    }

}
//===================================================END===================================================

//===================================================END OF CLASS==========================================
