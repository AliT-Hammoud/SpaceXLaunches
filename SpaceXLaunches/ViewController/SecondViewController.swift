//
//  SecondViewController.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/26/22.
//

import UIKit

struct SecondViewControllerViewModel {
    var rocket: String
    let date: String?
    let flightNumberS: Int?
    let dateLocal: String?

    init(with viewModel: RocketLaunchesCollectionViewCellViewModel) {
        self.rocket = viewModel.rocket ?? ""
        self.date = viewModel.date
        self.flightNumberS = viewModel.flightNumberS
        self.dateLocal = viewModel.date
    }
}

class SecondViewController: UIViewController {
    var viewModel: RocketDetailViewModelType = RocketDetailViewModel()
//    var dataViewModel = [RocketLaunchesCollectionViewCellViewModel]()
    private var data: SecondViewControllerViewModel
    private var wikiURL = URL(string: "")
    private let backgroundImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private var rocketDetailContentView: RocketDetailView!
    
    
    init(with data: RocketLaunchesCollectionViewCellViewModel) {
        self.data = SecondViewControllerViewModel(with: data)
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setTabBarItems()
        self.setBackgroundImage()
        self.viewModel.fetchRocket(rocketName: self.data.rocket) { [weak self] rocketResponse in
            guard let self = self else {return}
            guard let rocketResponse = rocketResponse else {return}
            DispatchQueue.main.async {
                self.setRocketDetailView()
                self.backgroundImageView.load(url: rocketResponse.flickr_images?.first ?? URL(fileURLWithPath: ""))
                self.rocketDetailContentView.configure(with: rocketResponse, secondViewmodel: self.data)
                self.wikiURL = rocketResponse.wikipedia
                self.rocketDetailContentView.delegate = self
            }
        }
    }
    
    private func setTabBarItems() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        let tabbar1 = UIBarButtonItem(barButtonSystemItem: .stop,
                                      target: self,
                                      action: #selector(self.dismissVC(_ :)))
        tabbar1.tintColor = .black
        navigationItem.rightBarButtonItem = tabbar1
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = .white
        
    }
    
    private func setBackgroundImage() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            backgroundImageView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 0),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 0),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -350),
            backgroundImageView.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 0),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 424)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setRocketDetailView () {
        self.rocketDetailContentView = RocketDetailView().loadNib() as? RocketDetailView
        
        self.view.addSubview(rocketDetailContentView)
        rocketDetailContentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            rocketDetailContentView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 0),
            rocketDetailContentView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 0),
            rocketDetailContentView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: 20),
            rocketDetailContentView.heightAnchor.constraint(equalToConstant: 424)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func dismissVC(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
}


extension SecondViewController: RocketDetailViewDelegate {
    func didTabReadMoreButton(_ sender: Any) {
        if let url = wikiURL {
            UIApplication.shared.open(url)
        }
    }
}
