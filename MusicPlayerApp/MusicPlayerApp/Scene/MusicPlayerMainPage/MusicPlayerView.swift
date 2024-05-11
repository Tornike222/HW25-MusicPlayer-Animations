//
//  MusicPlayerView.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 11.05.24.
//

import UIKit
import Hex

class MusicPlayerView: UIView {
    var imageLeadingConstraint: NSLayoutConstraint?
    var imageTrailingConstraint: NSLayoutConstraint?
    
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white
        return contentView
    }()
    private let songCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SongCover")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loaderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    let progressStartLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#F2F2F2")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressEndLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#F2F2F2")
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
    
    let playStopButton: UIButton = {
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
        view.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width-40, height: 130)
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 40
        view.layer.shadowColor = UIColor.init(hex: "#A8BACF1A").cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 40
        view.backgroundColor = UIColor.init(hex: "#0A091E")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let homeNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let musicNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let favoritesNavItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        addContentView()
        addBackgroundColor()
        addImageViewToView()
        addLoaderIndicator()
        addSongNameStackView()
        addSongLabelsToStackView()
        addProgressView()
        addProgressStartAndEndTimes()
        addButtons()
        addNavigationView()
        addNavigationButtons()
    }
    
    private func addContentView() {
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addBackgroundColor() {
        contentView.backgroundColor = UIColor.init(hex: "#161411")
    }
    
    private func addImageViewToView() {
        contentView.addSubview(songCoverImageView)
        
        imageLeadingConstraint = songCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35)
        imageTrailingConstraint = songCoverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)
        imageLeadingConstraint?.isActive = true
        imageTrailingConstraint?.isActive = true
        NSLayoutConstraint.activate([
            songCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.12),
            songCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.38)
        ])
    }
    
    private func addLoaderIndicator() {
        contentView.addSubview(loaderImage)
        NSLayoutConstraint.activate([
            loaderImage.topAnchor.constraint(equalTo: songCoverImageView.bottomAnchor, constant: -25),
            loaderImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loaderImage.widthAnchor.constraint(equalToConstant: 50),
            loaderImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func addSongNameStackView() {
        contentView.addSubview(songNameStackView)
        
        NSLayoutConstraint.activate([
            songNameStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            songNameStackView.topAnchor.constraint(equalTo: songCoverImageView.bottomAnchor, constant: 34)
        ])
    }
    
    private func addSongLabelsToStackView() {
        songNameStackView.addArrangedSubview(songNameLabel)
        songNameStackView.addArrangedSubview(songAuthorLabel)
    }
    
    
    private func addProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.topAnchor.constraint(equalTo: songNameStackView.bottomAnchor, constant: 34)
        ])
    }
    
    private func addProgressStartAndEndTimes() {
        contentView.addSubview(progressStartLabel)
        contentView.addSubview(progressEndLabel)
        
        NSLayoutConstraint.activate([
            progressStartLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressStartLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5),
            progressEndLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressEndLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 5)
            
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
        contentView.addSubview(shuffleButton)
        
        NSLayoutConstraint.activate([
            shuffleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            shuffleButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            shuffleButton.widthAnchor.constraint(equalToConstant: 24),
            shuffleButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func addSkipBackButton() {
        contentView.addSubview(skipBackButton)
        
        NSLayoutConstraint.activate([
            skipBackButton.leadingAnchor.constraint(equalTo: shuffleButton.trailingAnchor, constant: 40),
            skipBackButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            skipBackButton.widthAnchor.constraint(equalToConstant: 24),
            skipBackButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func addEllipse() {
        contentView.addSubview(playStopBackgroundImageView)
        
        NSLayoutConstraint.activate([
            playStopBackgroundImageView.leadingAnchor.constraint(equalTo: skipBackButton.trailingAnchor, constant: 40),
            playStopBackgroundImageView.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 34),
            playStopBackgroundImageView.widthAnchor.constraint(equalToConstant: 75),
            playStopBackgroundImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func addPlayStopButton() {
        contentView.addSubview(playStopButton)
        
        NSLayoutConstraint.activate([
            playStopButton.centerXAnchor.constraint(equalTo: playStopBackgroundImageView.centerXAnchor),
            playStopButton.centerYAnchor.constraint(equalTo: playStopBackgroundImageView.centerYAnchor),
            playStopButton.widthAnchor.constraint(equalToConstant: 41),
            playStopButton.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    private func addSkipForwardButton() {
        contentView.addSubview(skipForwardButton)
        
        NSLayoutConstraint.activate([
            skipForwardButton.leadingAnchor.constraint(equalTo: playStopBackgroundImageView.trailingAnchor, constant: 40),
            skipForwardButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            skipForwardButton.widthAnchor.constraint(equalToConstant: 24),
            skipForwardButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addRepeatButton() {
        contentView.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            repeatButton.leadingAnchor.constraint(equalTo: skipForwardButton.trailingAnchor, constant: 40),
            repeatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            repeatButton.topAnchor.constraint(equalTo: progressStartLabel.bottomAnchor, constant: 58),
            repeatButton.heightAnchor.constraint(equalToConstant: 24),
            repeatButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func addNavigationView() {
        contentView.addSubview(navView)
        
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            navView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            navView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            navView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1)
        ])
    }
    
    private func addNavigationButtons() {
        addHomeButton()
        addMusicButton()
        addFavoritesButton()
    }
    
    private func addHomeButton() {
        contentView.addSubview(homeNavItemButton)
        
        NSLayoutConstraint.activate([
            homeNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            homeNavItemButton.centerXAnchor.constraint(equalTo: navView.leadingAnchor, constant: navView.bounds.width / 6)
        ])
    }
    
    private func addMusicButton() {
        contentView.addSubview(musicNavItemButton)
        
        NSLayoutConstraint.activate([
            musicNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            musicNavItemButton.centerXAnchor.constraint(equalTo: navView.centerXAnchor)
        ])
    }
    
    private func addFavoritesButton() {
        contentView.addSubview(favoritesNavItemButton)
        
        NSLayoutConstraint.activate([
            favoritesNavItemButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor),
            favoritesNavItemButton.centerXAnchor.constraint(equalTo: navView.trailingAnchor, constant: -navView.bounds.width / 6)
        ])
    }
}
