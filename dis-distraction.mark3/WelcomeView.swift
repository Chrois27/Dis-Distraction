//
//  WelcomeView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showingGoalSetting = false

    var body: some View {
        NavigationView {
            VStack {
                Text("집중력을 키우고 관리하세요.")
                    .font(.largeTitle)
                    .padding()

                Button("시작하기") {
                    showingGoalSetting = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
                .sheet(isPresented: $showingGoalSetting) {
                    GoalSettingView()
                }
            }
        }
    }
}


#Preview {
    WelcomeView()
}
