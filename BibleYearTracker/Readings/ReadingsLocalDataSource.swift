//
//  ReadingsLocalDataSource.swift
//  BibleYearTracker
//
//  Created by Donovan LaDuke on 11/15/23.
//

import Foundation

class ReadingsLocalDataSource {
    static func getReadings() -> [BibleDayModel] {
        let readingsData: BibleDataModel = Bundle.main.decode("bible_data.json")
        
        return readingsData.days.map { BibleDayModel(dataModel: $0)}
    }
}


extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
