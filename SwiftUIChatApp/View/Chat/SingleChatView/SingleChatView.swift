//
//  SingleChatView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI
import Firebase

struct SingleChatView: View {
    @FocusState private var showKeyboard: Bool
    @StateObject private var viewModel : SingleChatViewModel
    @State private var isMenuOpen = false
    @State private var isImagePickerPresented = false
    @State private var selectedMsgType : MessageType = MessageType.text
    
    init(viewModel: SingleChatViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            ChatScrollView
        }
        .navigationBarTitle("Chat", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: CustomPopToRootButton())
        .onAppear{
            self.viewModel.fetchMessages()
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $isMenuOpen) {
            ShareSheetView(selectedMsgType: $selectedMsgType, isShareSheetVisible: $isMenuOpen, isImagePickerPresented: $isImagePickerPresented)
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(175)])
        }
        .photosPicker(isPresented: $isImagePickerPresented, selection: $viewModel.selectedItem)
        .onChange(of: viewModel.selectedItem) { newItem in
            Task {
                // Retrieve selected asset in the form of Data
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    self.viewModel.selectedImageData = data
                    if let imgData = self.viewModel.selectedImageData, let uiImage = UIImage(data: imgData)?.compressedImage(imageSize: CGSize(width: 200, height: 200)) {
                        self.viewModel.selectedImage = uiImage
                        self.viewModel.handleImageUpload()
                    }
                }
            }
        }
    }
    
    private var ChatScrollView: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ForEach(self.viewModel.msgData, id: \.self) { item in
                    ChatRow(item: item, uid: getUID())
                }
                HStack{
                    Spacer()
                }
            }
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom, content: {
                KeyBoardView
                    .background(Color(.systemBackground))
            })
        }
    }
    
    private var KeyBoardView: some View {
        HStack(spacing: 10){
            Button(action: {
                self.isMenuOpen.toggle()
            }, label: {
                Image(systemName: "paperclip")
                    .padding(10)
            })
            HStack{
                Spacer()
                HStack{
                    TextField("Message", text: $viewModel.msgText, axis: .vertical)
                        .focused($showKeyboard)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            }
            .background(Color(.init(white: 0.95, alpha: 1)))
            .cornerRadius(10)
            
            Button(action: {
                viewModel.handleSend()
            }, label: {
                Image(systemName: "paperplane.fill")
                    .padding(10)
                    .background(.teal)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            })
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
    }
}

//struct SingleChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleChatView(viewModel: <#SingleChatViewModel#>)
//    }
//}
