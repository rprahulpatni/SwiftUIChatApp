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
    @Published var msgData: [MessageModel] = [MessageModel]()

    var toId:String!
    
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
                        let arrId = (item.key).components(separatedBy:"_")
                        if arrId[0] == fromId || arrId[1] == fromId {
                            if arrId[0] != fromId {
                                self.toId = arrId[0]
                            } else {
                                self.toId = arrId[1]
                            }
                        }
                        if (arrId[0] == "\(self.toId ?? "")" && arrId[1] == "\(fromId)") || (arrId[0] == "\(fromId)" && arrId[1] == "\(self.toId ?? "")") {
                            if let dictData = item.value as? [String: AnyObject] {
                                if let value = dictData["metadata"]  as? [String: AnyObject] {
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
                                            message.uploadedURL = (dictionary["uploadedURL"] as! String)
                                            message.latitude = (dictionary["latitude"] as! Double)
                                            message.longitude = (dictionary["longitude"] as! Double)
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
}
