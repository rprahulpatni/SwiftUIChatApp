//
//  SingleChatView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI
import Firebase
import MapItemPicker

struct SingleChatView: View {
    @FocusState private var showKeyboard: Bool
    @State var showChatUserDetails: Bool = false
    @State private var isMenuOpen = false
    @State private var isImagePickerPresented = false
    @State private var isVideoPickerPresented = false
    @State private var isLocationPickerPresented = false
    @State private var selectedMsgType : MessageType = MessageType.text
    
    @StateObject private var viewModel : SingleChatViewModel
    init(viewModel: SingleChatViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            ChatScrollView
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: CustomChatBackNUserButton(chatUser: self.viewModel.chatUser, userProfileButtonAction: {
            self.showChatUserDetails.toggle()
        }))
        .navigationDestination(isPresented: $showChatUserDetails, destination:{
            OtherUserProfileView(uid: self.viewModel.chatUser?.userId)
        })
        .onAppear{
            self.viewModel.fetchMessages()
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $isMenuOpen) {
            ShareSheetView(selectedMsgType: $selectedMsgType, isShareSheetVisible: $isMenuOpen, isImagePickerPresented: $isImagePickerPresented, isVideoPickerPresented: $isVideoPickerPresented, isLocationPickerPresented: $isLocationPickerPresented)
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(175)])
        }
        .photosPicker(isPresented: self.selectedMsgType == .picture ? $isImagePickerPresented : $isVideoPickerPresented, selection: $viewModel.selectedItem, matching: self.selectedMsgType == .picture ? .images : .videos)
        .onChange(of: viewModel.selectedItem) { newItem in
            Task {
                // Retrieve selected asset in the form of Data
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if selectedMsgType == .picture {
                        self.viewModel.selectedImageData = data
                        if let imgData = self.viewModel.selectedImageData, let uiImage = UIImage(data: imgData)?.compressedImage(imageSize: CGSize(width: 250, height: 250)) {
                            self.viewModel.selectedImage = uiImage
                            self.viewModel.handleImageUpload()
                        }
                    } else {
                        self.viewModel.selectedVideoData = data
                        self.viewModel.handleVideoUpload()
                    }
                }
            }
        }
        .mapItemPicker(isPresented: $isLocationPickerPresented) { item in
            if let latitude = item?.placemark.coordinate.latitude, let longitute = item?.placemark.coordinate.longitude {
                //print("Selected \(name)")
                self.viewModel.handleLocationUpload(latitude, longitute)
            }
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
    
    private var ChatScrollView: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ScrollViewReader { scrollView in
                    VStack {
                        Spacer(minLength: 20)
                        ForEach(self.viewModel.msgData, id: \.self) { item in
                            ChatRow(item: item, uid: getUID())
                        }
                        HStack{
                            Spacer()
                        }
                        .id("Empty")
                    }
                    .onReceive(viewModel.$msgDataCount) { _ in
                        // Scroll to the bottom initially
                        scrollView.scrollTo("Empty", anchor: .bottom)
                    }
                }
            }
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom, content: {
                KeyBoardView
                    .background(Color(.systemBackground))
            })
        }
        .modifier(CustomHideKeyboardModifier())
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
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
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

