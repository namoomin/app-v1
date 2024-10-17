//
//  Dictionary.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/15/24.
//

import SwiftUI

struct EncyclopediaView: View {
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "books.vertical")
                            .font(.largeTitle)
                            .padding(.leading)
                        
                        Text("멍멍테니카 백과사전")
                            .font(.dw(.bold, size: 28)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
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
                    
                    
                    VStack(spacing: 30) {
                        Button(action: {
                            // 사료주기 버튼 액션
                        }) {
                            Text("사료주기")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // 물주기 버튼 액션
                        }) {
                            Text("물주기")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // 간식주기 버튼 액션
                        }) {
                            Text("간식주기")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // 사료주기 버튼 액션
                        }) {
                            Text("사료주기")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .background(Color.btnBeige)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.borderGray, lineWidth: 5))
                .padding(EdgeInsets(top:0, leading:20, bottom: 100, trailing: 20))
            }
            .background(.white)
            .foregroundColor(.black)
        }
    }
        
}

#Preview {
    EncyclopediaView()
}
