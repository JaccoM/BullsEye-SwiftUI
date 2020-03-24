//
//  ContentView.swift
//  BullsEye
//
//  Created by Jacco Mulders on 24/03/2020.
//  Copyright © 2020 Jacco Mulders. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Variables
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                // Hint Row
                Text("Breng de BullsEye naar de:")
                Text("100")
            }
            Spacer()
            HStack {
                // Slider Row
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            HStack {
                // Button Row
                Button(action: {
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!")
                }.alert(isPresented: self.$alertIsVisible){
                    Alert(title: Text("Hey!"),
                          message: Text("Waarde van de slider is \(Int(self.sliderValue.rounded()))."),
                          dismissButton: .default(Text("Awesome!")))
                }
            }
            Spacer()
            HStack {
                // Score Row
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("New Game")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                Spacer()
                Text("Round:")
                Text("999")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone X")
    }
}
