//
//  ChatListViewModel.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

class ChatListViewModel: ObservableObject {
    @Published var arrUsers : Array<AuthUserData> = Array<AuthUserData>()
    @Published var isLoading = false
    @Published var msgData: [ChatListModel] = [ChatListModel]()

    var fromID:String!
    var toID:String!
    
    func fetchDB() {
        self.isLoading = true
        let ref = Database.database().reference(withPath: "chats")
        let userId = getUID()
        
        ref.observe(.value, with: { snapshot in
            // This is the snapshot of the data at the moment in the Firebase database
            // To get value from the snapshot, we user snapshot.value
            self.arrUsers = []
            if snapshot.exists() {
                let dict:NSDictionary = snapshot.value as! NSDictionary
                
                for item in dict {
                    let arrProjectID = (item.key as! String).components(separatedBy:"-")
                    if arrProjectID[0] == userId || arrProjectID[1] == userId {
                        if arrProjectID[0] != userId {
                            self.toID = arrProjectID[0]
                        } else {
                            self.toID = arrProjectID[1]
                        }
//                        self.fetchUserFromMsg(uid: self.toID)
                    }
                }
                self.isLoading = false
            }else{
                self.isLoading = false
            }
        })
    }
    
    func fetchMessages() {
        self.isLoading = true
        let fromId = getUID()
        
        let ref = Database.database().reference(withPath: "chats")
        ref.observe(.value, with: { [self] snapshot in
            // This is the snapshot of the data at the moment in the Firebase database
            // To get value from the snapshot, we user snapshot.value
            self.msgData = []
            if snapshot.exists() {
                if let dict = snapshot.value as? [String:AnyObject]{
                    for item in dict {
                        let arrId = (item.key).components(separatedBy:"-")
                        if arrId[0] == fromId || arrId[1] == fromId {
                            if arrId[0] != fromId {
                                self.toID = arrId[0]
                            } else {
                                self.toID = arrId[1]
                            }
                        }
                        if (arrId[0] == "\(self.toID ?? "")" && arrId[1] == "\(fromId)") || (arrId[0] == "\(fromId)" && arrId[1] == "\(self.toID ?? "")") {
                            if let dictData = item.value as? [String: AnyObject] {
                                if let value = dictData["metadata"]  as? [String: AnyObject] {
                                    // Use the 'value' here
                                    for items in value {
                                        var message = ChatListModel()
                                        if let dictionary = items.value as? [String:AnyObject]{
                                            message.isread = (dictionary["isread"] as! Bool)
                                            message.userId = (dictionary["userId"] as! String)
                                            message.userName = (dictionary["userName"] as! String)
                                            message.userProfilePic = (dictionary["userProfilePic"] as! String)
                                            message.userLastSeen = (dictionary["userLastSeen"] as! String)
                                            message.lastMessage = (dictionary["lastMessage"] as! String)
                                            message.timestamp = (dictionary["timestamp"] as! String)
                                            message.msgType = nil
                                            if let value =  dictionary["msgType"] as? String  {
                                                message.msgType = MessageType(rawValue:value)!
                                            }
                                        }
                                        self.msgData.append(message)
                                    }
                                } else {
                                    // Key not found
                                }
                            }
                        }
                    }
                    print(self.msgData)
                    //MARK:- Sort messages Array
                    self.msgData.sort { (message1, message2) -> Bool in
                        var bool = false
                        if let time1 = message1.timestamp, let time2 = message2.timestamp {
                            bool = time1 > time2
                        }
                        return bool
                    }
                }
            }
            self.isLoading = false
        })
    }
    
//    func fetchUserFromMsg(uid: String) {
//        self.isLoading = true
//        let usersRef = Database.database().reference().child("users")
//        usersRef.observe(.value, with: { [self] snapshot in
//            if snapshot.exists() {
//                if let dict = snapshot.value as? [String:AnyObject]{
//                    for items in dict {
//                        if "\(items.key)" == uid {
//                            var message = ChatListModel()
//                            if let dictionary = items.value as? [String:AnyObject] {
//                                message.isread = (dictionary["isread"] as! Bool)
//                                message.userName = (dictionary["name"] as! String)
//                                message.userProfilePic = (dictionary["profilePic"] as! String)
//                                message.userId = (dictionary["userId"] as! String)
////                                message.userLastSeen = (dictionary["profilePic"] as! String)
////                                message.lastMessage = (dictionary["lastMessage"] as! String)
////                                message.msgType = (dictionary["msgType"] as! String)
//                            }
////                            self.arrUsers.append(message!)
//                        }
//                    }
//                }
//            }
//        })
//    }
    
    func fetchUser(uid: String, completion: @escaping (_ success: Bool, _ userData: AuthUserData?) -> Void) {
        self.isLoading = true
        //        guard let uid = Auth.auth().currentUser?.uid else { return }
        let usersRef = Database.database().reference().child("users")
//        usersRef.observe(.value, with: { [self] snapshot in
//            if snapshot.exists() {
//                if let dict = snapshot.value as? [String:AnyObject]{
//                    for items in dict {
//                        if "\(items.key)" == uid {
//                            var message = ChatListModel()
//                            if let dictionary = items.value as? [String:AnyObject] {
//                                message.isread = (dictionary["isread"] as! Bool)
//                                message.userName = (dictionary["name"] as! String)
//                                message.userProfilePic = (dictionary["profilePic"] as! String)
//                                message.userId = (dictionary["userId"] as! String)
////                                message.userLastSeen = (dictionary["profilePic"] as! String)
////                                message.lastMessage = (dictionary["lastMessage"] as! String)
////                                message.msgType = (dictionary["msgType"] as! String)
//                            }
////                            self.arrUsers.append(message!)
//                        }
//                    }
//                }
//            }
//        })
        usersRef.child(uid).observeSingleEvent(of: .value) { snapshot in
            if let userInfo = snapshot.value as? [String: Any] {
                // Access user information here
                print("User Info: \(userInfo)")
                let user = AuthUserData(profilePic: userInfo["profilePic"] as? String ?? "", name:  userInfo["name"] as? String ?? "", email:  userInfo["email"] as? String ?? "", dob:  userInfo["dob"] as? String ?? "", gender:  userInfo["gender"] as? String ?? "", countryCode:  userInfo["countryCode"] as? String ?? "", mobile:  userInfo["mobile"] as? String ?? "", userId: userInfo["userId"] as? String ?? "")
                completion(true, user)
                self.isLoading = false
            } else {
                completion(false, nil)
                print("User information not found")
                self.isLoading = false
            }
        }
    }
}
