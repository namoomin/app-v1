import SwiftUI

struct MainView: View {
    // 현재 시간 표시를 위한 문자열 변수
    @State private var currentTime: String = ""
    // 애정도 (0.0 ~ 1.0 사이의 값)
    @State private var affectionLevel: Double = 0.3
    // 팝업 표시 여부
    @State private var showPopup: Bool = false
    // 먹이주기 진행도 (0.0 ~ 1.0 사이의 값)
    @State private var feedingProgress: CGFloat = 1.0
    // 활성화된 팝업의 종류 ("hygiene", "affection", "outing" 등)
    @State private var activePopup: String? = nil
    // 작은 아이콘 표시 여부 (먹이주기 버튼 클릭 시 나타남)
    @State private var showSmallIcons: Bool = false

    // 먹이주기 지속 시간 (초)
    private let feedingDuration: TimeInterval = 30.0

    // UI 설정 변수들
    @State private var borderSize: CGFloat = 3 // 테두리 굵기
    @State private var buttonSpacing: CGFloat = 20 // 버튼 간격
    @State private var iconBackgroundColor: Color = .btnBeige // 아이콘 배경색
    @State private var iconBorderColor: Color = .borderGray // 아이콘 테두리색

    // 이미지 전환을 위한 인덱스 변수
    @State private var currentImageIndex: Int = 0
    // 표시할 이미지 배열
    private let images = ["Maindog1", "Maindog2"]

    // 타이머 설정: 0.1초마다 갱신되는 타이머 (먹이주기 진행도 업데이트 등)
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    // 이미지 전환을 위한 타이머: 3초마다 이미지 변경
    let imageTimer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            // 상단 정보 영역
            HStack {
                VStack {
                    // 프로필 정보 영역
                    HStack {
                        // 강아지 아이콘 이미지
                        Image("DogIcon")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()

                        // 강아지 이름과 애정도 표시
                        VStack(alignment: .leading) {
                            Text("마루") // 강아지 이름
                                .font(.dw(.bold, size: 25))

                            // 애정도 진행 바
                            ProgressView(value: affectionLevel)
                                .progressViewStyle(LinearProgressViewStyle(tint: .pink))
                                .frame(width: 80)
                        }

                        Spacer()

                        // 돈 아이콘 이미지
                        Image("money")
                            .padding()

                        Spacer()

                        // 설정, 알림, 도감 버튼들
                        VStack(spacing: 15) {  // 일정한 간격 유지
                            // 설정 버튼
                            Button(action: { }) {
                                Image("settingbtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                            // 알림 버튼
                            Button(action: { }) {
                                Image("noticebtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                            // 도감 버튼
                            Button(action: { }) {
                                Image("bookbtn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)  // 동일한 크기 유지
                            }
                        }
                    }

                    // 시간 표시 영역
                    HStack {
                        // 현재 시간 표시
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

            // 가운데 메인 이미지 영역 (현재 이미지 인덱스에 따라 이미지 표시)
            Image(images[currentImageIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .transition(.opacity)
                .animation(.easeInOut, value: currentImageIndex)
                .padding(.bottom, showSmallIcons ? 0 : 120)

            Spacer()

            // 작은 아이콘 영역 (먹이주기 버튼 클릭 시 표시)
            if showSmallIcons {
                HStack(spacing: buttonSpacing) {
                    // 음식 아이콘
                    SmallIconView(
                        icon: Image("Foodicon"),
                        backgroundColor: iconBackgroundColor,
                        borderColor: iconBorderColor,
                        borderWidth: 2
                    )
                    // 물 아이콘
                    SmallIconView(
                        icon: Image("Watericon"),
                        backgroundColor: iconBackgroundColor,
                        borderColor: iconBorderColor,
                        borderWidth: 2
                    )
                    // 간식 아이콘
                    SmallIconView(
                        icon: Image("Snackicon"),
                        backgroundColor: iconBackgroundColor,
                        borderColor: iconBorderColor,
                        borderWidth: 2
                    )
                }
                .transition(.opacity)
                .padding(.bottom, 10)
                .padding(.leading, -100) // 왼쪽으로 정렬하여 먹이주기 아이콘 영역 끝에서부터 시작되도록
            }

            // 하단 버튼 영역
            HStack(spacing: buttonSpacing) {
                // 먹이주기 버튼
                FeedingButtonView(
                    icon: Image("feedingbtn"),
                    text: "먹이주기",
                    progress: feedingProgress,
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: {
                        refillFeedingProgress() // 먹이주기 진행도 초기화
                        withAnimation {
                            showSmallIcons.toggle() // 작은 아이콘 표시/숨김 토글
                        }
                    }
                )

                // 위생관리 버튼
                ButtonView(
                    icon: Image("hygienebtn"),
                    text: "위생관리",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "hygiene") } // 위생관리 팝업 토글
                )

                // 애정표현 버튼
                ButtonView(
                    icon: Image("affectionbtn"),
                    text: "애정표현",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "affection") } // 애정표현 팝업 토글
                )

                // 외출하기 버튼
                ButtonView(
                    icon: Image("Outingbtn"),
                    text: "외출하기",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "outing") } // 외출하기 팝업 토글
                )
            }
            .padding()
        }
        // 타이머를 이용하여 먹이주기 진행도 업데이트
        .onReceive(timer) { _ in
            updateFeedingProgress()
        }
        // 타이머를 이용하여 이미지 전환
        .onReceive(imageTimer) { _ in
            cycleImages()
        }
    }

    // 현재 시간 업데이트 함수
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        currentTime = formatter.string(from: Date())

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentTime = formatter.string(from: Date())
        }
    }

    // 먹이주기 진행도 업데이트 함수
    func updateFeedingProgress() {
        let decrement = CGFloat(0.1 / feedingDuration)
        feedingProgress = max(0.0, feedingProgress - decrement)
    }

    // 먹이주기 진행도 초기화 함수
    func refillFeedingProgress() {
        feedingProgress = 1.0
    }

    // 팝업 표시 상태 토글 함수
    func togglePopup(for buttonType: String) {
        activePopup = activePopup == buttonType ? nil : buttonType
    }

    // 이미지 순환 함수
    func cycleImages() {
        currentImageIndex = (currentImageIndex + 1) % images.count
    }
}

// 먹이주기 버튼 뷰
struct FeedingButtonView: View {
    let icon: Image
    let text: String
    let progress: CGFloat // 먹이주기 진행도
    let backgroundColor: Color
    let borderWidth: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // 버튼 배경
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // 진행도 표시를 위한 오버레이
                VStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.red.opacity(0.5))
                        .frame(height: 80 * progress)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                // 아이콘과 텍스트
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

// 일반 버튼 뷰
struct ButtonView: View {
    let icon: Image
    let text: String
    let backgroundColor: Color
    let borderWidth: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // 버튼 배경
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // 아이콘과 텍스트
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

// 작은 아이콘 뷰
struct SmallIconView: View {
    let icon: Image
    let backgroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        VStack {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .frame(width: 60, height: 60)
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

#Preview {
    MainView()
}
