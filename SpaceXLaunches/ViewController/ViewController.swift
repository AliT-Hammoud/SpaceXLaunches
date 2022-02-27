//
//  ViewController.swift
//  SpaceXLaunches
//
//  Created by Ali Hammoud on 2/25/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    private var viewModel: LaunchListViewModelType = LaunchListViewModel()
    private var dataViewModel = [RocketLaunchesCollectionViewCellViewModel]()
    private var staticView: StaticView!
    
    private let staticViewContainerView: UIView = {
        let view = UIView()
        view.frame = .zero
        view.backgroundColor = .clear
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = .zero
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    private let rocketLaunchesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setTabBarItems()
        self.registerCollectionCell()
        self.rocketLaunchesCollectionView.delegate = self
        self.rocketLaunchesCollectionView.dataSource = self
        self.viewModel.fetchLaunchesWithQuery(){ reponses in
            guard let reponse = reponses else { return }
            self.dataViewModel = reponse
            self.rocketLaunchesCollectionView.reloadData()
        }
        self.setStaticView()
    }
    
    private func setTabBarItems() {
        let firstBarButtonItem = UIBarButtonItem(image: UIImage(named: "bell"), style: .done, target: nil, action: nil)
        let secondBarButtonItem = UIBarButtonItem(image: UIImage(named:"searchMagnifier"),  style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [firstBarButtonItem, secondBarButtonItem]
        let leftTabBarTitle = UIBarButtonItem(title: "Launches", style: .done, target: nil, action: nil)
        leftTabBarTitle.tintColor = .black
        navigationItem.leftBarButtonItem = leftTabBarTitle
    }
    
    private func registerCollectionCell() {
        self.rocketLaunchesCollectionView.register(
            UINib(
                nibName: RocketLaunchesCollectionViewCell.identifier,
                bundle: nil),
            forCellWithReuseIdentifier: RocketLaunchesCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setSrollView()
        self.setUpcomingRocketLaunchesCollectionViewConstraints()
        self.scrollView.addSubview(staticViewContainerView)
        self.staticViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.staticViewContainerView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor),
            self.staticViewContainerView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor),
            self.staticViewContainerView.topAnchor.constraint(equalTo: self.rocketLaunchesCollectionView.bottomAnchor, constant: 26),
            self.staticViewContainerView.heightAnchor.constraint(equalToConstant: 450),
            self.staticViewContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    private func setSrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.scrollView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpcomingRocketLaunchesCollectionViewConstraints () {
        self.scrollView.addSubview(self.rocketLaunchesCollectionView)
        self.rocketLaunchesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.rocketLaunchesCollectionView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 24),
            self.rocketLaunchesCollectionView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor),
            self.rocketLaunchesCollectionView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30),
            self.rocketLaunchesCollectionView.heightAnchor.constraint(equalToConstant: 200.5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setStaticView() {
        
        self.staticView = StaticView().loadNib() as? StaticView
        
        self.staticViewContainerView.addSubview(self.staticView)
        staticView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            staticView.leadingAnchor.constraint(
                equalTo: self.staticViewContainerView.leadingAnchor),
            staticView.trailingAnchor.constraint(
                equalTo: self.staticViewContainerView.trailingAnchor),
            staticView.bottomAnchor.constraint(
                equalTo: self.staticViewContainerView.safeAreaLayoutGuide.bottomAnchor),
            staticView.topAnchor.constraint(
                equalTo: self.staticViewContainerView.safeAreaLayoutGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.staticView.delegate = self
        self.staticView.configure(with: Constants().staticViewViewModelArray[0])
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let launchModel = self.dataViewModel[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketLaunchesCollectionViewCell.identifier,
            for: indexPath) as? RocketLaunchesCollectionViewCell else {
                return UICollectionViewCell()
            }

        cell.configure(with: launchModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = self.dataViewModel[indexPath.row]
        let vc = SecondViewController(with: item)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 191, height: 200.5)
    }
}


extension ViewController: StaticViewDelegate {
    
    func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        self.staticView.configure(with: Constants().staticViewViewModelArray[sender.selectedSegmentIndex])
    }
}
