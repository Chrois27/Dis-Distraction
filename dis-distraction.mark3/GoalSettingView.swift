//
//  GoalSettingView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI
import CoreData

struct GoalSettingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var goalText = ""
    @State private var durationText = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("목표 설정")) {
                    TextField("목표를 입력하세요", text: $goalText)
                    TextField("집중 시간(분)", text: $durationText)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button("저장") {
                        saveGoal()
                    }
                }
            }
            .navigationBarTitle("새 목표", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
    }

    private func saveGoal() {
        let duration = Int(durationText) ?? 0 // 입력된 텍스트를 Int로 변환, 실패 시 0
        guard !goalText.isEmpty, duration > 0 else {
            alertMessage = "모든 필드를 올바르게 입력해주세요."
            showAlert = true
            return
        }

        let newGoal = Goal(context: viewContext)
        newGoal.name = goalText
        newGoal.duration = Int16(duration)

        do {
            try viewContext.save()
            alertMessage = "목표가 저장되었습니다."
        } catch {
            alertMessage = "목표를 저장하는데 실패했습니다. 다시 시도해주세요."
            viewContext.rollback() // 실패 시 변경사항 롤백
        }
        showAlert = true
    }
}



struct GoalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.preview // 미리보기를 위한 PersistenceController 인스턴스
        GoalSettingView().environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

