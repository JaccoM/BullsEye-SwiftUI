//
//  ContentView.swift
//  BullsEye
//
//  Created by Jacco Mulders on 24/03/2020.
//  Copyright © 2020 Jacco Mulders. All rights reserved.
//

import SwiftUI

// Content
struct ContentView: View {
    // Variables
    // Colors
    let midnightBlue = Color(red: 0,
                             green: 0.2,
                             blue:0.4)
    // Game
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    // UI
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    
    // Computed Properties
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer().navigationBarTitle("🎯 BullsEye 🎯")
                HStack {
                    // Hint Row
                    Text("Sleep de BullsEye naar de:")
                    .modifier(LabelStyle())
                    Text("\(target)")
                    .modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    // Slider Row
                    Text("1")
                    .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor((Color.green))
                        .animation(.easeOut)
                    Text("100")
                    .modifier(LabelStyle())
                }
                Spacer()
                HStack {
                    // Button Row
                    Button(action: {
                        print("Punten verdiend: \(self.pointsForCurrentRound())")
                        self.alertIsVisible = true
                    }) {
                        Text("Gooien!")
                        .modifier(ButtonLargeTextStyle())
                    }
                    .background(Image("Button")
                        .modifier(Shadow())
                    )
                    .alert(isPresented: $alertIsVisible){
                        Alert(title: Text(alertTitle()),
                              message: (Text(scoringMessage())),
                              dismissButton: .default(Text("Nog een keer!")) {
                                self.startNewRound()
                            })
                    }
                }
                Spacer()
                HStack {
                    // Score Row
                    Button(action: {
                        self.startNewGame()
                    }) {
                        HStack{
                            Image("StartOverIcon")
                            Text("Opnieuw").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background((Image("Button"))
                        .modifier(Shadow())
                    )
                    Spacer()
                    Text("Score:")
                    .modifier(LabelStyle())
                    Text("\(score)")
                    .modifier(ValueStyle())
                    Spacer()
                    Text("Round:")
                    .modifier(LabelStyle())
                    Text("\(round)")
                    .modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack{
                            Image("InfoIcon")
                            Text("Help").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background((Image("Button"))
                        .modifier(Shadow())
                    )
                }
                .padding(.bottom, 20)
                .accentColor(midnightBlue)
            }
            .onAppear(){
                self.startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Methods
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        
        return points
    }
    
    func scoringMessage() -> String {
        return "De BullsEye staat op \(sliderValueRounded).\n" +
        "Je hebt daarmee \(pointsForCurrentRound()) punten verdiend deze ronde."
    }
    
    func alertTitle() -> String {
        let title: String
        
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference == 1 {
            title = "Beste van de verliezers"
        } else if sliderTargetDifference < 5 {
            title = "Zo dichtbij..."
        } else if sliderTargetDifference < 10 {
            title = "Niet goed, niet slecht."
        } else {
            title = "Meen jij da?"
        }
        
        return title
    }
    
    func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
    
    func startNewRound(){
        score = score + pointsForCurrentRound()
        round = round + 1
        resetSliderAndTarget()
    }
    
    func startNewGame(){
        score = 0
        round = 1
        resetSliderAndTarget()
    }
}

// View Modifiers
struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .foregroundColor(Color.white)
        .modifier(Shadow())
    }
}

struct ValueStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
    }
}

struct Shadow: ViewModifier{
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .foregroundColor(Color.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 12))
        .foregroundColor(Color.black)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone X")
    }
}
