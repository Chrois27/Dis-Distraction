//
//  TimerView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI

struct TimerView: View {
    @State private var remainingTime: Int
    @State private var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(duration: Int) {
        self._remainingTime = State(initialValue: duration * 60) // 분을 초로 변환
    }

    var body: some View {
        VStack {
            Text("남은 시간: \(remainingTime)초")
                .font(.headline)
                .padding()
            Button(timerRunning ? "일시정지" : "시작") {
                timerRunning.toggle()
            }
            .padding()
            .background(timerRunning ? Color.red : Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .onReceive(timer) { time in
            guard self.timerRunning else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.timerRunning = false
                // 타이머 종료 시 필요한 동작
            }
        }
    }
    
    
    func scheduleNotification(after duration: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "집중 시간 종료"
        content.body = "설정한 집중 시간이 끝났습니다. 생각을 검토해보세요."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }

}

