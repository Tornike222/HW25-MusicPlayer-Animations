//
//  ViewController.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 09.05.24.
//

import UIKit
import Hex

class MusicPlayerViewController: UIViewController {
    //MARK: - UI Components
    private let songCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SongCover")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let songNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#F2F2F2")
        label.text = "So Long, London"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let songAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#8E8E8E")
        label.text = "Taylor Swift"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressView = UIProgressView(progressViewStyle: .default)
    
    private let progressStartLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#F2F2F2")
        label.text = "1:25"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressEndLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#F2F2F2")
        label.text = "3:15"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shuffle"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let skipBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip-back"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playStopBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.shadowColor = UIColor.init(hex: "#7A51E259", opacity: 0.35).cgColor
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private let playStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let skipForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip-forward"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "repeat"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width-40, height: 100)
        view.roundCorners(corners: [.topLeft, .topRight], radius: 40)
        view.backgroundColor = UIColor.init(hex: "#0A091E")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()    
    
    private let homeNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let musicNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoritesNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeButtonTapped()
    }
    
    
    //MARK: - UI Setup
    private func setupUI() {
        addBackgroundColor()
        addImageViewToView()
        addSongNameStackView()
        addSongLabelsToStackView()
        addProgressView()
        addProgressStartAndEndTimes()
        addButtons()
        addNavigationView()
        addNavigationButtons()
    }

    private func addBackgroundColor() {
        view.backgroundColor = UIColor.init(hex: "#161411")
    }
    
    
    private func addImageViewToView() {
        view.addSubview(songCoverImageView)
        
        NSLayoutConstraint.activate([
            songCoverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            songCoverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            songCoverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            songCoverImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func addSongNameStackView() {
        view.addSubview(songNameStackView)
        
        NSLayoutConstraint.activate([
            songNameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songNameStackView.topAnchor.constraint(equalTo: songCoverImageView.bottomAnchor, constant: 34)
        ])
    }
    
    private func addSongLabelsToStackView() {
        songNameStackView.addArrangedSubview(songNameLabel)
        songNameStackView.addArrangedSubview(songAuthorLabel)
    }
    
    
    private func addProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.3, animated: true)
        
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.topAnchor.constraint(equalTo: songNameStackView.bottomAnchor, constant: 34)
        ])
    }
    
    private func addProgressStartAndEndTimes() {
        view.addSubview(progressStartLabel)
        view.addSubview(progressEndLabel)
        
        NSLayoutConstraint.activate([
            progressStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressStartLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 1),
            progressEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressEndLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 1)
            
        ])
    }
    
    private func addButtons() {
        addShuffleButton()
        addSkipBackButton()
        addEllipse()
        addPlayStopButton()
        addSkipForwardButton()
        addRepeatButton()
    }
    
    
    private func addShuffleButton() {
        view.addSubview(shuffleButton)
        
        NSLayoutConstraint.activate([
            shuffleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shuffleButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            shuffleButton.widthAnchor.constraint(equalToConstant: 24),
            shuffleButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func addSkipBackButton() {
        view.addSubview(skipBackButton)
        
        NSLayoutConstraint.activate([
            skipBackButton.leadingAnchor.constraint(equalTo: shuffleButton.trailingAnchor, constant: 40),
            skipBackButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            skipBackButton.widthAnchor.constraint(equalToConstant: 24),
            skipBackButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func addEllipse() {
        view.addSubview(playStopBackgroundImageView)
        
        NSLayoutConstraint.activate([
            playStopBackgroundImageView.leadingAnchor.constraint(equalTo: skipBackButton.trailingAnchor, constant: 40),
            playStopBackgroundImageView.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 34),
            playStopBackgroundImageView.widthAnchor.constraint(equalToConstant: 75),
            playStopBackgroundImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func addPlayStopButton() {
        view.addSubview(playStopButton)
        
        NSLayoutConstraint.activate([
            playStopButton.centerXAnchor.constraint(equalTo: playStopBackgroundImageView.centerXAnchor),
            playStopButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            playStopButton.widthAnchor.constraint(equalToConstant: 24),
            playStopButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addSkipForwardButton() {
        view.addSubview(skipForwardButton)
        
        NSLayoutConstraint.activate([
            skipForwardButton.leadingAnchor.constraint(equalTo: playStopBackgroundImageView.trailingAnchor, constant: 40),
            skipForwardButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            skipForwardButton.widthAnchor.constraint(equalToConstant: 24),
            skipForwardButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addRepeatButton() {
        view.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            repeatButton.leadingAnchor.constraint(equalTo: skipForwardButton.trailingAnchor, constant: 40),
            repeatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            repeatButton.heightAnchor.constraint(equalToConstant: 24),
            repeatButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addNavigationView() {
        view.addSubview(navView)
        
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            navView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            navView.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    private func addNavigationButtons() {
        addHomeButton()
        addMusicButton()
        addFavoritesButton()
    }
    
    private func addHomeButton() {
        view.addSubview(homeNavItemButton)
        
        NSLayoutConstraint.activate([
            homeNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            homeNavItemButton.centerXAnchor.constraint(equalTo: navView.leadingAnchor, constant: navView.bounds.width / 6)
        ])
    }

    private func addMusicButton() {
        view.addSubview(musicNavItemButton)
        
        NSLayoutConstraint.activate([
            musicNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            musicNavItemButton.centerXAnchor.constraint(equalTo: navView.centerXAnchor)
        ])
    }

    private func addFavoritesButton() {
        view.addSubview(favoritesNavItemButton)
        
        NSLayoutConstraint.activate([
            favoritesNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            favoritesNavItemButton.centerXAnchor.constraint(equalTo: navView.trailingAnchor, constant: -navView.bounds.width / 6)
        ])
    }
    
    private func homeButtonTapped() {
        homeNavItemButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.deactivateOldAndActivateNewIcon(on: self!.homeNavItemButton)
        }), for: .touchUpInside)
        
    }
    private func deactivateOldAndActivateNewIcon(on button: UIButton) {
        changeButtonColorToGray()
        activateIcon(on: button)
    }
    
    private func activateIcon(on button: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            button.tintColor = .systemBlue
        }
    }
    
    private func changeButtonColorToGray() {
        homeNavItemButton.tintColor = .lightGray
        musicNavItemButton.tintColor = .lightGray
        favoritesNavItemButton.tintColor = .lightGray
    }
    
}

