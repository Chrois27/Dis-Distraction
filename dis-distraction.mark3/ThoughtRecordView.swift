//
//  ThoughtRecordView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI

struct ThoughtRecordView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var thoughtContent = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("여기에 생각을 기록하세요...", text: $thoughtContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("저장") {
                    addThoughtRecord()
                    thoughtContent = "" // 입력 필드 초기화
                }
                .padding()
                .disabled(thoughtContent.isEmpty)
            }
            .navigationBarTitle("생각 기록", displayMode: .inline)
        }
    }
    
    private func addThoughtRecord() {
        withAnimation {
            let newThought = ThoughtRecord(context: viewContext)
            newThought.content = thoughtContent
            newThought.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // 저장 실패 처리
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    ThoughtRecordView()
}
