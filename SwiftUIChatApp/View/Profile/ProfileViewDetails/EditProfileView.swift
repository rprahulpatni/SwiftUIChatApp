//
//  EditProfileView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 13/07/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        return min...max
    }
    
    @State private var isDatePickerVisible = false
    @State private var isPickerVisible = false
    @State private var isMenuOpen = false
    @StateObject private var viewModel: EditProfileViewModel
    
    init(viewModel: EditProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            if let user = viewModel.user {
                ScrollView(showsIndicators: false) {
                    VStack {
                        EditableCircularProfileImage(selectedImageData: self.$viewModel.selectedImageData, selectedImage: self.$viewModel.selectedImage, selectedItem: self.$viewModel.selectedItem)
                            .padding(.bottom, 20)
                        TextField("Name", text: $viewModel.userName)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(CustomTxtFieldStyle())
                            .padding(.bottom, 5)
                        TextField("Email", text: $viewModel.userEmail).disabled(true)
                            .textFieldStyle(CustomTxtFieldStyle())
                            .keyboardType(.emailAddress)
                            .padding(.bottom, 5)
                        HStack{
                            TextField("+91", text: $viewModel.userCountryCode).disabled(true)
                                .textFieldStyle(CustomTxtFieldStyle())
                                .frame(width: 70)
                            TextField("Mobile Number", text: $viewModel.userMobile).disabled(true)
                                .keyboardType(.numberPad)
                                .textFieldStyle(CustomTxtFieldStyle())
                        }
                        .padding(.bottom, 5)
                        TextField("Select DOB", text: $viewModel.userDOB)
                            .textFieldStyle(CustomTxtFieldStyle())
                            .keyboardType(.emailAddress)
                            .padding(.bottom, 5)
                            .onTapGesture {
                                isDatePickerVisible = true
                                hideKeyboard()
                            }
                            .onDisappear {
                                hideKeyboard()
                            }
                            .sheet(isPresented: $isDatePickerVisible) {
                                CustomDatePickerView(isPickerVisible: $isDatePickerVisible, selectedDate: $viewModel.selectedDOB, selectedDateString: $viewModel.userDOB, placeholder: "")
                                    .presentationDragIndicator(.hidden)
                                    .presentationDetents([.height(285)])
                            }
//                        DatePicker("Select DOB", selection: $viewModel.selectedDOB, in: dateClosedRange, displayedComponents: .date)
//                            .padding(.all, 10)
//                            .background(CustomGraditantView())
//                            .padding(.bottom, 5)
                        TextField("Gender", text: $viewModel.userGender)
                            .textFieldStyle(CustomTxtFieldStyle())
                            .padding(.bottom, 20)
                            .contextMenu {
                                Menu {
                                    Button(action: {
                                        self.isMenuOpen = false
                                        self.viewModel.userGender = "Male"
                                    }) {
                                        Label("Male", systemImage: "person")
                                    }
                                    Button(action: {
                                        self.isMenuOpen = false
                                        self.viewModel.userGender = "Female"
                                    }) {
                                        Label("Female", systemImage: "person.fill")
                                    }
                                    Button(action: {
                                        self.isMenuOpen = false
                                        self.viewModel.userGender = "Other"
                                    }) {
                                        Label("Other", systemImage: "person.3")
                                    }
                                } label: {
                                    Label("Select Gender", systemImage: "arrowtriangle.down.fill")
                                }
                            }
                            .onTapGesture {
                                hideKeyboard()
                            }
                        Button(action: {
                            viewModel.editProfile()
                        }, label: {
                            Text("Edit Profile")
                        }).buttonStyle(CustomBtn())
                            .alert(isPresented: $viewModel.showAlert) {
                                if  viewModel.isProfileUpdated {
                                    return Alert(title: Text("Alert"), message: Text("Update Profile Successfull !!"), dismissButton: .default(Text("OK")) {
                                        self.presentationMode.wrappedValue.dismiss()
                                    })
                                } else  {
                                    return Alert(title: Text("Alert"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                                    })
                                }
                            }
                    }
                    .modifier(CustomHideKeyboardModifier())
                    .toolbar(.hidden, for: .tabBar)
                    .padding()
                    .navigationBarTitle("EDIT PROFILE", displayMode: .inline)
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: CustomBackButton())}
            }
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: EditProfileViewModel(iSessionManager: nil, iUserData: nil))
    }
}
