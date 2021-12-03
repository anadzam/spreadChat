//
//  ChatViewController.swift
//  spreadChat
//
//  Created by Ana Dzamelashvili on 11/20/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
       
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = Con.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Con.cellNibName, bundle: nil), forCellReuseIdentifier: Con.cellIdentifier)
        
        loadMessages()
        
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Con.FStore.collectionName).addDocument(data: [
                Con.FStore.senderField: messageSender,
                Con.FStore.bodyField: messageBody,
                Con.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                    if let e = error {
                        print("Issue saving data to firestore: \(e)")
                    } else {
                        print("Successfully saved to firestore")
                    }
                }
        }
    }
    func loadMessages(){
        
        
        db.collection(Con.FStore.collectionName)
            .order(by: Con.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []

            
            if let e = error {
                print("Issue retreving data \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        
                        if let messageSender = data[Con.FStore.senderField] as? String,
                           let messageBody = data[Con.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
            
        }
        
        
        
    //IBACtionze errors mmigcebda
  
   
    
    }
        
        @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
            
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            
        }
        
}


    
    extension ChatViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Con.cellIdentifier, for: indexPath)
            as! MessageCell
            cell.lable.text = messages[indexPath.row].body
            return cell
        }
        
        
    }
    
    

    
