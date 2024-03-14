//
//  ScheduleListView.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/9/24.
//

import SwiftUI

struct ScheduleListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Schedule.date, ascending: true)],
        animation: .default)
    private var schedules: FetchedResults<Schedule>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(schedules) { schedule in
                    VStack(alignment: .leading) {
                        Text(schedule.title ?? "Unknown Title")
                            .font(.headline)
                        Text(schedule.desc ?? "No Description")
                            .font(.subheadline)
                        Text("\(schedule.date ?? Date(), formatter: itemFormatter)")
                            .font(.caption)
                    }
                }
                .onDelete(perform: deleteSchedules)
            }
            .navigationBarTitle("일정 목록", displayMode: .inline)
        }
    }
    
    private func deleteSchedules(offsets: IndexSet) {
        withAnimation {
            offsets.map { schedules[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()


#Preview {
    ScheduleListView()
}
