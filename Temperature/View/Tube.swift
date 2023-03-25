//
//  Tube.swift
//  Temperature
//
//  Created by vijay verma on 24/03/23.
//

import SwiftUI

struct Tube: View {
    @State var progress: CGFloat = 0.25
    @State var startAnimation: CGFloat = 0
    @State private var position = CGPoint(x: 100, y: 0)
    @State private var dragOffset = CGSize.zero
    let maskSize = CGSize(width: 122, height: 400)
    @State private var sliderValue = 0.5
    
    
    @State var maxHeight: CGFloat = 420
    //Slider properties
    @State var sliderHeight: CGFloat = 0
    @State var sliderProgress: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View {
        
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1), Color(red: 0.96, green: 0.96, blue: 0.97, opacity: 1)]), startPoint: .init(x: 0.5, y: 0.75), endPoint: .init(x: 1.0, y: 1.0))
                .edgesIgnoringSafeArea(.all)
            GeometryReader{ proxy in
                let size = proxy.size
                ZStack {
                    ZStack {
                        ZStack(alignment: .top, content: {
                            Text("\(Int((sliderProgress*(30))+20 ))")
                                .fontWeight(.bold)
                                .foregroundColor(Color(UIColor(hex: "#DFE5F1")))
                                .padding(.vertical, 10)
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 18)
                                .font(.system(size: 120))
                                .cornerRadius(12)
                            Text("°")
                                .fontWeight(.regular)
                                .foregroundColor(Color(UIColor(hex: "#DFE5F1")))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 18)
                                .font(.system(size: 80))
                                .cornerRadius(12)
                                .offset(x: 100)
                        })
                    }
                    .frame(width: size.width, height: size.height, alignment: .top)
                    //                    ZStack {
                    //                        Text("\(Int(-sliderHeight)) \(Int(-(maxHeight - 48)))")
                    //                            .fontWeight(.bold)
                    //                            .foregroundColor(.black)
                    //
                    //                            .font(.system(size: 20))
                    //                            .background(.white)
                    //                            .cornerRadius(12)
                    //                    }
                    //                    .frame(width: size.width, height: size.height, alignment: .bottom)
                    
                    
                    //Marker
                    ZStack(alignment: .bottom, content:{
                        Rectangle()
                            .fill(Color(UIColor(hex: "#DFE5F1")).opacity(0.5))
                            .frame(width: 52, height: 430, alignment: .bottom)
                        Rectangle()
                            .fill(Color(UIColor(hex: "#A1A7B4")).opacity(0.8))
                            .frame(width: 52, height: sliderHeight, alignment: .bottom)
                    })
                    .frame(width: 52, height: 430, alignment: .bottom)
                    .mask(Image("mark-num"))
                    .offset(x:-120)
                    
                    //Tube
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(UIColor(hex: "#EE3A32")),
                                    Color(UIColor(hex: "#EF803B")),
                                    Color(UIColor(hex: "#EBAC38")),
                                    Color(UIColor(hex: "#D7C05E")),
                                    Color(UIColor(hex: "#ABC770")),
                                    Color(UIColor(hex: "#55C1DC")),
                                ]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 50, height: 406)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 32)
                            .opacity(0.8)
                            .offset(x: -50, y: 0)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(UIColor(hex: "#ECECEC")),
                                    Color(UIColor(hex: "#FFFFFF")),
                                    
                                ]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 96, height: 456)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .opacity(0.8)
                        
                        WaterWaveS(progress: sliderProgress, waveHeight: 0.04, offset: startAnimation+190)
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
                            .overlay(
                                Capsule()
                                    .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                            lineWidth: 1)
                                    .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 0)
                                    .clipShape(
                                        Capsule()
                                    )
                            )
                        
                        WaterWaveS(progress: sliderProgress, waveHeight: 0.04, offset: startAnimation)
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
                            .opacity(0.5)
                        RoundedRectangle(cornerRadius: 54)
                            .strokeBorder(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8), Color(red: 0.93, green: 0.94, blue: 0.97, opacity: 1)]), startPoint: .top, endPoint: .bottom)
                                , lineWidth: 6)
                            .frame(width: 108, height: 468)
                        
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 25, height: 390)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 6)
                            .opacity(0.6)
                            .blendMode(.overlay)
                            .offset(x: 18, y: 0)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 10, height: 370)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 4)
                            .opacity(0.4)
                            .blendMode(.overlay)
                            .offset(x: -20, y: 0)
                        //                    RoundedRectangle(cornerRadius: 53)
                        //                        .stroke(Color(red: 1, green: 1, blue: 1, opacity: 0.5), lineWidth: 5)
                        //                        .frame(width: 104, height: 466)
                    }
                    
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .onAppear{
                        //Looping animation
                        withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)){
                            //loop will not finish if staranimation will be larger than rect width
                            startAnimation = size.width
                        }
                    }
                    
                    ZStack{
                        //Other stack for slider
                        VStack {
                            ZStack{
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(UIColor(hex: "#EE3A32")),
                                    Color(UIColor(hex: "#EBAC38")),
                                    Color(UIColor(hex: "#D7C05E")),
                                    Color(UIColor(hex: "#55C1DC")),
                                ]),
                                               startPoint: .init(x: 0.5, y: 0.0),
                                               endPoint: .init(x: 0.5, y: 1.0))
                                
                                .frame(height: 1000)
                                .cornerRadius(10)
                                .padding(8)
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 100, height: 100)
                                    .blur(radius: 8)
                            }
                            .mask(Image("curve-nob"))
                            .offset(x: -20, y: position.y + 210 - sliderHeight)
                        }
                        .frame(width: 200)
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .black, .clear]), startPoint: .top, endPoint: .bottom)
                                .frame(height: maxHeight + 100)
                        )
                        
                        VStack {
                            // Slider...
                            
                            ZStack(alignment: .bottom, content: {
                                Rectangle()
                                    .fill(Color(.gray).opacity(0.01))
                                
                                
                                // - (maxheight - 48)
                                //sliderHeight <= max ? -sliderHeight : -(sliderHeight - 48)
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
                            
                        }.offset( y:0)
                        VStack{
                            Image("nob") // Replace "myImage" with the name of your image file
                                .resizable()
                                .frame(width: 48, height: 48)
                                .offset(x: 0, y: -sliderHeight  )
                        }
                        .frame(width: 120, height: maxHeight+48, alignment: .bottom)
                        .zIndex(-1)
                    }
                    .frame(width: 200, height: 600)
                    .offset(x: 130)
                    
                    
                }
                
            }
            
            
            
            
            
            
        }
        
        
    }
    
}


struct Tube_Previews: PreviewProvider {
    static var previews: some View {
        Tube()
    }
}

