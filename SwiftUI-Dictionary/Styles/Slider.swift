//
//  Slider.swift
//  SwiftUI-Functionalities
//
//  Created by Marcus Arkan on 11/23/22.
//

import SwiftUI

struct Slider_Styles: View {
    
    @State private var sliderValue: Double = 1.5
    
    @State private var color: Color = .blue
    
    var body: some View {
        VStack {
            
            //MARK: FORMAT NUMBERS
            
            //FIRST WAY TO CONVERT A LONG DIGIT NUMBER TO TWO DECIMAL PLACES
            Text("Rating#1:  \(sliderValue, format: .number)")
            
            //SECOND WAY TO CONVERT A LONG DIGIT NUMBER TO ANY DECIMAL PLACE OF YOUR CHOOSING BY CHANGING '%.2f" THE NUMBER '2' IN THAT STRING TO PUSH THE DECIMAL PLACES UP OR DOWN.
            HStack{
                Text("Rating#2: ")
                Text(String(format: "%.2f",  sliderValue))
            }.padding()
                .foregroundColor(color)

            
            //MARK: Sliders
            //THREE DIFFERENT SLIDER TYPES BELOW

//            Slider(value: $sliderValue)
//                .tint(.red)
//            Slider(value: $sliderValue, in: 1...5)
//            Slider(value: $sliderValue, in: 1...6, step: 1.5)
            
            
            //Slider below is a bit more complicated with a conditional logic and a text for starting and another one for the ending.
            Slider(
                   value: $sliderValue,
                   in: 1...5,
                   step: 1.0) {
                   } minimumValueLabel: {
                       Text("1")
                   } maximumValueLabel: {
                       Text("5")
                   } onEditingChanged: { _ in
                       //conditional logic to change colors when it reaches above 3
                       withAnimation(.easeOut(duration: 1)) {
                           if sliderValue <= 3 {
                               color = .blue
                           } else
                           {
                               color = .red
                           }
                       }
                   }


        }.tint(.purple).padding()
    }
}

struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        Slider_Styles()
    }
}
