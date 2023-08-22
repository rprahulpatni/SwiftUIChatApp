//
//  SingleChatViewModel.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import Foundation
import Firebase

class SingleChatViewModel: ObservableObject {
    @Published var msgText: String = ""
    @Published var isLoading: Bool = false
    @Published var msgData: [MessageModel] = [MessageModel]()
    
    var chatUser: AuthUserData?
    var loggedUser: AuthUserData?
    
    init(iChatUser: AuthUserData?) {
        self.chatUser = iChatUser
    }
    
    //    func handleSend(){
    //        guard let fromId = self.sessionManager?.loggedUser?.uid else {return}
    //        //        guard let senderName = self.loggedUser?.name else {return}
    //        //        guard let senderPhoto = self.loggedUser?.profilePic else {return}
    //
    //        guard let toId = self.chatUser?.userId else {return}
    //        guard let reciverName = self.chatUser?.name else {return}
    //        guard let reciverPhoto = self.chatUser?.profilePic else {return}
    //
    //        let dictObj = MessageModel(isread: true, receiverId: toId, receiverName: reciverName, receiverPhoto: reciverPhoto, senderId: fromId, senderName: "", senderPhoto: "", text: self.msgText, timestamp: "\(Date().currentTimeMillis())", msgType: MessageType.text)
    //        let dictMsgData = dictObj.convertedDictionary
    //        let ref = Database.database().reference(withPath: "messages")
    //        ref.child("messages").observeSingleEvent(of: .value, with: { (snapshot) in
    //
    //            if snapshot.hasChild(("\(toId)-\(fromId))")){
    //                print("true rooms exist")
    //                ref.child(("\(toId)-\(fromId)")).childByAutoId().setValue(dictMsgData)
    //
    //            } else if snapshot.hasChild(("\(fromId)-\(toId)")){
    //                print("false room doesn't exist")
    //                ref.child(("\(fromId)-\(toId)")).childByAutoId().setValue(dictMsgData)
    //
    //            } else{
    //                ref.child(("\(toId)-\(fromId)")).childByAutoId().setValue(dictMsgData)
    //            }
    //
    //            self.msgText = ""
    //        })
    //    }
    //
    //    func fetchMessages() {
    //        self.isLoading = true
    //        guard let fromId = self.sessionManager?.loggedUser?.uid else {return}
    //        guard let toId = self.chatUser?.userId else {return}
    //
    //        let ref = Database.database().reference(withPath: "messages")
    //        ref.observe(.value, with: { [self] snapshot in
    //            // This is the snapshot of the data at the moment in the Firebase database
    //            // To get value from the snapshot, we user snapshot.value
    //            self.msgData = []
    //            if snapshot.exists() {
    //                if let dict = snapshot.value as? [String:AnyObject]{
    //                    for item in dict {
    //                        let arrId = (item.key).components(separatedBy:"-")
    //                        if (arrId[0] == "\(toId)" && arrId[1] == "\(fromId)") || (arrId[0] == "\(fromId)" && arrId[1] == "\(toId)") {
    //                            let dictval:NSDictionary = item.value as! NSDictionary
    //                            for items in dictval{
    //                                var message = MessageModel()
    //                                if let dictionary = items.value as? [String:AnyObject]{
    //                                    message.isread = (dictionary["isread"] as! Bool)
    //                                    message.receiverId = (dictionary["receiverId"] as! String)
    //                                    message.receiverName = (dictionary["receiverName"] as! String)
    //                                    message.receiverPhoto = (dictionary["receiverPhoto"] as! String)
    //                                    message.senderId = (dictionary["senderId"] as! String)
    //                                    message.senderName = (dictionary["senderName"] as! String)
    //                                    message.senderPhoto = (dictionary["senderPhoto"] as! String)
    //                                    message.text = (dictionary["text"] as! String)
    //                                    message.timestamp = (dictionary["timestamp"] as! String)
    //                                    message.msgType = (dictionary["msgType"] as! MessageType)
    //                                }
    //                                self.msgData.append(message)
    //                            }
    //                        }
    //                    }
    //                    print(self.msgData)
    //                    //MARK:- Sort messages Array
    //                    self.msgData.sort { (message1, message2) -> Bool in
    //                        var bool = false
    //                        if let time1 = message1.timestamp, let time2 = message2.timestamp {
    //                            bool = time1 < time2
    //                        }
    //                        return bool
    //                    }
    //                }
    //            }
    //            self.isLoading = false
    //        })
    //    }
    
