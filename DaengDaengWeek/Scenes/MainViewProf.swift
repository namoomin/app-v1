//
//  MainViewProf.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/17/24.
//

import SwiftUI


struct MainViewProf: View {
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3 // userdefault date DATE.()
    
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
}

#Preview {
    MainViewProf()
}
