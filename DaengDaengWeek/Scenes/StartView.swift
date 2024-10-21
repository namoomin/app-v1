import SwiftUI

struct StartView: View {
    // 색상 전환, 애니메이션 시간, 이미지 패딩을 위한 상태 변수
    @State private var isSecondColor: Bool = false
    @State private var animationDuration: Double = 2.0 // 전환 시간 설정 가능
    @State private var imagePadding: CGFloat = 100 // 이미지 위치 조정을 위한 패딩

    var body: some View {
        ZStack {
            // isSecondColor에 따라 변경되는 배경 그라데이션
            LinearGradient(gradient: Gradient(colors: [
                isSecondColor ? Color.startbackgroundYellow : Color.startbackgroundGray
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .animation(.easeInOut(duration: animationDuration), value: isSecondColor) // 색상 전환 애니메이션 적용
            .edgesIgnoringSafeArea(.all) // 화면 전체에 그라데이션 적용
            
            VStack {
                // 상단에 위치한 이미지, 패딩 조정 가능
                Image("maintext")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                    .padding(.top, imagePadding) // 이미지 위치를 동적으로 조정 가능
                
                Spacer() // 요소들 간의 공간 확보
                
                // 배경색을 전환하는 시작 버튼
                Button(action: {
                    print("시작 버튼 클릭") // 버튼 클릭 로그 출력
                    withAnimation {
                        isSecondColor.toggle() // 버튼 클릭 시 배경색 전환
                    }
                }) {
                    Text("시작하기")
                        .font(.dw(.bold, size: 24)) // 사용자 정의 폰트, 굵은 스타일 적용
                        .foregroundColor(.black) // 텍스트 색상 설정
                        .padding() // 버튼 내부 패딩
                        .frame(width: 185, height: 54) // 버튼의 고정 크기
                        .background(Color.startBeigebtn) // 버튼의 배경색 설정
                        .cornerRadius(10) // 버튼 모서리 둥글게 처리
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.borderGray, lineWidth: 3) // 버튼의 테두리 설정
                        )
                }
                .padding(.bottom, 120) // 버튼의 아래쪽 여백 설정
            }
        }
    }
}

#Preview {
    StartView()
}
