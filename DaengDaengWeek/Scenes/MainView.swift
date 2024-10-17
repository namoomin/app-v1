//
//  MainView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI

struct MainView: View {
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // 상단 정보 영역
            HStack {
                VStack {
                    HStack {
                        Image("DogIcon")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("마루")
                                .font(.dw(.bold, size: 25))
                            
                            ProgressView(value: affectionLevel)
                                .progressViewStyle(LinearProgressViewStyle(tint: .pink))
                                .frame(width: 80)
                        }
                        
                        Spacer()
                        
                        Image("money")
                            .padding()
                        
                        Spacer()
                        
                        VStack(spacing: 7) {
                            Button(action: { }) {
                                Image(systemName: "gearshape.fill")
                            }
                            Button(action: { }) {
                                Image(systemName: "bell.fill")
                            }
                            Button(action: { }) {
                                Image(systemName: "book.fill")
                            }
                        }
                        .font(.title2)
                    }
                    
                    HStack {
                        Text(currentTime)
                            .font(.dw(.bold, size: 16))
                            .onAppear(perform: updateTime)
                            .frame(width: 80, height: 40)
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
                        Text("Feeding Option 2")
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
                ButtonView(
                    icon: Image("feedingbtn"),
                    text: "먹이주기",
                    action: { increaseAffection(); togglePopup(for: "feeding") }
                )
                
                ButtonView(
                    icon: Image("hygienebtn"),
                    text: "위생관리",
                    action: { togglePopup(for: "hygiene") }
                )
                
                ButtonView(
                    icon: Image("affectionbtn"),
                    text: "애정표현",
                    action: { togglePopup(for: "affection") }
                )
                
                ButtonView(
                    icon: Image(systemName: "figure.walk"),
                    text: "외출하기",
                    action: { togglePopup(for: "outing") }
                )
            }
            .padding()
        }
        .onReceive(timer) { _ in
            affectionLevel = max(0.0, affectionLevel - 0.01)
            feedingProgress = max(0.0, feedingProgress - 0.01)
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
        affectionLevel = min(1.0, affectionLevel + 0.05)
        feedingProgress = min(1.0, feedingProgress + 0.2)
    }
    
    func togglePopup(for buttonType: String) {
        activePopup = activePopup == buttonType ? nil : buttonType
    }
}

struct ButtonView: View {
    let icon: Image
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.borderGray, lineWidth: 3)
                .frame(width: 100, height: 100) // 크기 조정
                .overlay(
                    VStack {
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(text)
                            .font(.dw(.bold, size: 14))
                            .foregroundColor(.black)
                    }
                )
        }
    }
}

#Preview {
    MainView()
}
