//
//  SingleChatViewModel.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit
import PhotosUI
import SwiftUI

class SingleChatViewModel: ObservableObject {
    @Published var msgText: String = ""
    @Published var isLoading: Bool = false
    @Published var msgData: [MessageModel] = [MessageModel]()
    
    //Sending image
    @Published var selectedImageData : Data?
    @Published var selectedImage : UIImage? = nil
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedVideoURL : URL?
    @Published var selectedVideoData : Data?

    let sessionManager: SessionManager?

    var chatUser: AuthUserData?
    var loggedUser: AuthUserData?
    
    init(iSessionManager: SessionManager?, iChatUser: AuthUserData?) {
        self.sessionManager = iSessionManager
        self.chatUser = iChatUser
    }
    
    func handleSend(){
//        let fromId = getUID()
//        let senderName = getUName()
//        let senderPhoto = getUPhoto()
//
//        guard let toId = self.chatUser?.userId else {return}
//        guard let reciverName = self.chatUser?.name else {return}
//        guard let reciverPhoto = self.chatUser?.profilePic else {return}
//
//        let dictObj = MessageModel(isread: true, receiverId: toId, receiverName: reciverName, receiverPhoto: reciverPhoto, senderId: fromId, senderName: senderName, senderPhoto: senderPhoto, text: self.msgText, timestamp: "\(Date().currentTimeMillis())", msgType: MessageType.text, uploadedURL: "")
//        let dictMsgData = dictObj.convertedDictionary
//
//        let chatRoomId = fromId < toId ? "\(fromId)_\(toId)" : "\(toId)_\(fromId)"
//
//        let chatRef = Database.database().reference(withPath: "chats")
//        chatRef.child("chats").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            // Update message
//            chatRef.child((chatRoomId)).child("messages").childByAutoId().setValue(dictMsgData)
//            // Update last message in metadata
//            chatRef.child((chatRoomId)).child("metadata").child("last_message").setValue(dictMsgData)
//
//            self.msgText = ""
//        })
        
        self.sendMessgagesToFirebase(self.msgText, "", .text)
    }
    
    func handleImageUpload() {
        self.isLoading = true
        self.sessionManager?.uploadChatImageToFirebaseStorage(image: self.selectedImage) { imageUrl, failure in
            if failure.isNotEmpty {
                self.isLoading = false
            } else {
                self.isLoading = false
                self.sendMessgagesToFirebase("", imageUrl, .picture)
            }
        }
    }
    
    func handleVideoUpload() {
        self.isLoading = true
        self.sessionManager?.uploadChatVideoToFirebaseStorage(uploadedData: self.selectedVideoData) { videoUrl, failure in
            if failure.isNotEmpty {
                self.isLoading = false
            } else {
                self.isLoading = false
                self.sendMessgagesToFirebase("", videoUrl, .video)
            }
        }
    }
    
    func sendMessgagesToFirebase(_ text: String, _ uploadedURL: String, _ msgType: MessageType) {
        let fromId = getUID()
        let senderName = getUName()
        let senderPhoto = getUPhoto()
        
        guard let toId = self.chatUser?.userId else {return}
        guard let reciverName = self.chatUser?.name else {return}
        guard let reciverPhoto = self.chatUser?.profilePic else {return}
        
        let dictObj = MessageModel(isread: true, receiverId: toId, receiverName: reciverName, receiverPhoto: reciverPhoto, senderId: fromId, senderName: senderName, senderPhoto: senderPhoto, text: text, timestamp: "\(Date().currentTimeMillis())", msgType: msgType, uploadedURL: uploadedURL)
        let dictMsgData = dictObj.convertedDictionary
        
        let chatRoomId = fromId < toId ? "\(fromId)_\(toId)" : "\(toId)_\(fromId)"
        
        let chatRef = Database.database().reference(withPath: "chats")
        chatRef.child("chats").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Update message
            chatRef.child((chatRoomId)).child("messages").childByAutoId().setValue(dictMsgData)
            // Update last message in metadata
            chatRef.child((chatRoomId)).child("metadata").child("last_message").setValue(dictMsgData)
            
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
                        let arrId = (item.key).components(separatedBy:"_")
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
                                            message.uploadedURL = (dictionary["uploadedURL"] as! String)
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
