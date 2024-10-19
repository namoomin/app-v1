import SwiftUI

struct PledgeView: View {
    @State private var name: String = ""
    @State private var breed: String = "푸들"
    @State private var gender: String = "남"
    let age: String = "3개월"
    @Environment(\.presentationMode) var presentationMode
    @State private var isValidName: Bool = true

    let breeds = ["말티즈", "푸들"]
    let genders = ["남", "여"]

    func nameByteLength(_ name: String) -> Int {
        return name.utf8.count
    }

    func isNameValid(_ name: String) -> Bool {
        let byteLength = nameByteLength(name)
        return byteLength >= 1 && byteLength <= 20
    }

    func breedImage(breed: String) -> String {
        switch breed {
        case "푸들": return "Sel 1"
        case "말티즈": return "Sel 2"
        default: return "default_image"
        }
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.outline, lineWidth: 5)
                    .background(Color.btnBeige)
                    .cornerRadius(20)
                    .padding(20)

                VStack(spacing: 20) {
                    Image("Oath")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 50)
                        .padding(.top, 60)

                    Spacer()

                    // 이름 입력 필드
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("이름")
                                .font(.dw(.regular, size: 20))
                            Spacer()
                            TextField("이름 입력", text: $name) { isEditing in
                                if !isEditing {
                                    isValidName = isNameValid(name)
                                    if !isValidName {
                                        name = String(name.prefix(while: { nameByteLength(String($0)) <= 20 }))
                                    }
                                }
                            }
                            .font(.dw(.bold, size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                        }
                        .padding(.horizontal, 70)

                        if !isValidName {
                            Text("이름은 1글자 이상, 10글자 이하로 입력해주세요.")
                                .foregroundColor(.red)
                                .font(.dw(.regular, size: 14))
                                .padding(.horizontal, 70)
                        }

                        // 견종 선택 필드
                        HStack {
                            Text("견종")
                                .font(.dw(.regular, size: 20))
                            Spacer()
                            HStack(spacing: 6) {
                                ForEach(breeds, id: \.self) { breedOption in
                                    Button(action: {
                                        breed = breedOption
                                    }) {
                                        VStack(spacing: -20) {
                                            Image(breedImage(breed: breedOption))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 95, height: 95)

                                            Text(breedOption)
                                                .font(.dw(.regular, size: 16))
                                                .foregroundColor(.black) // 텍스트를 검은색으로 설정
                                        }
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(breed == breedOption ? Color.outline : Color.gray, lineWidth: 1)
                                        )
                                        .opacity(breed == breedOption ? 1.0 : 0.5)
                                    }
                                }
                            }
                            .frame(width: 200) // 견종 선택 영역의 가로 크기를 200으로 고정
                        }
                        .padding(.horizontal, 70) // 이름 입력란과 동일한 위치 설정
                    }

                    // 성별 선택 영역
                    HStack(alignment: .center) {
                        Text("성별")
                            .font(.dw(.regular, size: 20))
                            .frame(width: 60, alignment: .leading)

                        Picker(selection: $gender, label: Text(gender).foregroundColor(.black)) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                                    .font(.dw(.regular, size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 70)

                    // 나이 표시 영역
                    HStack(alignment: .center) {
                        Text("나이")
                            .font(.dw(.regular, size: 20))
                            .frame(width: 60, alignment: .leading)

                        Text(age)
                            .font(.dw(.bold, size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 70)

                    Spacer()

                    Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 \(name.isEmpty ? "000" : name)에 대해 알아가겠습니다.")
                        .font(.dw(.regular, size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()

                    Button(action: {
                        isValidName = isNameValid(name)
                        if isValidName {
                            print("동의하기 버튼")
                        }
                    }) {
                        Text("동의하기")
                            .font(.dw(.bold, size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 185, height: 54)
                            .background(Color.borderBeige)
                            .cornerRadius(10)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.borderBeige, lineWidth: 3)
                    )
                    .padding(.bottom, 50)
                }
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss()
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
