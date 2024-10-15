import SwiftUI

struct PledgeView: View {
    @State private var name: String = ""
    @State private var breed: String = "푸들"
    @State private var gender: String = "남"
    let age: String = "3개월" // 고정된 문자
    @Environment(\.presentationMode) var presentationMode // 창 닫기 버튼을 위한 변수
    @State private var isValidName: Bool = true // 유효성 검사 플래그

    let breeds = ["푸들", "말티즈"]
    let genders = ["남", "여"]

    // 이름의 바이트 길이를 확인하는 함수
    func nameByteLength(_ name: String) -> Int {
        return name.utf8.count
    }

    // 이름을 바이트 길이로 제한하는 함수
    func isNameValid(_ name: String) -> Bool {
        let byteLength = nameByteLength(name)
        return byteLength >= 1 && byteLength <= 20
    }

    // 견종에 따라 표시할 이미지 반환
    func breedImage(breed: String) -> String {
        switch breed {
        case "푸들":
            return "Sel 1" // 임의의 푸들 이미지 이름
        case "말티즈":
            return "Sel 2" // 임의의 말티즈 이미지 이름
        default:
            return "default_image" // 기본 이미지
        }
    }

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

                    // 이름 입력
                    HStack {
                        Text("이름")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        TextField("이름 입력", text: $name, onEditingChanged: { isEditing in
                            // 입력이 변경될 때마다 이름의 유효성을 검사
                            if !isEditing {
                                isValidName = isNameValid(name)
                                if !isValidName {
                                    name = String(name.prefix(while: { nameByteLength(String($0)) <= 20 }))
                                }
                            }
                        })
                        .font(.dw(.bold, size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    }
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity)  // HStack이 전체 너비를 가질 수 있도록 설정
                    .padding(.leading, 40) // 왼쪽에 여유 공간 추가

                    if !isValidName {
                        Text("이름은 1바이트 이상, 20바이트 이하로 입력해주세요.")
                            .foregroundColor(.red)
                            .font(.dw(.regular, size: 14))
                            .padding(.top, -10)
                    }

                    // 견종 선택 및 이미지 표시
                    HStack {
                        Text("견종")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white) // 흰색 배경 추가
                                .frame(width: 200, height: 40) // 고정 크기 설정
                            Picker(selection: $breed, label: Text(breed)) {
                                ForEach(breeds, id: \.self) {
                                    Text($0)
                                        .font(.dw(.regular, size: 20))
                                }
                            }
                            .pickerStyle(MenuPickerStyle()) // 기본 스타일 적용
                            .frame(width: 200, height: 40)
                        }
                    }
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 40) // 왼쪽에 여유 공간 추가

                    // 성별 선택
                    HStack {
                        Text("성별")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white) // 흰색 배경 추가
                                .frame(width: 200, height: 40) // 고정 크기 설정
                            Picker(selection: $gender, label: Text(gender)) {
                                ForEach(genders, id: \.self) {
                                    Text($0)
                                        .font(.dw(.regular, size: 20))
                                }
                            }
                            .pickerStyle(MenuPickerStyle()) // 기본 스타일 적용
                            .frame(width: 200, height: 40)
                        }
                    }
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 40) // 왼쪽에 여유 공간 추가

                    // 나이 표시
                    HStack {
                        Text("나이")
                            .font(.dw(.bold, size: 25))
                        Spacer()
                        Text(age) // 사용자가 수정할 수 없는 고정된 값
                            .frame(width: 200)
                            .font(.dw(.bold, size: 20))
                    }
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 40) // 왼쪽에 여유 공간 추가

                    Spacer()

                    // 이름을 000에 대체하여 출력하는 부분
                    Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 \(name.isEmpty ? "000" : name)에 대해 알아가겠습니다.")
                        .font(.dw(.regular, size: 20)) // 폰트 크기는 고정
                        .multilineTextAlignment(.center) // 텍스트를 중앙 정렬
                        .padding(.horizontal, 40) // 좌우 여백을 줌
                        .lineLimit(nil) // 줄 수를 제한하지 않음
                        .fixedSize(horizontal: false, vertical: true) // 수직 방향으로만 크기 조정 가능 (줄바꿈 허용)

                    Spacer()

                    // 동의하기 버튼
                    Button(action: {
                        isValidName = isNameValid(name) // 버튼을 눌렀을 때 이름 유효성 검사
                        if isValidName {
                            print("동의하기 버튼")
                        }
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
