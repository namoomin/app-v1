import SwiftUI

struct PledgeView: View {
    @State private var name: String = ""
    @State private var breed: String = "푸들"
    @State private var gender: String = "남"
    @State private var age: String = "3개월"

    let breeds = ["푸들", "시바견", "치와와", "리트리버"]
    let genders = ["남", "여"]

    var body: some View {
        ZStack {
            Color("BackgroundBeige") // 배경색 정의
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // 타이틀
                Text("서약서")
                    .font(.title)
                    .padding(.top, 30)
                
                Spacer()

                // 이름 입력
                HStack {
                    Text("이름")
                        .font(.body)
                    Spacer()
                    TextField("이름 입력", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                .padding(.horizontal, 40)

                // 견종 선택
                HStack {
                    Text("견종")
                        .font(.body)
                    Spacer()
                    Picker(selection: $breed, label: Text(breed)) {
                        ForEach(breeds, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: 200)
                    .clipped()
                }
                .padding(.horizontal, 40)

                // 성별 선택
                HStack {
                    Text("성별")
                        .font(.body)
                    Spacer()
                    Picker(selection: $gender, label: Text(gender)) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: 200)
                    .clipped()
                }
                .padding(.horizontal, 40)

                // 나이 입력
                HStack {
                    Text("나이")
                        .font(.body)
                    Spacer()
                    TextField("나이 입력", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                .padding(.horizontal, 40)

                // 설명 텍스트
                Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 반려견에 대해 알아가겠습니다.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)

                Spacer()

                // 동의 버튼
                Button(action: {
                    print("동의하기 버튼 클릭")
                }) {
                    Text("동의하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color("ButtonBeige"))
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("CardBackground"))
                    .shadow(radius: 10)
            )
            .padding()
        }
    }
}

#Preview {
    PledgeView()
}
