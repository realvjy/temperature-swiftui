//
//  WaterWave.swift
//  Temperature
//
//  Created by vijay verma on 24/03/23.
//


import SwiftUI

struct WaterWave: View {
    @State private var waveOffset: CGFloat = 0
        
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                Path { path in
                    let width = UIScreen.main.bounds.width
                    let height = UIScreen.main.bounds.height
                    let midY = height / 2
                    let waveWidth = CGFloat(0.8)
                    let xOffset = waveOffset * width
                    path.move(to: CGPoint(x: 0, y: midY))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: width, y: midY))
                    path.addCurve(to: CGPoint(x: 0, y: midY),
                                  control1: CGPoint(x: width * waveWidth * 0.25 + xOffset, y: height * 0.75),
                                  control2: CGPoint(x: width * waveWidth * 0.75 + xOffset, y: height * 0.25))
                }
                .fill(Color.white)
                .opacity(0.4)
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever()) {
                    self.waveOffset = 1
                }
            }
        }
}

struct WaterWave_Previews: PreviewProvider {
    static var previews: some View {
        WaterWave()
    }
}
