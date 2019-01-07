//
//  ViewController.swift
//  Project
//
//  Created by 何玉蓮 on 2018/12/16.
//  Copyright © 2018 何玉蓮. All rights reserved.
//

import UIKit

struct MyData {
    
    var amount: String!
    var equal: String!
    var reason: String!
    var time: String!
}


class ViewController: UIViewController {
    
    // Property here
  
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var reasonTexrField: UITextField!
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var tableView: UITableView!
    
    var myDatas: [MyData] = []
    
    // 最先執行的method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.placeholder = "請輸入金額"
        amountTextField.borderStyle = .roundedRect
        amountTextField.clearButtonMode = .whileEditing
        amountTextField.keyboardType = .numberPad
        reasonTexrField.placeholder = "請輸入事由"
        reasonTexrField.borderStyle = .roundedRect
        reasonTexrField.clearButtonMode = .whileEditing
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    // Custom method
    
    @objc func viewTapped() {
        
        self.view.endEditing(true)
    }
    

    @IBAction func addButtonPressed(_ sender: Any) {
        
        if !amountTextField.text!.isEmpty && !reasonTexrField.text!.isEmpty {
            
            let date = Date()
            let dateFormate = DateFormatter()
            dateFormate.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let time = dateFormate.string(from: date)
            
            // 輸入框非空值
            let myData = MyData(amount: amountTextField.text,
                                equal: "\(Int(amountTextField.text!)! / Int(stepper.value))",
                                reason: reasonTexrField.text,
                                time: time)
            
            // [myData0, myData1, myData2]
//            myDatas.append(myData)
            myDatas.insert(myData, at: 0)
            
            tableView.reloadData()
            
            self.view.endEditing(true)
            
            amountTextField.text = ""
            reasonTexrField.text = ""
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        
        peopleCountLabel.text = "人數 \(Int(stepper.value))"
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myData = myDatas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.amountLabel.text = myData.amount
        cell.equalLabel.text = "\(myData.equal ?? "") / 人"
        cell.reasonLabel.text = myData.reason
        cell.timeLabel.text = myData.time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
}
