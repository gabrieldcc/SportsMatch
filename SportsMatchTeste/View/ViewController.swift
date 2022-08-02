//
//  ViewController.swift
//  SportsMatchTeste
//
//  Created by Gabriel de Castro Chaves on 01/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Vars
    let service = Service()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apiRequest()
        setupView()
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerCountryLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var percentRoudedView: UIView!
    @IBOutlet weak var wonCupsProgessView: UIProgressView!
    @IBOutlet weak var wonCupsPositionLabel: UILabel!
    @IBOutlet weak var playedCupsPositionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var playedCupsProgressBarView: UIView!
    @IBOutlet weak var playedCupsProgressBarHStackView: UIStackView!
    @IBOutlet weak var winsProgressBarView: UIView!
    @IBOutlet weak var winsProgressBarHStackView: UIStackView!
    @IBOutlet weak var wonCupsLabel: UILabel!
    @IBOutlet weak var playedCupsLabel: UILabel!
    
    //MARK: - Setup View
    func setupView() {
        setupPlayerImageView()
        setupPercentView()
        backgroundImageView.image = UIImage(named: "ballbackimage")
        setupProgressBarHStackView()
    }
    
    func setupPlayerImageView() {
        playerImageView.layer.cornerRadius = playerImageView.frame.height / 2
        playerImageView.layer.masksToBounds = true
        playerImageView.layer.borderWidth = 4
    }
    
    func setupPercentView() {
        percentRoudedView.layer.cornerRadius = percentRoudedView.frame.height / 2
        percentRoudedView.layer.masksToBounds = true
        percentRoudedView.layer.borderWidth = 3
    }
    
    func setupProgressBarHStackView() {
        winsProgressBarHStackView.layer.cornerRadius = 15
        winsProgressBarHStackView.layer.masksToBounds = true
        winsProgressBarHStackView.layer.borderWidth = 2
        playedCupsProgressBarHStackView.layer.cornerRadius = 15
        playedCupsProgressBarHStackView.layer.masksToBounds = true
        playedCupsProgressBarHStackView.layer.borderWidth = 2
    }
    
    func setupProgressBar(barView: UIView, barStackView: UIView, number: Double, divideBy: Double) {
        let multiplier = CGFloat(number / divideBy)
        barView.widthAnchor.constraint(equalTo: barStackView.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    //MARK: - API Request
    func apiRequest() {
        service.makeRequest(completion: { data in
            
            guard let player = data.object.first?.player else { return }
            let playerImage = player.img
            let playerName = player.name
            let playerCountry = player.country
            let playerPosition = player.pos
            let playerPercent = player.percentual
            let maxCupsWon = player.barras.copasDoMundoVencidas.max
            let wonCups = player.barras.copasDoMundoVencidas.pla
            let winRankingPosition = player.barras.copasDoMundoVencidas.pos
            let maxCupsPlayed = player.barras.copasDoMundoDisputadas.max
            let playedCups = player.barras.copasDoMundoDisputadas.pla
            let playedCupsRankingPosition = player.barras.copasDoMundoDisputadas.pos
            let maxWonCupsDouble = Double(maxCupsWon)
            let wonCupsDouble = Double(wonCups)
            let maxPlayedCupsDouble = Double(maxCupsPlayed)
            let playedCupsDouble = Double(playedCups)
            
            self.playerImageView.loadFrom(URLAddress: playerImage)
            self.playerNameLabel.text = playerName
            self.playerCountryLabel.text = playerCountry
            self.playerPositionLabel.text = playerPosition
            self.percentLabel.text = "\(String(format: "%.3f", playerPercent))%"
            self.wonCupsPositionLabel.text = "\(winRankingPosition)º"
            self.playedCupsPositionLabel.text = "\(playedCupsRankingPosition)º"
            self.wonCupsLabel.text = "\(wonCups)"
            self.playedCupsLabel.text = "\(playedCups)"
            
            self.setupProgressBar(barView: self.winsProgressBarView, barStackView: self.winsProgressBarHStackView, number: wonCupsDouble, divideBy: maxWonCupsDouble)
            
            self.setupProgressBar(barView: self.playedCupsProgressBarView, barStackView: self.playedCupsProgressBarHStackView, number: playedCupsDouble, divideBy: maxPlayedCupsDouble)
        })
    }
    
}

