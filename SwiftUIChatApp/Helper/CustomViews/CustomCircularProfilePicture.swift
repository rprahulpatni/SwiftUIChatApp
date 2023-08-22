//
//  CustomCircularProfilePicture.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 18/07/23.
//

import SwiftUI
import PhotosUI

struct CustomCircularProfilePicture: View {
    @Binding var selectedImageData : Data?
    @Binding var selectedImage : UIImage?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        if let imgData = self.selectedImageData, let uiImage = UIImage(data: imgData)?.compressedImage(imageSize: CGSize(width: 150, height: 150)) {
            Image(uiImage: uiImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
        }
    }
}

struct CustomCircularProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircularProfilePicture(selectedImageData: .constant(nil), selectedImage: .constant(nil), selectedItem: .constant(nil))
    }
}

struct EditableCircularProfileImage: View {
    @Binding var selectedImageData : Data?
    @Binding var selectedImage : UIImage?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        CustomCircularProfilePicture(selectedImageData: self.$selectedImageData, selectedImage: self.$selectedImage, selectedItem: self.$selectedItem)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                            .padding(10)
                            .font(.system(size: 20))
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                self.selectedImageData = data
                                if let imgData = self.selectedImageData, let uiImage = UIImage(data: imgData)?.compressedImage(imageSize: CGSize(width: 150, height: 150)) {
                                    self.selectedImage = uiImage
                                }
                            }
                        }
                    }
            }
            .buttonStyle(.borderless)
    }
}
