//
//  ContentView.swift
//  SlotMachine
//
//  Created by Selin Çağlar on 18.01.2023.
//

import SwiftUI


//MARK: -  PROPERTIES
struct ContentView: View {
//MARK: - BODY
    var body: some View {
        ZStack {
            
            //MARK:  BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            //MARK:  INTERFACE
            VStack(alignment: .center, spacing: 5) {
                
                //MARK: - HEADER
                LogoView()
                Spacer()
                
                //MARK: - SCORE
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifies())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    HStack{
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifies())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                        
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                //MARK: - SLOT MACHINE
                    //mark:reel 1
                VStack (alignment: .center, spacing: 0){
                    ZStack{
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    HStack(alignment: .center, spacing: 0){
                        //mark:reel  2
                        ZStack{
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        //mark:reel 3
                        ZStack{
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                        //mark:spın button
                    Button(action: {
                        print("Spin the reels")
                    }){
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                }//slotmachine vstack
                .layoutPriority(2)
                
                
                //MARK: - FOOTER
                Spacer()
                HStack{
                    //mark: bet 20
                    HStack (alignment: .center, spacing: 10){
                        Button(action: {
                            print("Bet 20 coins")
                        }){
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifiers())
                        }
                        .modifier(BetCapsuleModifiers())
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifiers())
                    }
                    //mark: bet 10
                    HStack (alignment: .center, spacing: 10){
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifiers())
                        
                        Button(action: {
                            print("Bet 10 coins")
                        }){
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.yellow)
                                .modifier(BetNumberModifiers())
                        }
                        .modifier(BetCapsuleModifiers())
                        
                    }
                }
            }//:vstack
                //MARK: - BUTTONS
            .overlay(
                //RESET
                Button(action: {
                    print("Reset the game")
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifiers()), alignment: .topLeading
            )
            .overlay(
                //INFO
                Button(action: {
                    print("ınfo view")
                }){
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifiers()), alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            
                //MARK: - POPUP
        }//:zstack
    }
}


//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
