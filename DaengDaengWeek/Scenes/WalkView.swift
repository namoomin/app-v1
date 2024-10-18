//
//  WalkView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//
import SwiftUI
import HealthKit

struct WalkView: View {
    @State private var showPopup = true
    @State private var steps: Int = 0
    @State private var exerciseTime: Int = 0
    @State private var progress: Double = 0.0
    
    private let healthStore = HKHealthStore()
    
    var body: some View {
        ZStack {
           // Background color
            
            VStack {
                Spacer()
                
                // Dog image
                Image("dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                // Home button above progress bar
                HStack{
                    Spacer()
                    
                    Button(action: {}) {
                            Image("houseicon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        
                    }
                    .padding(EdgeInsets(top:0, leading:10, bottom: 20, trailing: 30))
                    
                }
                
                
                // Progress bar to show exercise progress
                HStack {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(height: 10)
                    Image(systemName: "figure.walk")
                }
                .padding(.horizontal)
                
                // Display step count and exercise time
                HStack {
                    Spacer()
                    Text("\(steps)걸음")
                    Spacer()
                    Text("\(exerciseTime)분 / 30분")
                }
                .padding(.horizontal)
                .font(.dw(.bold, size: 16))
                
                Spacer()
            }
            
            // Popup view
            if showPopup {
                PopupView(showPopup: $showPopup)
                    .padding(.horizontal, 20)
            }
        }
        .onAppear(perform: fetchHealthData) // Automatically start fetching health data
    }
    
    func requestHealthData() {
        let typesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        ]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
            if !success {
                // Handle error if authorization fails
            }
        }
    }
    
    func fetchHealthData() {
        requestHealthData() // Ensure authorization is requested
        
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let stepQuery = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.steps = Int(sum.doubleValue(for: HKUnit.count()))
            updateProgress()
        }
        
        let exerciseQuery = HKStatisticsQuery(quantityType: exerciseType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.exerciseTime = Int(sum.doubleValue(for: HKUnit.minute()))
            updateProgress()
        }
        
        healthStore.execute(stepQuery)
        healthStore.execute(exerciseQuery)
    }
    
    func updateProgress() {
        self.progress = Double(self.exerciseTime) / 30.0
    }
}

struct PopupView: View {
    @Binding var showPopup: Bool
    
    var body: some View {

        VStack {
            HStack{
                Spacer()
                
                Button(action: { showPopup = false }) {
                    Text("X")
                        .foregroundColor(.red)
                }
                .padding()
            }
            
            Text("걷기 시작하면 산책이 시작돼요.\n산책이 끝나면 집을 눌러주세요.\n함께 산책해 볼까요?")
                .font(.dw(.bold, size: 20))
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top:-20, leading:10, bottom: 20, trailing: 10))
            
        }
        .background(Color.btnBeige)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.borderGray, lineWidth: 3))
        .padding()
    }
}

// Preview provider for SwiftUI previews
#Preview {
    WalkView()
}
