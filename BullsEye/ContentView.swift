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
        VStack {
            Spacer()
            HStack {
                // Hint Row
                Text("Sleep de BullsEye naar de:")
                Text("\(target)")
            }
            Spacer()
            HStack {
                // Slider Row
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            HStack {
                // Button Row
                Button(action: {
                    print("Punten verdiend: \(self.pointsForCurrentRound())")
                    self.alertIsVisible = true
                }) {
                    Text("Gooien!")
                }.alert(isPresented: $alertIsVisible){
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
                    Text("Opnieuw")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Help")
                }
            }
            .padding(.bottom, 20)
        }
        .onAppear(){
            self.startNewGame()
        }
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
        sliderValue = 50.0
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone X")
    }
}
