//
//  RocketLaunchesCollectionViewCell.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import UIKit

class RocketLaunchesCollectionViewCell: UICollectionViewCell {
    static let identifier = "RocketLaunchesCollectionViewCell"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configure (with viewModel: RocketLaunchesCollectionViewCellViewModel){
        self.flightNumberLabel.text = String(describing: viewModel.flightNumberS ?? 1)
        self.dateLabel.text = viewModel.date
        self.nameLabel.text = viewModel.name
        self.progressView.isHidden = !(viewModel.upcoming ?? false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 8
        self.setLabelsFont()
        self.setLabelsColor()
        self.setImageView()
        self.setProgressView()
        self.nameLabel.numberOfLines = 2
    }
    
    private func setLabelsFont(){
        self.flightNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.dateLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        self.nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    private func setLabelsColor() {
        self.labelContainerView.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        self.nameLabel.textColor = .white
        self.dateLabel.textColor = .white
        self.flightNumberLabel.textColor = .white
    }
    
    private func setImageView() {
        let image = UIImage(named: "RocketImageBackground")
        self.backgroundImageView.image = image
    }
    
    private func setProgressView() {
        self.progressView.progressTintColor = .brown
        self.progressView.trackTintColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flightNumberLabel.text = nil
        self.dateLabel.text = nil
        self.nameLabel.text = nil
    }
    
}
