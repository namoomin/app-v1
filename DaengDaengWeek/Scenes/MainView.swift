import SwiftUI

struct MainView: View {
    @State private var affectionLevel: Double = 0.3
    @State private var currentTime: String = ""
    @State private var feedingProgress: CGFloat = 1.0

    private let feedingDuration: TimeInterval = 20.0

    var body: some View {
        VStack {
            // Importing MainViewProf
            MainViewProf(affectionLevel: $affectionLevel, backgroundColor: .white)
                .padding(EdgeInsets(top: -30, leading: 0, bottom: 100, trailing: 8))

            Spacer()

            // Center image area
            Image("Maindog1")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 120)

            Spacer()

            // Bottom button area
            HStack(spacing: 20) {
                FeedingButtonView(
                    icon: Image("feedingbtn"),
                    text: "먹이주기",
                    progress: feedingProgress,
                    action: { increaseAffection() }
                )

                ButtonView(
                    icon: Image("hygienebtn"),
                    text: "위생관리",
                    action: { increaseAffection() }
                )

                ButtonView(
                    icon: Image("affectionbtn"),
                    text: "애정표현",
                    action: { increaseAffection() }
                )

                ButtonView(
                    icon: Image("outingbtn"),
                    text: "외출하기",
                    action: { increaseAffection() }
                )
            }
            .padding()
        }
        .onReceive(Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()) { _ in
            updateFeedingProgress()
        }
    }

    func updateFeedingProgress() {
        let decrement = CGFloat(0.1 / feedingDuration)
        feedingProgress = max(0.0, feedingProgress - decrement)
    }

    func increaseAffection() {
        affectionLevel = min(1.0, affectionLevel + 0.05) // Increase affection level up to a maximum of 1.0
    }
}

struct FeedingButtonView : View {
    let icon : Image
    let text : String
    let progress : CGFloat
    let action : () -> Void

    var body : some View{
        Button(action : action){
            ZStack{
                Color.gray.opacity(0.2)
                    .clipShape(RoundedRectangle(cornerRadius :10))

                VStack(spacing :0){
                    Spacer()

                    Rectangle()
                        .fill(Color.red.opacity(0.5))
                        .frame(width :80,height :80 * progress)

                }.clipShape(RoundedRectangle(cornerRadius :10))

                VStack(spacing :1){
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width :50,height :50)

                    Text(text)
                        .font(.system(size :14,weight :.bold))
                        .foregroundColor(.black)

                }

            }.frame(width :80,height :80).overlay(RoundedRectangle(cornerRadius :10).stroke(Color.gray,lineWidth :5))
        }

    }

}

struct ButtonView : View {
    let icon : Image
    let text : String
    let action : () -> Void

    var body : some View{
        Button(action : action){
            ZStack{
                Color.gray.opacity(0.2)
                    .clipShape(RoundedRectangle(cornerRadius :10))

                VStack(spacing :1){
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width :50,height :50)

                    Text(text)
                        .font(.system(size :14,weight :.bold))
                        .foregroundColor(.black)

                }

            }.frame(width :80,height :80).overlay(RoundedRectangle(cornerRadius :10).stroke(Color.gray,lineWidth :5))
        }

    }

}

#Preview {
   MainView()
}
