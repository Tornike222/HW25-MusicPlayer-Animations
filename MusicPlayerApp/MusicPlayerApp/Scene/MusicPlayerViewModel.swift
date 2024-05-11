//
//  NavigationController.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 10.05.24.
//

import Foundation

final class MusicPlayerViewModel {
    var totalTime = 195.0
    var currentTime = 0.0
    var inProgress = false
    
    func formatToString(enter time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
}
