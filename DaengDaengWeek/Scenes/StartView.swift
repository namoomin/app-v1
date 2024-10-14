//
//  StartView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            Image("background_img") // 추후 배경 추가시 이름 변경
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ///배경 추가시 /// 이 사이 부분 지울것
                Spacer()
                
                Text("앱 로딩 이미지")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.bottom, 50)
                
                Spacer()
                ///

                Button(action: {
                    print("시작 버튼 클릭")
                }) {
                    Text("시작하기")
                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 185, height: 54)
                        .background(Color.btnBeige)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.borderGray, lineWidth: 3)
                        )
                }
                .padding(.bottom, 120)
            }
        }

    }
}

#Preview {
    StartView()
}
