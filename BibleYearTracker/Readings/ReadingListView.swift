//
//  ReadingListView.swift
//  BibleYearTracker
//
//  Created by Donovan LaDuke on 10/20/23.
//

import SwiftUI

struct ReadingListView: View {
    let days: [BibleDayModel]
    
    var body: some View {
        List(days) { day in
            HStack {
                Text("\(day.offset)")
            
                ForEach(day.readings) { reading in
                    Text(reading.description)
                }
            }
        }
    }
    
    init() {
        days = ReadingsLocalDataSource.getReadings()
    }
}

#Preview {
    ReadingListView()
}
