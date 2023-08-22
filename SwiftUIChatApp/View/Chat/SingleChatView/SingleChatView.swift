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
