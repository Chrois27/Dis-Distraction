//
//  AddScheduleView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/9/24.
//

import SwiftUI

struct AddScheduleView: View {
    var thought: ThoughtRecord
    @Environment(\.managedObjectContext) private var viewContext
    @State private var scheduleDate = Date()
    @State private var scheduleDescription = ""
    
    var body: some View {
        Form {
            DatePicker("일정 날짜", selection: $scheduleDate, displayedComponents: .date)
            TextField("일정 설명", text: $scheduleDescription)
            Button("일정 추가") {
                addSchedule()
            }
        }
        .navigationTitle("일정 추가")
    }
    
    private func addSchedule() {
        let newSchedule = Schedule(context: viewContext)
        newSchedule.date = scheduleDate
        newSchedule.title = thought.content ?? "No Title"
        newSchedule.desc = scheduleDescription
        
        do {
            try viewContext.save()
            // 성공적으로 저장되면 피드백을 주거나 화면을 닫습니다.
        } catch {
            // 저장 실패 처리
            print(error.localizedDescription)
        }
    }
}



