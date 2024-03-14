//
//  ThoughtReviewView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI

struct ThoughtReviewView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ThoughtRecord.timestamp, ascending: false)],
        animation: .default)
    private var thoughts: FetchedResults<ThoughtRecord>

    var body: some View {
        NavigationView {
            List {
                ForEach(thoughts) { thought in
                    NavigationLink(destination: AddScheduleView(thought: thought)) {
                        Text(thought.content ?? "Unknown Thought")
                    }
                }
                .onDelete(perform: deleteThoughts)
            }
            .navigationBarTitle("생각 검토", displayMode: .inline)
        }
    }
    
    private func deleteThoughts(offsets: IndexSet) {
        withAnimation {
            offsets.map { thoughts[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

