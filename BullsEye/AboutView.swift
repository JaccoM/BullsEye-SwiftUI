//
//  AboutView.swift
//  BullsEye
//
//  Created by Jacco Mulders on 23/04/2020.
//  Copyright © 2020 Jacco Mulders. All rights reserved.
//

import SwiftUI

// Content
struct AboutView: View {
    // Variables
    // Colors
    let beige = Color(red: 1.0,
                      green: 0.84,
                      blue: 0.70)
    
    var body: some View {
        Group{
            VStack{
                    Text("🎯 BullsEye 🎯")
                        .modifier(AboutHeadingStyle())
                    Text("Dit is BullsEye, een spel waarbij je punten kan winnen met sliden.")
                        .modifier(AboutBodyStyle())
                        .lineLimit(nil)
                    Text("Het doel is om de BullsEye zo dicht mogelijk bij het doelwit te krijgen. Hoe dichterbij, hoe meer punten je krijgt.")
                        .modifier(AboutBodyStyle())
                    Text("Veel plezier!")
                        .modifier(AboutBodyStyle())
                }
            .background(beige)
            }
        .background(Image("Background"))
        }
}

// View Modifiers
struct AboutHeadingStyle: ViewModifier{
    func body(content : Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(Color.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier{
    func body(content : Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

// Preview
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
