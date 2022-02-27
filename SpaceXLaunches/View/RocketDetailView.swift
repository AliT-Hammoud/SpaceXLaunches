//
//  RocketDetailView.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/26/22.
//

import UIKit

protocol RocketDetailViewDelegate: AnyObject {
    func didTabReadMoreButton(_ sender: Any)
}

class RocketDetailView: UIView {
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    weak var delegate: RocketDetailViewDelegate?
    
    init(){
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 30, height:  30))

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        self.descriptionLabel.numberOfLines = 5
        let readMoreText = "Read more".capitalized
        let shareText = "share".capitalized
        self.readMoreButton.setTitle(readMoreText, for: .normal)
        self.shareButton.setTitle(shareText, for: .normal)

//        203 155 3
//        self.shareButton.tintColor = UIColor(red: 1, green: 0.58, blue: 0, alpha: 1)
        
        self.setLabelsColor()
    }
    
    private func setLabelsColor() {
//        157 157 168
//        self.descriptionLabel.textColor = .gray
    }
    
    
    
    func configure(with viewModel: RocketDetailViewViewModel, secondViewmodel: SecondViewControllerViewModel) {
        self.rocketNameLabel.text = viewModel.name
        self.flightNumberLabel.text = String(describing: secondViewmodel.flightNumberS ?? 1)
        self.dateLabel.text = secondViewmodel.date
        self.descriptionLabel.text = viewModel.description
    }
    
    
    @IBAction func readMoreButtonAction(_ sender: Any) {
        print("readMoreButtonAction")
        self.delegate?.didTabReadMoreButton(sender)
    }
    
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        print("shareButtonAction")
    }
    
    
}
