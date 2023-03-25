//
//  ContentView.swift
//  Temperature
//
//  Created by vijay verma on 24/03/23.
//

import SwiftUI


struct ContentView: View {
    @State private var waveOffset: CGFloat = 0
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    @State var waterFill: CGFloat = 0.5
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1), Color(red: 0.93, green: 0.94, blue: 0.97, opacity: 1)]), startPoint: .init(x: 0.0, y: 0.75), endPoint: .init(x: 1.0, y: 1.0))
                .edgesIgnoringSafeArea(.all)
            Tube()
            
        }


//        VStack {
//            WaterWave()
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//                Text("Hello, world!")
//            }
//            .padding()
//            Spacer()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

