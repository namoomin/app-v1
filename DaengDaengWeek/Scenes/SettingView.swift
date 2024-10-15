import SwiftUI

struct PledgeView: View {
    @State private var name: String = ""
    @State private var breed: String = "푸들"
    @State private var gender: String = "남"
    let age: String = "3개월" // 고정된 문자
    @Environment(\.presentationMode) var presentationMode // 창 닫기 버튼을 위한 변수

    let breeds = ["푸들", "말티즈"]
    let genders = ["남", "여"]

    var body: some View {
        ZStack(alignment: .topTrailing) { // 상단 우측 정렬을 위한 ZStack
            Color.white.opacity(0.4) // 팝업 뒤의 반투명 배경
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.brown, lineWidth: 10)  // 테두리 설정
                    .background(Color.btnBeige)            // 팝업 내부 배경색
                    .cornerRadius(20)
                    .padding(20)

                VStack(spacing: 20) {
                    Text("서약서")
                        .font(.dw(.bold, size: 40))
                        .padding(.top, 30)
                    
                    Spacer()

                    HStack {
                        Text("이름")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        TextField("이름 입력", text: $name)
                            .font(.dw(.bold, size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(.horizontal, 40)

                    HStack {
                        Text("견종")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        Picker(selection: $breed, label: Text(breed)) {
                            ForEach(breeds, id: \.self) {
                                Text($0)
                                    .font(.dw(.regular, size: 20))
                            }
                        }
                        .frame(width: 200)
                        .clipped()
                    }
                    .padding(.horizontal, 40)

                    HStack {
                        Text("성별")
                            .font(.dw(.regular, size: 25))
                        Spacer()
                        Picker(selection: $gender, label: Text(gender)) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                                    .font(.dw(.regular, size: 20))
                            }
                        }
                        .frame(width: 200)
                        .clipped()
                    }
                    .padding(.horizontal, 40)

                    // 나이 출력
                    HStack {
                        Text("나이")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        Text(age) // 사용자가 수정할 수 없는 고정된 값
                            .frame(width: 200)
                            .font(.dw(.bold, size: 20))
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                    Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 반려견에 대해 알아가겠습니다.")
                        .font(.dw(.regular, size: 25))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()

                    Button(action: {
                        print("동의하기 버튼")
                    }) {
                        Text("동의하기")
                            .font(.dw(.bold, size: 24))
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 185, height: 54)
                            .background(Color.aggrement)
                            .cornerRadius(10)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.borderGray, lineWidth: 3)
                    )
                    .padding(.bottom, 120)
                }
            }

            // 우측 상단 X 버튼
            Button(action: {
                presentationMode.wrappedValue.dismiss() // 팝업 닫기
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .padding()
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .padding(.top, 40)
            .padding(.trailing, 40)
        }
    }
}

#Preview {
    PledgeView()
}
