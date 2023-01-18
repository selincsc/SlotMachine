//
//  ContentView.swift
//  SlotMachine
//
//  Created by Selin Çağlar on 18.01.2023.
//

import SwiftUI


//MARK: -  PROPERTIES
struct ContentView: View {
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    @State private var highscore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array =  [0, 1, 2]
    @State private var showingInfoView: Bool = false
    
//MARK: -  FUNCTIONS
    
    func spinReels() {
        //        reels[0] = Int.random(in: 0...symbols.count - 1)
        //        reels[1] = Int.random(in: 0...symbols.count - 1)
        //        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1 )
        })
    }
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            //PLAYER WINS
            playerWins()
            //NEW HIGHSCORE
            if coins > highscore {
                newHighScore()
            }
        }else {
            //PLAYER LOSES
            playerLoses()
        }
    }
    func playerWins() {
        coins += betAmount * 10
    }
    func newHighScore() {
        highscore = coins
    }
    func playerLoses() {
        coins -= betAmount
    }


//GAME IS OVER
    
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
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifies())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    HStack{
                        Text("\(highscore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifies())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                        
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                //MARK: - SLOT MACHINE
                    //MARK:  reel 1
                VStack (alignment: .center, spacing: 0){
                    ZStack{
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    HStack(alignment: .center, spacing: 0){
                        //MARK:  reel  2
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        //MARK: reel 3
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    //MARK: - spın button
                    Button(action: {
                        //SPIN THE REELS
                        self.spinReels()
                        //CHECKWINNNINGS
                        self.checkWinning()
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
                    //MARK: bet 20
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
                    //MARK: bet 10
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
                //MARK: - RESET
                Button(action: {
                    print("Reset the game")
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifiers()), alignment: .topLeading
            )
            .overlay(
                // MARK: - INFO
                Button(action: {
                    self.showingInfoView = true
                }){
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifiers()), alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            
                //MARK: - POPUP
        }//:zstack
        .sheet(isPresented: $showingInfoView){
            InfoView()
        }
    }
}


//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
