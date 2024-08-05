//
//  SignUpView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 24/08/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct SignUpView: View {
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        return min...max
    }
    
    @State private var isDatePickerVisible = false
    @State private var isPickerVisible = false
    @State private var isMenuOpen = false
    @StateObject private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack {
                    EditableCircularProfileImage(selectedImageData: self.$viewModel.selectedImageData, selectedImage: self.$viewModel.selectedImage, selectedItem: self.$viewModel.selectedItem)
                        .padding(.bottom, 20)
                    TextField("Name", text: $viewModel.userName)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom, 5)
                    TextField("Email", text: $viewModel.userEmail)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .keyboardType(.emailAddress)
                        .padding(.bottom, 5)
                    HStack{
                        TextField("+91", text: $viewModel.userCountryCode)
                            .textFieldStyle(CustomTxtFieldStyle())
                            .frame(width: 70)
                            .onTapGesture {
                                isPickerVisible = true
                                hideKeyboard()
                            }
                            .onDisappear {
                                hideKeyboard()
                            }
                            .sheet(isPresented: $isPickerVisible) {
                                CustomCountryPickerView(selectedCountryCode: $viewModel.userCountryCode, isCountryPickerVisible: $isPickerVisible)
                            }
                        TextField("Mobile Number", text: $viewModel.userMobile)
                            .keyboardType(.numberPad)
                            .textFieldStyle(CustomTxtFieldStyle())
                    }
                    .padding(.bottom, 5)
                    TextField("Select DOB", text: $viewModel.userDOB)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .keyboardType(.emailAddress)
                        .padding(.bottom, 5)
                        .onTapGesture {
                            hideKeyboard()
                            isDatePickerVisible = true
                        }
                        .onDisappear {
                            hideKeyboard()
                        }
                        .sheet(isPresented: $isDatePickerVisible) {
                            CustomDatePickerView(isPickerVisible: $isDatePickerVisible, selectedDate: $viewModel.selectedDOB, selectedDateString: $viewModel.userDOB, placeholder: "")
                                .presentationDragIndicator(.hidden)
                                .presentationDetents([.height(285)])
                        }
//                    DatePicker("Select DOB", selection: $viewModel.selectedDOB, in: dateClosedRange, displayedComponents: .date)
//                        .padding(.all, 10)
//                        .background(CustomGraditantView())
//                        .padding(.bottom, 5)
                    TextField("Gender", text: $viewModel.userGender)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom, 5)
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
                    SecureField("Password", text: $viewModel.userPassword)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom, 5)
                    SecureField("Confirm Password", text: $viewModel.userConfirmPassword)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom)
                    Button(action: {
                        viewModel.signUp()
                    }, label: {
                        Text("Sign UP")
                    }).buttonStyle(CustomBtn())
                        .alert(isPresented: $viewModel.showAlert) {
                            if  viewModel.isLoggedIn {
                                return Alert(title: Text("Alert"), message: Text("Registration Successfull !!"), dismissButton: .default(Text("OK")) {
                                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                                    changeRequest.photoURL = URL(string: self.viewModel.user?.profilePic ?? "")
                                    changeRequest.displayName = self.viewModel.user?.name ?? ""
                                    changeRequest.commitChanges { error in
                                        if let error = error {
                                            print("Error updating profile : \(error.localizedDescription)")
                                        } else {
                                            print("Profile updated successfully!")
                                        }
                                    }
                                    self.viewModel.sessionManager?.loggedUser = self.viewModel.loggedInUser
                                })
                            } else  {
                                return Alert(title: Text("Alert"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                                })
                            }
                        }
                }
                .padding()
                .navigationBarTitle("SIGNUP", displayMode: .inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: CustomBackButton())
            }
            .modifier(CustomHideKeyboardModifier())
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(iSessionManager: nil))
    }
}
