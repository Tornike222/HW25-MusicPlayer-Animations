//
//  ViewController.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 09.05.24.
//

import UIKit
import Hex

final class MusicPlayerViewController: UIViewController {
    private var musicPlayerView = MusicPlayerView()
    private var viewModel: MusicPlayerViewModel!
    
    
    //MARK: - Lifecycle
    init(viewModel: MusicPlayerViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMusicPlayerViewToView()
        homeButtonTapped()
        addProgressViewFunctionality()
        addDynamicTime()
    }
    
    //MARK: - Add view to ViewController
    private func addMusicPlayerViewToView() {
        view.addSubview(musicPlayerView)
        musicPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            musicPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            musicPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            musicPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    //MARK: - Functions of main functionality
    private func addDynamicTime() {
        musicPlayerView.progressEndLabel.text = viewModel.formatToString(enter: viewModel.totalTime)
        musicPlayerView.progressStartLabel.text = viewModel.formatToString(enter: viewModel.currentTime)
    }
    
    private func homeButtonTapped() {
        let navButton = [musicPlayerView.homeNavItemButton, 
                         musicPlayerView.musicNavItemButton,
                         musicPlayerView.favoritesNavItemButton]
        
        navButton.forEach { button in
            button.addAction(UIAction.init(handler: { [weak self] _ in
                self?.deactivateOldAndActivateNewIcon(on: button)
            }), for: .touchUpInside)
        }
    }
    
    private func deactivateOldAndActivateNewIcon(on button: UIButton) {
        changeButtonColorToGrayAndDecreaseSize()
        activateIcon(on: button)
    }
    
    private func activateIcon(on button: UIButton) {
        changeSize(on: button, to: 40)
        
        UIView.animate(withDuration: 0.3) {
            button.tintColor = .systemBlue
            self.view.layoutIfNeeded()
        }
    }
    
    private func changeButtonColorToGrayAndDecreaseSize() {
        self.changeSize(on: musicPlayerView.homeNavItemButton, to: 24)
        self.changeSize(on: musicPlayerView.musicNavItemButton, to: 24 )
        self.changeSize(on: musicPlayerView.favoritesNavItemButton, to: 24)
        
        UIView.animate(withDuration: 0.3) {
            self.musicPlayerView.homeNavItemButton.tintColor = .lightGray
            self.musicPlayerView.musicNavItemButton.tintColor = .lightGray
            self.musicPlayerView.favoritesNavItemButton.tintColor = .lightGray
            self.view.layoutIfNeeded()
        }
    }
    
    private func changeSize(on button: UIButton, to size: Int) {
        let currentImage = button.currentImage
        let currentConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat(size))
        let newImage = currentImage!.withConfiguration(currentConfiguration)
        button.setImage(newImage, for: .normal)
    }
    
    private func addProgressViewFunctionality() {
        musicPlayerView.playStopButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.progressBar()
        }), for: .touchUpInside)
    }
    
    private func progressBar() {
        if !viewModel.inProgress {
            musicPlayerView.playStopButton.setImage(UIImage(named: "pause"), for: .normal)
            viewModel.inProgress = true
            if viewModel.currentTime > 0 { // პირველი გაშვების დასაჰენდლად რომ არ ჩაიტვირთოს ლოადერი
                continueButtonLogic()
            } else {
                setupProgress()
            }
            
        } else {
            musicPlayerView.playStopButton.setImage(UIImage(named: "play"), for: .normal)
            viewModel.inProgress = false
            musicPlayerView.imageLeadingConstraint?.constant = 85
            musicPlayerView.imageTrailingConstraint?.constant = -85
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.view.layoutIfNeeded()
            }

        }
    }
    
    private func continueButtonLogic() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.stopAnimation()
                self?.setupProgress()
                self?.musicPlayerView.imageLeadingConstraint?.constant = 35
                self?.musicPlayerView.imageTrailingConstraint?.constant = -35
                UIView.animate(withDuration: 0.5) {
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
    
    private func setupProgress() {
        viewModel.currentTime += 0.005
        let progress = Float(viewModel.currentTime / viewModel.totalTime)
        UIView.animate(withDuration: 0.02) {
            self.musicPlayerView.progressView.setProgress(progress, animated: true)
        }
    
        if viewModel.currentTime < viewModel.totalTime && viewModel.inProgress {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) { [weak self] in
                self?.setupProgress()
                self!.musicPlayerView.progressEndLabel.text = self?.viewModel.formatToString(enter: self!.viewModel.totalTime - self!.viewModel.currentTime + 1)
                self!.musicPlayerView.progressStartLabel.text = self?.viewModel.formatToString(enter: self!.viewModel.currentTime)
            }
        }
    }

    private func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        musicPlayerView.loaderImage.image = UIImage(named: "loader")
        musicPlayerView.loaderImage.layer.add(rotation, forKey: "spin")
    }
    
    private func stopAnimation() {
        musicPlayerView.loaderImage.layer.removeAllAnimations()
        musicPlayerView.loaderImage.image = UIImage()
    }
    
}

