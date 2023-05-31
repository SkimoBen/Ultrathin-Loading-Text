//
//  ContentView.swift
//  Ultrathin Loading Text
//
//  Created by Ben Pearman on 2023-05-31.
//

import SwiftUI

struct ContentView: View {
    @State var failure = "sorry"
    var body: some View {
       ProgressView(failure: $failure)
    }
}

struct ProgressView: View {
    @State var materialOpacity: Double = 0.97
    @Binding var failure: String
    var body: some View {
        ZStack {
            TextProgressView(failure: $failure)

            VStack {

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Material.thinMaterial.opacity(materialOpacity), ignoresSafeAreaEdges: .all)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                    materialOpacity = materialOpacity == 0.97 ? 0.6 : 0.97
                }
            }
        }
    }
}



struct TextProgressView: View {
    var loadingText: String = "A team of pixies is working hard to make something beautiful for you"
    var failureText: String = "Sorry, even pixies need a break sometimes. Maybe they'll do better in a few minutes."
    var loadingColours: [Color] = [.cyan, .blue, .red]
    var failureColours: [Color] = [.red, .primary]
    @State var animatedHue = false
    @State var animatedPosition = false
    @Binding var failure: String
    @State var animatedPadding = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                Text(failure.isEmpty ? loadingText : failureText)
                    .font(
                        .system(size: 500)
                        .bold()
                    )
                    .foregroundColor(animatedHue ? Color.red : Color.cyan)
                    .opacity(animatedPadding ? 0.0 : 0.5)
                
                    .padding(.top, 20)
                    .padding(animatedPadding ? geometry.size.width * 0.05 : 10)
                    .padding(.leading, geometry.size.width * 0.05)
                
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.leading)
                    //.offset(x: animatedHue ? geometry.size.width * 0.02 : 0, y: animatedPosition ? geometry.size.width * 0.2 : 0)
                
                if failure.isEmpty {
                    Text("Keep this open, or they might fly away")
                        .opacity(animatedPadding ? 0.0 : 0.2)
                } else {
                    Text("You'll have to try again :P")
                }
                
            }
            .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                .overlay {
                    LinearGradient(
                        colors: failure.isEmpty ? loadingColours : failureColours,
                        startPoint: animatedPosition ? .topLeading : .bottomLeading,
                        endPoint:  animatedPosition ? .bottomTrailing : .topTrailing
                        
                    )
                    .hueRotation(.degrees(animatedHue ? 90 : 0))
                    .onAppear {
                        withAnimation(
                            .linear(duration: 5.0)
                            
                            .repeatForever()
                        ){
                            animatedPosition.toggle()
                       
                        }
                        withAnimation(
                            .linear(duration: 7.0)
                            
                            .repeatForever(autoreverses: true)
                        ){
                           animatedHue.toggle()
                        }
                        withAnimation(
                            .linear(duration: 15.0)
                            
                            .repeatForever(autoreverses: true)
                        ){
                           animatedPadding.toggle()
                        }
                    }
                    .mask(
                        VStack {
                            Text(failure.isEmpty ? loadingText : failureText)
                                .font(
                                    .system(size: 500)
                                    .bold()
                                    
                                )
                                .padding(.top, 20)
                                .padding(10)
                                //.padding(.leading, geometry.size.width * 0.03)
                                .minimumScaleFactor(0.01)
                                .multilineTextAlignment(.leading)
                            
                            if failure.isEmpty {
                                Text("Keep this open, or they might fly away")
                            } else {
                                Text("You'll have to try again :P")
                            }
                            
                            
                        }
                            .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                            
                        
                        
                            
                    )
                }
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
