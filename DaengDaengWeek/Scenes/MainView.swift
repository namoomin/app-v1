import SwiftUI

struct MainView: View {
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil
    @State private var showSmallIcons: Bool = false

    private let feedingDuration: TimeInterval = 30.0

    @State private var borderSize: CGFloat = 3 // 변경: 테두리 굵기
    @State private var buttonSpacing: CGFloat = 20
    @State private var iconBackgroundColor: Color = .btnBeige // 변경: 아이콘 내부 배경색
    @State private var iconBorderColor: Color = .borderGray // 변경: 아이콘 테두리색

    @State private var currentImageIndex: Int = 0
    private let images = ["Maindog1", "Maindog2"]

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let imageTimer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

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

                        VStack(spacing: 15) {  // 일정한 간격 유지
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

            // 가운데 이미지 영역 (고정)
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
                    SmallIconView(icon: Image("Foodicon"), backgroundColor: iconBackgroundColor, borderColor: iconBorderColor, borderWidth: 2)
                    SmallIconView(icon: Image("Watericon"), backgroundColor: iconBackgroundColor, borderColor: iconBorderColor, borderWidth: 2)
                    SmallIconView(icon: Image("Snackicon"), backgroundColor: iconBackgroundColor, borderColor: iconBorderColor, borderWidth: 2)
                }
                .transition(.opacity)
                .padding(.bottom, 10)
                .padding(.leading, -100) // 왼쪽 먹이주기 아이콘영역 끝에서부터 시작되도록 정렬
            }

            // 하단 버튼 영역
            HStack(spacing: buttonSpacing) {
                FeedingButtonView(
                    icon: Image("feedingbtn"),
                    text: "먹이주기",
                    progress: feedingProgress,
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: {
                        refillFeedingProgress()
                        withAnimation {
                            showSmallIcons.toggle()
                        }
                    }
                )

                ButtonView(
                    icon: Image("hygienebtn"),
                    text: "위생관리",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "hygiene") }
                )

                ButtonView(
                    icon: Image("affectionbtn"),
                    text: "애정표현",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "affection") }
                )

                ButtonView(
                    icon: Image("Outingbtn"),
                    text: "외출하기",
                    backgroundColor: iconBackgroundColor,
                    borderWidth: borderSize,
                    action: { togglePopup(for: "outing") }
                )
            }
            .padding()
        }
        .onReceive(timer) { _ in
            updateFeedingProgress()
        }
        .onReceive(imageTimer) { _ in
            cycleImages()
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

    func cycleImages() {
        currentImageIndex = (currentImageIndex + 1) % images.count
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
                        .frame(height: 80 * progress)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

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
    let backgroundColor: Color
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
