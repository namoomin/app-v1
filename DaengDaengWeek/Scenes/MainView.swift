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

    // 게이지가 줄어드는 시간 설정 (예: 30초)
    private let feedingDuration: TimeInterval = 30.0

    @State private var borderSize: CGFloat = 1
    @State private var buttonSpacing: CGFloat = 20

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

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
                                Image("settingbtn")
                            }
                            Button(action: { }) {
                                Image("noticebtn")
                            }
                            Button(action: { }) {
                                Image("bookbtn")
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
                                    .stroke(Color.borderGray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            .padding()
            .foregroundColor(.black)

            Spacer()

            // 하단 버튼 영역
            HStack(spacing: buttonSpacing) {
                FeedingButtonView(
                    icon: Image("feedingbtn"),
                    text: "먹이주기",
                    progress: feedingProgress,
                    backgroundColor: .btnBeige,
                    borderWidth: borderSize,
                    action: { refillFeedingProgress() }
                )

                ButtonView(
                    icon: Image("hygienebtn"),
                    text: "위생관리",
                    backgroundColor: .btnBeige,  // 배경색 설정
                    borderWidth: borderSize,
                    action: { togglePopup(for: "hygiene") }
                )

                ButtonView(
                    icon: Image("affectionbtn"),
                    text: "애정표현",
                    backgroundColor: .btnBeige,  // 배경색 설정
                    borderWidth: borderSize,
                    action: { togglePopup(for: "affection") }
                )

                ButtonView(
                    icon: Image("Outingbtn"),
                    text: "외출하기",
                    backgroundColor: .btnBeige,  // 배경색 설정
                    borderWidth: borderSize,
                    action: { togglePopup(for: "outing") }
                )
            }
            .padding()
        }
        .onReceive(timer) { _ in
            updateFeedingProgress()
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

    func updateFeedingProgress() {
        let decrement = CGFloat(0.1 / feedingDuration)
        feedingProgress = max(0.0, feedingProgress - decrement)
    }

    func refillFeedingProgress() {
        feedingProgress = 1.0
    }

    func togglePopup(for buttonType: String) {
        activePopup = activePopup == buttonType ? nil : buttonType
    }
}

struct FeedingButtonView: View {
    let icon: Image
    let text: String
    let progress: CGFloat
    let backgroundColor: Color
    let borderWidth: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(spacing: 0) {
                    Spacer()

                    Rectangle()
                        .fill(Color.red.opacity(0.5))
                        .frame(width: 80, height: 80 * progress)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(spacing: 1) {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(text)
                        .font(.dw(.bold, size: 14))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 80, height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderGray, lineWidth: borderWidth)
            )
        }
    }
}

struct ButtonView: View {
    let icon: Image
    let text: String
    let backgroundColor: Color // 배경색 매개변수 추가
    let borderWidth: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(spacing: 1) {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(text)
                        .font(.dw(.bold, size: 14))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 80, height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderGray, lineWidth: borderWidth)
            )
        }
    }
}

#Preview {
    MainView()
}
