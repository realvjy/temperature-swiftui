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
    let menuItems = [
        ("Menu 1", "cold"),
        ("Menu 2", "normal"),
        ("Menu 3", "fire")
    ]
    @State private var selectedMenuIndex = 1
    @State private var backgroundColor = Color(UIColor(hex: "#A4FFEF"))
    
    // selected item index
    @State private var selectedMenu = 0
    
    // slide background position
    @State private var backgroundOffset: CGFloat = 0
    @State private var previousSelectedMenu = 0
    
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
                    .offset(y: -10)
                    
                    
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
                            .frame(width: 26, height: 390)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 7)
                            .opacity(0.5)
                            .blendMode(.overlay)
                            .offset(x: 16, y: 0)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 12, height: 370)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 4)
                            .opacity(0.3)
                            .blendMode(.overlay)
                            .offset(x: -24, y: 0)
                        
                    }
                    
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .onAppear{
                        //Looping animation
                        withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)){
                            //loop will not finish if staranimation will be larger than rect width
                            startAnimation = size.width
                        }
                    }
                    
                    ZStack{
                        //Other stack for slider
                        VStack {
                            ZStack{
                                
                                Rectangle()
                                    .fill(getModifiedColor(Color.teal))
                                    .frame(height: 1000)
                                    .cornerRadius(10)
                                    .padding(8)
                                
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 100, height: 100)
                                    .blur(radius: 8)
                            }
                            .mask(Image("curve-nob"))
                            .offset(x: -24, y: position.y + 210 - sliderHeight)
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
                                
                                switch sliderProgress {
                                case 0..<0.5:
                                    backgroundColor = Color(UIColor(hex: "#A4FFEF"))
                                    selectedMenu = 0
                                case 0.5..<0.8:
                                    backgroundColor = Color(UIColor(hex: "#FFEDAE"))
                                    selectedMenu = 1
                                default:
                                    backgroundColor = Color(UIColor(hex: "#FFC5C5"))
                                    selectedMenu = 2
                                }
                                    
                                
                                
                            }).onEnded({ (value) in
                                
                                // Storing las drag value for restorating
                                
                                sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                                
                                // Negative height...
                                
                                sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                                
                                lastDragValue = sliderHeight
                                
                                
                            }))
                            
                        }.offset( y:0)
                        VStack{
                            Image("nob")
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
            
            VStack{
                Spacer()
                HStack(spacing: 20) {
                    MenuButton(imageName: "cold", label: "cold", isSelected: selectedMenu == 0)
                        .scaleEffect(selectedMenu == 0 ? 1.2 : 1.0) // Scale up when selected
                        .onTapGesture {
                            backgroundColor = Color(UIColor(hex: "#A4FFEF"))
                            previousSelectedMenu = selectedMenu
                            sliderProgress = 0
                            withAnimation {
                                self.selectedMenu = 0
                            }
                        }
                    MenuButton(imageName: "normal", label: "normal", isSelected: selectedMenu == 1)
                        .scaleEffect(selectedMenu == 1 ? 1.2 : 1.0) // Scale up when selected
                        .onTapGesture {
                            backgroundColor = Color(UIColor(hex: "#FFEDAE"))
                            previousSelectedMenu = selectedMenu
                            sliderProgress = 0.5
                            
                            withAnimation {
                                self.selectedMenu = 1
                            }
                        }
                    
                    MenuButton(imageName: "fire", label: "fire", isSelected: selectedMenu == 2)
                        .scaleEffect(selectedMenu == 2 ? 1.2 : 1.0) // Scale up when selected
                        .onTapGesture {
                            backgroundColor = Color(UIColor(hex: "#FFC5C5"))
                            previousSelectedMenu = selectedMenu
                            sliderProgress = 1
                            withAnimation {
                                self.selectedMenu = 2
                            }
                        }
                }
                
                .background(
                    GeometryReader { proxy in
                        let iconWidth = CGFloat(60) // change this to the actual width of your icon
                        let backgroundWidth = proxy.size.width / 3
                        let extraOffset = (proxy.size.width - backgroundWidth * 3 - 10) / 2 // calculate extra offset for first and last background
                        let menuOffset = CGFloat(selectedMenu) * (backgroundWidth + 10)
                        let centerOffset = (backgroundWidth - iconWidth) / 2
                        let leadingOffset = centerOffset + menuOffset + extraOffset * (selectedMenu == 0 ? -1 : selectedMenu == 2 ? 1 : 0)

                     
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(backgroundColor)
                            .frame(width: iconWidth, height: proxy.size.height)
                            .offset(x: leadingOffset - 10)
                            .blur(radius: 7)
                            .animation(.easeInOut(duration: 0.3), value: selectedMenu)
                            .opacity(0.5)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedMenu = 2
                                }
                            }
                    }
                )
                .frame(maxWidth: .infinity)
                    .padding(.horizontal, 30)
   
            }
            .offset(y: -10)
            
        }
        
        
    }
    
    
    
    private func getModifiedColor(_ color: Color) -> Color {
        let teal = Color.teal
        let green = Color.green
        let yellow = Color.yellow
        let orange = Color.orange
        let red = Color.red
        
        switch sliderProgress {
        case 0..<0.125:
            return blendColors(teal, green, fraction: sliderProgress / 0.125)
        case 0.125..<0.25:
            return blendColors(green, yellow, fraction: (sliderProgress - 0.125) / 0.125)
        case 0.25..<0.5:
            return blendColors(yellow, orange, fraction: (sliderProgress - 0.25) / 0.25)
        case 0.5..<0.75:
            return blendColors(orange, red, fraction: (sliderProgress - 0.5) / 0.25)
        case 0.75...1:
            return red
        default:
            return color
        }
    }
    
    private func blendColors(_ color1: Color, _ color2: Color, fraction: Double) -> Color {
        let cgColor1 = color1.cgColor
        let cgColor2 = color2.cgColor
        
        guard let components1 = cgColor1?.components, let components2 = cgColor2?.components else {
            return color1
        }
        
        let red = components1[0] * (1 - fraction) + components2[0] * fraction
        let green = components1[1] * (1 - fraction) + components2[1] * fraction
        let blue = components1[2] * (1 - fraction) + components2[2] * fraction
        let alpha = components1[3] * (1 - fraction) + components2[3] * fraction
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
}


struct Tube_Previews: PreviewProvider {
    static var previews: some View {
        Tube()
    }
}


struct MenuButton: View {
    var imageName: String
    var label: String
    var isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .center, content:{
            Image(imageName)
                //.foregroundColor(isSelected ? .blue : .gray)
                .frame(width: 48, height: 48)
            Rectangle()
                .fill(Color(UIColor(hex: "#DFE5F1")).opacity(isSelected ? 0.0 : 1.0))
                .frame(width: 52, height: 430, alignment: .bottom)
                
        })
        .mask(Image(imageName))
        .frame(width: 48, height: 48)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        
    }
}
