//
//  ContentView.swift
//  DungeonDice
//
//  Created by JUAREZ HERNANDEZ, BETSABE on 2/5/26.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable, Identifiable {
        
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var id: Int {
            return rawValue // Eash rawValue is unique, so it's a good ID
        }
        
        var description : String { "\(rawValue)-sided"
        }
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
    @State private var animationTrigger = false // changed when animation occured
    @State private var isDoneAnimating = true

    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
        
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                .frame(height:150)
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false // set to beginning "false" state right away
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))]) {
                ForEach(Dice.allCases) { dice in Button(dice.description) { resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                    animationTrigger.toggle() // a change of this value triggers an animation
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
