//
//  MessageModel.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 18/08/23.
//

import Foundation
import Firebase

public enum MessageType: String, Codable{
    case text = "text"
    case picture = "picture"
    case video = "video"
    case location = "location"
}

//MARK: -  function to get uid
internal func getUID() -> String {
    let uid = Auth.auth().currentUser?.uid
    return uid ?? "notFound"
}

internal func getUName() -> String {
    let name = Auth.auth().currentUser?.displayName
    return name ?? "notFound"
}

internal func getUPhoto() -> String {
    let photoURL = Auth.auth().currentUser?.photoURL
    return photoURL?.absoluteString ?? "notFound"
}

struct MessageModel : Codable, Hashable {
    var isread: Bool?
    var receiverId: String?
    var receiverName: String?
    var receiverPhoto: String?
    var senderId: String?
    var senderName: String?
    var senderPhoto: String?
    var text: String?
    var timestamp: String?
    var msgType: MessageType?
    var uploadedURL: String?
    var latitude: Double?
    var longitude: Double?
    var id : String {
        if senderId == getUID(){
            return receiverId!
        } else {
            return senderId!
        }
    }
        
    func chatPatnerId() -> String? {
        return senderId == getUID() ? receiverId : senderId
    }
}

struct ChatListModel : Codable, Hashable {
    var id: UUID = UUID()
    var isread: Bool?
    var userName: String?
    var userProfilePic: String?
    var userId: String?
    var userLastSeen: String?
    var lastMessage: String?
    var timestamp: String?
    var msgType: MessageType?
}
