//
//  RoomTVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 12.09.23.
//

import UIKit

class RoomTVC: UITableViewCell {

    // - UI
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControlView: UIView!
    @IBOutlet var descripLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var aboutRoomButton: UIButton!
    @IBOutlet var priceLAbel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var selectRoomBut: UIButton!
    @IBOutlet var pageControl: [UIView]!
    
    // - Data
    private var images = [String]()
    private var selectedItem = 0
    
    // - Delegate
    weak var delegate: OpenBookingVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func setupUI(model: Rooms) {
        descripLabel.text = model.name
        firstLabel.text = "   \(model.peculiarities[0])   "
        secondLabel.text = "   \(model.peculiarities[1])   "
        priceLAbel.text = "\(model.price) ₽"
        dayLabel.text = model.pricePer
        images = model.imageUrls
    }
    
    @IBAction func selectRoomButAct() {
        delegate?.open()
    }
}

// MARK: -
// MARK: Configure
private extension RoomTVC {
    func configure() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
extension RoomTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCVC", for: indexPath) as! RoomCVC
        cell.setupImage(data: images[indexPath.item])
        return cell
    }
}

// MARK: -
// MARK: CollectionViewDelegate
extension RoomTVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 257)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = scrollView.contentOffset.x / scrollView.frame.width
        selectedItem = Int(currentIndex)
        muPageControl()
    }
}

protocol OpenBookingVCDelegate: AnyObject {
    func open()
}
