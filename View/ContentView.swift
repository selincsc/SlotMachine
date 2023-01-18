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
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array =  [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    
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
        UserDefaults.standard.set(highscore, forKey: "HighScore")
    }
    func playerLoses() {
        coins -= betAmount
    }
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    func isGameOver() {
        if coins <= 0 {
            //show modal window
            showingModal = true
        }
    }
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
    }



    
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
                        //GAME IS OVER
                        self.isGameOver()
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
                            self.activateBet20()
                        }){
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifiers())
                        }
                        .modifier(BetCapsuleModifiers())
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifiers())
                    }
                    //MARK: bet 10
                    HStack (alignment: .center, spacing: 10){
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifiers())
                        
                        Button(action: {
                            self.activateBet10()
                        }){
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : Color.white)
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
                    self.resetGame()
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
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
                //MARK: - POPUP
            if $showingModal.wrappedValue {
                ZStack{
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    //modal
                    VStack(spacing: 0){
                        //title
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        Spacer()
                        //message
                        VStack (alignment: .center, spacing: 16){
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck ! You lost all of the coins. \nLet's play again !")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            Button(action: {
                                self.showingModal = false
                                self.coins = 100
                            }){
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                }
            }
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
