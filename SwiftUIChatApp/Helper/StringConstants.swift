//
//  StringConstants.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 10/07/23.
//

import Foundation
import UIKit
import AVFoundation

struct StringConstants {
    static let placeholderImageLogo = "logo"
    static let placeholderImageFilm = "film"
    static let placeholderImagePerson = "person.circle.fill"
    static let placeholderImageSearch = "magnifyingglass"
    static let placeholderImageCalender = "calendar"
    static let placeholderImageThumbsUp = "hand.thumbsup"
    static let placeholderImageBackButton = "chevron.backward"
    
    static let placeholderImagePicture = "photo.fill"
    static let placeholderImageVideo = "video.fill"
    static let placeholderImageLocation = "location.fill"
    
    static let msgError = "Error"
    static let msgCancel = "Cancel"
    struct APIErrors {
        static let noNetwork = "Please check your internet connection and try again"
        static let errorOccured = "Error occured while processing your request"
    }
    
    struct LoginSignUp {
        static let userEmailBlank = "Email cannot be blank"
        static let userEmailValid = "Please enter valid email"
        static let userNameBlank = "Username cannot be blank"
        static let userCountryCodeBlank = "Country Code cannot be blank"
        static let userMobileBlank = "Mobile number cannot be blank"
        static let userMobileValid = "Please enter valid mobile number"
        static let userDOBBlank = "Date of Birth cannot be blank"
        static let passwordBlank = "Password cannot be blank"
        static let confirmPasswordBlank = "Confirm Password cannot be blank"
        static let confirmPasswordMatch = "Password and Confirm Password does not matched"
        static let error = "Login Failed, the username or password provided in the request is invalid"
    }
}

extension String {
    var isNotEmpty: Bool {
        return !self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    var isValidEmail: Bool {
        let emailRegex:NSString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let pwdRegex: NSString = "(?=^.{6,14}$)(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?\\&gt;.&lt;,])(?!.*\\s).*$"
        let pwdTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", pwdRegex)
        return pwdTest.evaluate(with: self)
    }
    
    var isValidName: Bool {
        let regX: NSString = "^([a-zA-Z]+s?)( [a-zA-Z]+s?)*$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", regX)
        let result =  nameTest.evaluate(with: self)
        return result
    }
    
    var isValidMobile: Bool {
        let regX: NSString = "^[6-9]\\d{9}$"//"^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
}

extension DateFormatter {
    static var longDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    static var stringToDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }
    
    static func timeStampToDate(timeVal:String, dateFormat: String) -> String {
        let timeResult:Double =  NumberFormatter().number(from: timeVal)?.doubleValue ?? 0
        let time = timeVal.count > 10 ? timeResult/1000 : timeResult
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current//TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat//"dd, MMM yyyy hh:mm a"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    static func convertTimestampStringToTimeInterval(_ timestampString: String) -> TimeInterval? {
        if let timestamp = Double(timestampString) {
            return timestamp / 1000
        }
        return nil
    }
    
    static func convertTimestampStringToDate(_ timestampString: String) -> Date? {
        if let timestamp = Double(timestampString) {
            let timestampInSeconds = timestamp / 1000 // Convert milliseconds to seconds
            return Date(timeIntervalSince1970: timestampInSeconds)
        }
        return nil
    }
    
    static func getUserLastActivityTime(_ timestampString: String) -> String {
        let sourceDate = DateFormatter.convertTimestampStringToDate(timestampString) ?? Date()
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let currentDate = Date()
        var secondsAgo = Double(currentDate.timeIntervalSince(sourceDate))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60.0
        let hour = 60.0 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < day  {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: sourceDate)
            return strDate
        } else if secondsAgo < week {
            let days = Double(secondsAgo/day)
            let rounded = Double(round(days))
            let roundedDays = Int(rounded)
            if roundedDays == 1{
                return "Yesterday"
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                formatter.locale = Locale(identifier: "en_US")
                let strDate: String = formatter.string(from: sourceDate)
                return strDate
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: sourceDate)
            return strDate
        }
    }
}

extension UIImage {
    func aspectFittedToHeight(imageSize : CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: imageSize))
        }
    }
    
    func compressedImage(imageSize : CGSize) -> UIImage {
        let resizedImage = self.aspectFittedToHeight(imageSize: imageSize)
        resizedImage.jpegData(compressionQuality: 0.2)
        return resizedImage
    }
    
    func compressImageAndConvertToBase64(imageSize : CGSize) -> String? {
        let resizedImage = self.aspectFittedToHeight(imageSize: imageSize)
        if let imageData = resizedImage.jpegData(compressionQuality: 0.2) {
            let base64String = imageData.base64EncodedString(options: [])
            return base64String
        }
        return nil
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    var convertedDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func timeStampToDate(timeVal:String, dateFormat: String)->String {
        let timeResult:Double =  NumberFormatter().number(from: timeVal)?.doubleValue ?? 0
        let time = timeVal.count > 10 ? timeResult/1000 : timeResult
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current//TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat//"dd, MMM yyyy hh:mm a"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

//Generte Thumbnail from Video URL
extension URL {
    //    func generateThumbnail() -> UIImage? {
    //        do {
    //            let asset = AVURLAsset(url: self)
    //            let imageGenerator = AVAssetImageGenerator(asset: asset)
    //            imageGenerator.appliesPreferredTrackTransform = true
    //            // Select the right one based on which version you are using
    //            // Swift 4.2
    //            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
    //
    //            return UIImage(cgImage: cgImage)
    //        } catch {
    //            print(error.localizedDescription)
    //            return nil
    //        }
    //    }
    
    //    static func generateThumbnail(_ videoUrl: URL, completion: @escaping (UIImage?) -> Void) {
    //        let asset = AVAsset(url: videoUrl)
    //        let generator = AVAssetImageGenerator(asset: asset)
    //        let time = CMTime(seconds: 2, preferredTimescale: 1) // Example: 2 seconds into the video
    //
    //        generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { requestedTime, cgImage, _, _, _ in
    //            if let cgImage = cgImage {
    //                let uiImage = UIImage(cgImage: cgImage)
    //                completion(uiImage)
    //            } else {
    //                completion(nil)
    //            }
    //        }
    //    }
}

///////
///
func generateThumbnail(from videoURL: URL, completion: @escaping (UIImage?) -> Void) {
    let asset = AVAsset(url: videoURL)
    let generator = AVAssetImageGenerator(asset: asset)
    let time = CMTime(seconds: 2, preferredTimescale: 1) // Example: 2 seconds into the video
    // Specify the correct video orientation
    generator.appliesPreferredTrackTransform = true
    generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { requestedTime, cgImage, _, _, _ in
        if let cgImage = cgImage {
            let uiImage = UIImage(cgImage: cgImage)
            completion(uiImage)
        } else {
            completion(nil)
        }
    }
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
