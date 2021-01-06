//
//  AddEmployee.swift
//  URLSessianGET_POST
//
//  Created by Artyom Romanchuk on 06.01.2021.
//

import Foundation
import SwiftUI


struct AddEmployee: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var user: User = User()
    @State var showAlert = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                Api().addEmployee { (user) in
                    self.user = user
                    self.showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(user.title ?? ""),
                    message: Text("Added \(user.body ?? "" ) successfully"),
                    dismissButton: Alert.Button.default(Text("Go Back"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                )
            }
    }
}
