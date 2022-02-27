//
//  StaticView.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 27/02/2022.
//

import UIKit

protocol StaticViewDelegate: AnyObject {
    func didChangeSegmentedControl(_ sender: UISegmentedControl)
}

struct StaticViewViewModel {
    let title: String
    let imageView: UIImage
    let ownerName: String
    let ownerDescription: String
    let flightNumber: String
    let date: String
    let description: String
}

class StaticView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ownerImageContainerView: UIView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerDescriptionLabel: UILabel!
    
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: StaticViewDelegate?
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.setFonts()
        self.titleLabel.numberOfLines = 1
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = 8
        self.ownerImageContainerView.layer.cornerRadius = 30
        self.ownerImageView.layer.cornerRadius = 22
        self.ownerImageView.contentMode = .scaleAspectFill
        self.descriptionLabel.numberOfLines = 8
        self.segmentedControl.addTarget(self,
                                        action: #selector((segmentedControlValueChanged(_:))),
                                        for: .valueChanged)
        
           
        let font = UIFont.systemFont(ofSize: 10)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
        self.bottomContainerView.backgroundColor = .clear
        self.segmentedControl.backgroundColor = .white
    }
    
    
    private func setFonts() {
        self.titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        self.ownerNameLabel.font = .systemFont(ofSize: 10)
        self.ownerDescriptionLabel.font = .systemFont(ofSize: 16, weight: .bold)
        self.ownerDescriptionLabel.numberOfLines = 2
        self.flightNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.dateLabel.font = .systemFont(ofSize: 10)
        self.dateLabel.numberOfLines = 2
        self.descriptionLabel.font = .systemFont(ofSize: 10)
        
    }
    func configure(with viewModel: StaticViewViewModel) {
        self.titleLabel.text = viewModel.title
        self.imageView.image = viewModel.imageView
        self.titleLabel.text = viewModel.title
        self.ownerNameLabel.text = viewModel.ownerName
        self.ownerDescriptionLabel.text = viewModel.ownerDescription
        self.flightNumberLabel.text = viewModel.flightNumber
        self.dateLabel.text = viewModel.date
        self.descriptionLabel.text = viewModel.description
        self.ownerImageView.image = UIImage(named: "AliHammoud")
        self.imageView.backgroundColor = .red
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.delegate?.didChangeSegmentedControl(sender)
    }
}
