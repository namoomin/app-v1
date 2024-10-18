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
        HStack {
            VStack {
                HStack {
                    Image("DogIcon") // 반려견 아이콘
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("마루")
                            .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                        
                        ZStack(alignment:. leading) {
                            ProgressView(value: affectionLevel)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.heartPink))
                                .frame(width: 80)
                            Image("hearticon")
                                .offset(x:-10, y:0)
                                
                            
                        }
                        
                        
                    }
                    
                    Spacer()
                }
                
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
            }
                        
                        Spacer()
                        
                        Image("money")
                            .padding(EdgeInsets(top:0, leading:0, bottom: 70, trailing: 20))

                        
                        
                        Spacer()
                        
                        VStack(spacing: 10) {  // 일정한 간격 유지
                            Button(action: { }) {
                                Image("settingbtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                            Button(action: { }) {
                                Image("noticebtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                            Button(action: { }) {
                                Image("bookbtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                        }
                        
                    
                    
            }
            .padding()
            .foregroundColor(.black)
    }
    
    func updateTime() { //현재시각을 나타내는 함수
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
