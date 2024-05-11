//
//  NavigationController.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 10.05.24.
//

import Foundation

protocol MusicPlayerViewModelDelegate: AnyObject {
    func setPauseImage()
    func continueButtonLogic()
    func setPlayIconAndIncreaseImageSize()
    func setProgress(progress: Float)
    func updateTextLabels(progressStartTime: Double, progressEndTime: Double)
}

final class MusicPlayerViewModel {
    var totalTime = 195.0
    var currentTime = 0.0
    var inProgress = false
    weak var delegate: MusicPlayerViewModelDelegate?
    
    func formatToString(enter time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func progressBar() {
        if !inProgress {
            delegate?.setPauseImage()
            inProgress = true
            if currentTime > 0 { // პირველი გაშვების დასაჰენდლად რომ არ ჩაიტვირთოს ლოადერი
                delegate?.continueButtonLogic()
            } else {
                setupProgress()
            }
            
        } else {
            inProgress = false
            delegate?.setPlayIconAndIncreaseImageSize()
        }
    }
    
    func setupProgress() {
        currentTime += 0.005
        let progress = Float(currentTime / totalTime)
        delegate?.setProgress(progress: progress)
        
        if currentTime < totalTime && inProgress {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) { [weak self] in
                self?.setupProgress()
                self?.delegate?.updateTextLabels(progressStartTime: self!.currentTime, progressEndTime: self!.totalTime - self!.currentTime + 1)
            }
        }
    }
    
    
}
