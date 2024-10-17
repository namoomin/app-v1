//
//  MainView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//


import SwiftUI

struct MainView: View {
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3 // userdefault date DATE.()
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil // Track wich button's popup is active
    
    let timer = Timer.publish(every:1, on:. main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // 상단 정보 영역
            HStack {
                
                VStack {
                    
                    HStack {
                        Image("DogIcon") // 반려견 아이콘
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("마루")
                                .font(.dw(.bold, size: 25)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                            
                            ProgressView(value: affectionLevel)
                                .progressViewStyle(LinearProgressViewStyle(tint: .pink))
                                .frame(width: 80)
                        }
                        
                        Spacer()
                        
                        Image("money")
                            .padding()
                        
                        
                        Spacer()
                        
                        VStack(spacing : 7) {
                            Button(action: {
                                // 환경설정 버튼 액션
                            }) {
                                Image(systemName: "gearshape.fill")
                            }
                            
                            Button(action: {
                                // 백과사전 버튼 액션
                            }) {
                                Image(systemName: "bell.fill")
                            }
                            
                            Button(action: {
                                // 알림 버튼 액션
                            }) {
                                Image(systemName: "book.fill")
                            }
                        }
                        .font(.title2)
                        
                    }
                    
                    HStack {
                        Text(currentTime)
                            .font(.dw(.bold, size: 16)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                            .onAppear(perform: updateTime)
                            .frame(width: 80, height:  40)
                            .background(Color.btnBeige)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.borderGray, lineWidth: 3)
                            )
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                }
            }
            .padding()
            .foregroundColor(.black)
            
            
            Spacer()
            
            // 팝업 버튼 영역
            if let activePopup = activePopup {
                HStack(spacing: 20) {
                    if activePopup == "feeding" {
                        Text("Feeding Option 1")
                        Text("Fedding Option 2")
                    } else if activePopup == "hygiene" {
                        Text("Hygiene Option 1")
                        Text("Hygiene Option 2")
                    } else if activePopup == "affection" {
                        Text("Affection Option 1")
                        Text("Affection Option 2")
                    } else if activePopup == "outing" {
                        Text("Outing Option 1")
                        Text("Outing Option 2")
                    }
                                        
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                
            }
            
            // 하단 버튼 영역
            HStack(spacing: 20) {
                Button(action: { increaseAffection(); togglePopup(for: "feeding")}) {
                    VStack {
                        ZStack(alignment:.bottom) {
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(Color.btnBeige))
                                .cornerRadius(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(Color.borderGray, lineWidth: 5))
                            
                            Image("feedingbtn")
                                .resizable()
                                .frame(width:48, height:48)
                                
                            
                            Rectangle()
                                .frame(width: 50, height: feedingProgress * 45)
                                .foregroundColor(.red.opacity(0.2))
                                .animation(.linear(duration: 1), value: feedingProgress)
                        }
                        
                        Text("먹이주기")
                            .font(.dw(.bold, size: 16)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                            .foregroundColor(Color.black)
                    }
                    .padding()
                }
                
                Button(action: { showPopup.toggle() }) {
                    Image("hygienebtn")
                    Text("위생관리")
                }
                
                Button(action: { showPopup.toggle() }) {
                    Image("affectionbtn")
                    Text("애정표현")
                }
                
                Button(action: { showPopup.toggle() }) {
                    Image(systemName: "figure.walk")
                    Text("외출하기")
                }
            }
            .padding()
        }
        .onReceive(timer) { _ in
              if affectionLevel > 0.0 {
                  affectionLevel -= 0.01 // Decrease affection level gradually
              } else {
                  affectionLevel = 0.0 // Ensure it doesn't go below zero
              }

              if feedingProgress > 0.0 {
                  feedingProgress -= 0.01 // Decrease feeding progress gradually
              } else {
                  feedingProgress = 0.0 // Ensure it doesn't go below zero
              }
          }
      }

      func updateTime() {
          let formatter = DateFormatter()
          formatter.timeStyle = .short
          currentTime = formatter.string(from: Date())
          
          Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
              currentTime = formatter.string(from: Date())
          }
      }

      func increaseAffection() {
          if affectionLevel < 1.0 {
              affectionLevel += 0.05 // Increase affection level when button is pressed
          }

          if feedingProgress < 1.0 {
              feedingProgress += 0.2 // Increase feeding progress when button is pressed
          }
      }
    
    func togglePopup(for buttonType: String) {
        if activePopup == buttonType {
            activePopup = nil // close popup if it's already open for this button
        } else {
            activePopup = buttonType // open popup for this specitic button
        }
    }
}

#Preview {
    MainView()
}
