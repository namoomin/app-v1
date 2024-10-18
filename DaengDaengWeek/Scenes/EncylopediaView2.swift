//
//  EncylopediaView2.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/15/24.
//

import SwiftUI

struct EncyclopediaView2: View {
    @State var text : String = ""
    @State private var expandedSection: String? = nil
    
    var body: some View {
        VStack {
            // Custom tab bar
            HStack(spacing: 0) {
                Button(action: {
                    // Tab 1 action
                }) {
                    Image("Bookbtn1")
                }
                
                Button(action: {
                    // Tab 2 action
                }) {
                    Image("Bookbtn2")
                }
                                    
                Button(action: {
                    // Tab 3 action
                }) {
                    Image("Bookbtn3")
                }
                
                Button(action: {
                    // Tab 4  action
                }) {
                    Image("Bookbtn4")
                }
                
                Spacer()
            }
            .frame(alignment:.leading)
            .padding(EdgeInsets(top:10, leading:30, bottom: 15, trailing: 0))

            VStack {
                HStack {
                    Image("bookicon")
                        .font(.largeTitle)
                        .padding(.leading)
                    
                    ZStack {
                        // Border layer
                        Text("멍멍테니카 백과사전")
                            .font(.dw(.bold, size: 26)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                            .foregroundColor(Color.borderGray)
                            .padding(8)
                            .overlay(
                                Text("멍멍테니카 백과사전")
                                    .font(.dw(.bold, size: 26)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    .foregroundColor(Color.borderBeige) //Border color
                                    .offset(x:2, y:2)
                                    .padding(8)
                            )
                        
                        //Foreground text
                        Text("멍멍테니카 백과사전")
                            .font(.dw(.bold, size: 26)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                            .foregroundColor(.white) // Text Color
                            .padding(8)
                    }
                    
                    Spacer()
                    
                    
                    Button(action: {
                        // 닫기 버튼 액션
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                    }
                }
                .padding(EdgeInsets(top:20, leading:10, bottom: 20, trailing: 10))
                
                searchBarView(text:self.$text)
                    .padding(.horizontal,20)
                
                ScrollView {
                    VStack(spacing: 10) {
                        SectionButton(title: "사료주기", isExpanded: expandedSection == "사료주기") {
                            toggleSection("사료주기")
                        }
                        
                        SectionButton(title: "물주기", isExpanded: expandedSection == "물주기") {
                            toggleSection("물주기")
                        }
                        
                        SectionButton(title: "간식주기", isExpanded: expandedSection == "간식주기") {
                            toggleSection("간식주기")
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .background(Color(Color.btnBeige))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.borderGray, lineWidth: 5))
            .padding(EdgeInsets(top:-30, leading:20, bottom: 120, trailing: 20))
        }
        .background(Color.white)
        .foregroundColor(Color.black)
    }
    
    private func toggleSection(_ section: String) {
        if expandedSection == section {
            expandedSection = nil
        } else {
            expandedSection = section
        }
    }
}

struct SectionButton: View {
    let title: String
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Spacer()
                    
                    Text(title)
                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                    
                    Spacer()
        
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            
            if isExpanded {
                if title == "사료주기" {
                    VStack(alignment:.leading) {
                        Button(action: {
                            // Tab 1 action
                        }) {
                            VStack{
                                HStack{
                                    Image("feedstuff")
                                        .font(.largeTitle)
                                        .padding()
                                    Text("사료주기 • 1")
                                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    Spacer()
                                }
                                Text("강아지는 성장 단계에 따라 하루에 사료를 주는 횟수가 달라집니다. 대부분의 경우 어릴 땐 하루 4~5회, 성견일 땐 2회 정도가 적당합니다.")
                                    .font(.dw(.bold, size: 20)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                            }
                        }
                        
                        Button(action: {
                            // Tab 2 action
                        }) {
                            VStack{
                                HStack{
                                    Image("lockicon")
                                        .padding()
                                    Text("사료주기 • 2")
                                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                }
                                HStack{
                                    Image("lockicon")
                                        .padding()
                                    Text("사료주기 • 3")
                                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                }
                                
                            }
                        }
                        
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(5)
                    
                    
                }
            }
        }
    }
}

    

#Preview {
    EncyclopediaView2()
}
