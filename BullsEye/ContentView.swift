//
//  ContentView.swift
//  BullsEye
//
//  Created by Jacco Mulders on 24/03/2020.
//  Copyright © 2020 Jacco Mulders. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.black)
                .foregroundColor(.green)
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }.alert(isPresented: self.$alertIsVisible){
                Alert(title: Text("Hello there!"),
                    message: Text("This is my first pop-up."),
                    dismissButton: .default(Text("Awesome!")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
