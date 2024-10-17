//
//  EncylopediaView2.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/15/24.
//

import SwiftUI

struct EncyclopediaView2: View {
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
                
                Spacer()
            }
            .frame(alignment:.leading)
            .padding(EdgeInsets(top:10, leading:30, bottom: 15, trailing: 0))

            VStack {
                HStack {
                    Image(systemName: "books.vertical")
                        .font(.largeTitle)
                        .padding(.leading)
                    
                    Text("멍멍테니카 백과사전")
                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        // 검색 버튼 액션
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                    }
                    
                    Button(action: {
                        // 닫기 버튼 액션
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                    }
                }
                .padding(EdgeInsets(top:20, leading:10, bottom: 20, trailing: 10))
                
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
                VStack(alignment:.leading) {
                    Text("\(title) 내용이 여기에 표시됩니다.")
                        .frame(width:300, height:200)
                        .padding()
                    
                    Spacer(minLength: 20)
                }
                .background(Color.white.opacity(0.9))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    EncyclopediaView2()
}
