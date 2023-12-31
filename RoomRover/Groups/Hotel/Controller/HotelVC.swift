//
//  HotelVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 11.09.23.
//

import UIKit

class HotelVC: UIViewController {

    // - UI
    @IBOutlet var pageControlView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var hotelNameLabel: UILabel!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var grayPriceLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var starView: UIView!
    @IBOutlet var choiseRoom: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var aboutHotel: UILabel!
    @IBOutlet var hotelDescription: UILabel!
    @IBOutlet var stackView: UIView!
    @IBOutlet var fourthGrayLabel: UILabel!
    @IBOutlet var thirdGrayLabel: UILabel!
    @IBOutlet var secondGrayLabel: UILabel!
    @IBOutlet var firstGrayLabel: UILabel!
    @IBOutlet var pageControl: [UIView]!
    
    // - Data
    private var model: HotelData?
    private var selectedItem = 0
    
    // - Manager
    private var layout: HotelLayoutManager!
    private var coordinator: CoordinatorManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func choiseRoomButtonAction() {
//        coordinator.showPayedVC()
        coordinator.showRoomVC(name: model?.name ?? "")
    }
}

// MARK: -
// MARK: Configure
private extension HotelVC {
    func configure() {
        configureLayout()
        configureCoordinator()
        configureData()
        configureCollectionView()
    }
    
    func configureLayout() {
        layout = HotelLayoutManager(vc: self)
    }
    
    func configureCoordinator() {
        coordinator = CoordinatorManager(viewController: self)
    }
    
    func configureData() {
        if let model = MyLaunchVC.mainModel {
            self.model = model
            layout.setupUI(model: model, animate: true)
        } else {
            getHotelData()
        }
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getHotelData() {
        GetRequests.shared.getHotelData { hotelModel in
            if let model = hotelModel{
                DispatchQueue.main.async { [weak self] in
                    guard let sSelf = self else { return }
                    sSelf.model = model
                    sSelf.layout.setupUI(model: model, animate: false)
                    sSelf.collectionView.reloadData()
                }
            }
        }
    }
    
    func muPageControl() {
        if selectedItem == 0 {
            pageControl[0].backgroundColor = .black
            pageControl[1].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.22)
            pageControl[2].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        } else if selectedItem == 1 {
            pageControl[1].backgroundColor = .black
            pageControl[0].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            pageControl[2].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.22)
        } else if selectedItem == 2 {
            pageControl[2].backgroundColor = .black
            pageControl[1].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.22)
            pageControl[0].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    }
}

// MARK: -
// MARK: CollectionViewDataSource
extension HotelVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.imageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCVC", for: indexPath) as! HotelCVC
        cell.setupImage(data: model?.imageUrls[indexPath.item] ?? "")
        return cell
    }
}

// MARK: -
// MARK: CollectionViewDelegate
extension HotelVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 257)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = scrollView.contentOffset.x / scrollView.frame.width
        selectedItem = Int(currentIndex)
        muPageControl()
    }
}
