//
//  Home.swift
//  Temperature
//
//  Created by vijay verma on 24/03/23.
//  This is testing out screen. Check Tube.swift for final code

import SwiftUI


struct Home: View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var sliderProgress: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    var body: some View {
        VStack{

            // Mark: Wave Form
            GeometryReader{proxy in
                let size = proxy.size
                
                ZStack {
                    
                  
                    WaterWaveS(progress: progress, waveHeight: 0.02, offset: startAnimation)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(UIColor(hex: "#EE3A32")),
                                Color(UIColor(hex: "#EF803B")),
                                Color(UIColor(hex: "#EBAC38")),
                                Color(UIColor(hex: "#D7C05E")),
                                Color(UIColor(hex: "#ABC770")),
                                Color(UIColor(hex: "#55C1DC")),
                            ]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 96, height: 456)
                        .mask(RoundedRectangle(cornerRadius: 48))

                    //Water Drops shapes
                        .overlay(content: {
                            ZStack{
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                
                                Circle()
                                    .fill(.white.opacity(0.2))
                                    .frame(width: 15, height: 15)
                                    .offset(x:40, y: 30)
                                Circle()
                                    .fill(.white.opacity(0.2))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -30, y: 80)
                                
                                Circle()
                                    .fill(.white.opacity(0.2))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y: 100)
                                
                                Circle()
                                    .fill(.white.opacity(0.2))
                                    .frame(width: 20, height: 20)
                                    .offset(x: 50, y: 70)
                            }
                        })
                    
                    //Masking in drop
//                        .mask {
//                            Image(systemName: "square.fill")
//                                .resizable()
//                                .renderingMode(.template)
//                                .aspectRatio(contentMode: .fit)
//                                .padding(20)
//                        }
                    // Add button
                        .overlay(alignment: .bottom) {
//                            Button{
//                                progress += 0.01
//                            } label: {
//                                Image(systemName: "plus")
//                                    .font(.system(size: 40, weight: .black))
//                                    .foregroundColor(Color(.blue))
//                                    .shadow(radius: 2)
//                                    .padding(25)
//                                    .background(.white, in: Circle())
//                            }
//                            .offset(y: 40)
                        }
                    
                }
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear{
                        //Looping animation
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: false)){
                        //loop will not finish if staranimation will be larger than rect width
                        startAnimation = size.width
                    }
                }
                
            }
            VStack {
                // Slider...
                
                ZStack(alignment: .bottom, content: {
                    Rectangle()
                        .fill(Color(.gray).opacity(0.15))
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: sliderHeight)
                })
                .frame(width: 120, height: maxHeight)
                .cornerRadius(32)
                .gesture(DragGesture(minimumDistance: 0).onChanged({ (value) in
                    //getting dragvalue...
                    let translation = value.translation
                    
                    sliderHeight = -translation.height + lastDragValue
                    
                    //Limiing slide height value
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    //updating progress
                    let progres = sliderHeight / maxHeight
                    sliderProgress = progres <= 1.0 ? progres : 1
                    
                    
                }).onEnded({ (value) in
                    
                    // Storing las drag value for restorating
                    
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    // Negative height...
                    
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    lastDragValue = sliderHeight
                    
                    
                    
                    
                }))
                .overlay(
                    Text("\(Int(sliderProgress * 100))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 18)
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.vertical, 25)
                        .offset(y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight+105)
                    ,alignment: .bottom
                )
            }
            Slider(value: $progress)
                
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)

    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct WaterWaveS: Shape{
    
    var progress: CGFloat
    
    // Wave Height
    var waveHeight: CGFloat
    // Initial Animation Start
    
    var offset: CGFloat

    //Enabling animation
    
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: .zero)
            
            //Mark: Drawing Waves using Sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            
            for value in stride(from: 0, through: rect.width, by: 1){
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
//                let sine: CGFloat = sin(1)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
                
            }
            
            // Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}