    func handleSend(){
        let fromId = getUID()
        let senderName = getUName()
        let senderPhoto = getUPhoto()
        //        guard let senderName = self.loggedUser?.name else {return}
        //        guard let senderPhoto = self.loggedUser?.profilePic else {return}
        
        guard let toId = self.chatUser?.userId else {return}
        guard let reciverName = self.chatUser?.name else {return}
        guard let reciverPhoto = self.chatUser?.profilePic else {return}
        
        let dictObj = MessageModel(isread: true, receiverId: toId, receiverName: reciverName, receiverPhoto: reciverPhoto, senderId: fromId, senderName: senderName, senderPhoto: senderPhoto, text: self.msgText, timestamp: "\(Date().currentTimeMillis())", msgType: MessageType.text, uploadedURL: "")
        let dictMsgData = dictObj.convertedDictionary
        
//        let lastMsgObj = ChatListModel(isread: true, userName: reciverName, userProfilePic: reciverPhoto, userId: toId, userLastSeen: "",lastMessage: self.msgText, timestamp: "\(Date().currentTimeMillis())", msgType: MessageType.text)
//        let lastMsgData = lastMsgObj.convertedDictionary
        
        let chatRef = Database.database().reference(withPath: "chats")
        chatRef.child("chats").observeSingleEvent(of: .value, with: { (snapshot) in
            
//            if snapshot.hasChild(("\(toId)-\(fromId))")) {
//                print("true rooms exist")
//                //                chatRef.child(("\(toId)-\(fromId)")).childByAutoId().setValue(dictMsgData)
//                // Update message
//                chatRef.child(("\(toId)-\(fromId)")).child("messages").childByAutoId().setValue(dictMsgData)
//                // Update last message in metadata
//                chatRef.child(("\(toId)-\(fromId)")).child("metadata").child("last_message").setValue(dictMsgData)
//
//            } else if snapshot.hasChild(("\(fromId)-\(toId)")) {
//                print("false room doesn't exist")
//                //                chatRef.child(("\(fromId)-\(toId)")).childByAutoId().setValue(dictMsgData)
//                // Update message
//                chatRef.child(("\(fromId)-\(toId)")).child("messages").childByAutoId().setValue(dictMsgData)
//                // Update last message in metadata
//                chatRef.child(("\(fromId)-\(toId)")).child("metadata").child("last_message").setValue(dictMsgData)
//
//            } else {
//                //                chatRef.child(("\(toId)-\(fromId)")).childByAutoId().setValue(dictMsgData)
//                // Update message
//                chatRef.child(("\(toId)-\(fromId)")).child("messages").childByAutoId().setValue(dictMsgData)
//                // Update last message in metadata
//                chatRef.child(("\(toId)-\(fromId)")).child("metadata").child("last_message").setValue(dictMsgData)
//            }
            
            // Update message
            chatRef.child(("\(toId)-\(fromId)")).child("messages").childByAutoId().setValue(dictMsgData)
            // Update last message in metadata
            chatRef.child(("\(toId)-\(fromId)")).child("metadata").child("last_message").setValue(dictMsgData)
            self.msgText = ""
        })
    }
    
    func fetchMessages() {
        self.isLoading = true
        let fromId = getUID()
        guard let toId = self.chatUser?.userId else {return}
        
        let ref = Database.database().reference(withPath: "chats")
        ref.observe(.value, with: { [self] snapshot in
            // This is the snapshot of the data at the moment in the Firebase database
            // To get value from the snapshot, we user snapshot.value
            self.msgData = []
            if snapshot.exists() {
                if let dict = snapshot.value as? [String:AnyObject]{
                    for item in dict {
                        let arrId = (item.key).components(separatedBy:"-")
                        if (arrId[0] == "\(toId)" && arrId[1] == "\(fromId)") || (arrId[0] == "\(fromId)" && arrId[1] == "\(toId)") {
                            if let dictData = item.value as? [String: AnyObject] {
                                if let value = dictData["messages"]  as? [String: AnyObject] {
                                    // Use the 'value' here
                                    for items in value {
                                        var message = MessageModel()
                                        if let dictionary = items.value as? [String:AnyObject]{
                                            message.isread = (dictionary["isread"] as! Bool)
                                            message.receiverId = (dictionary["receiverId"] as! String)
                                            message.receiverName = (dictionary["receiverName"] as! String)
                                            message.receiverPhoto = (dictionary["receiverPhoto"] as! String)
                                            message.senderId = (dictionary["senderId"] as! String)
                                            message.senderName = (dictionary["senderName"] as! String)
                                            message.senderPhoto = (dictionary["senderPhoto"] as! String)
                                            message.text = (dictionary["text"] as! String)
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
                            bool = time1 < time2
                        }
                        return bool
                    }
                }
            }
            self.isLoading = false
        })
    }
}
