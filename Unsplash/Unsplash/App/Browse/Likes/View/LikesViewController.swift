//
//  LikesViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

final class LikesViewController: UIViewController, LikesView {
    
    var viewModel: LikesViewModel
    weak var delegate: LikesViewDelegate?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var emptyMessageView = MessageView(
        message: "No picture likes yet!",
        sfSymbolName: "photo.on.rectangle.angled"
    )
    
    private let itemsPerRow: CGFloat = 2
    private let gridAspectRatio: CGFloat = 1.3
    private let pictureSpacing: CGFloat = 16
    
    init(viewModel: LikesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Likes"
        tabBarItem = UITabBarItem(
            title: "Likes",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyMessageView.addToSuperViewAndCenter(self.view)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpCollectionView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        viewModel.fetchPictures()
    }
}

private extension LikesViewController {
    
    func setUpBindings() {
        viewModel.pictures.bind(fire: false) { [weak self] pictures in
            guard let self else {
                return
            }
            self.emptyMessageView.isHidden = pictures.isEmpty ? false : true
            self.collectionView.reloadData()
        }
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: pictureSpacing,
            bottom: pictureSpacing,
            right: pictureSpacing
        )
        layout.minimumLineSpacing = pictureSpacing
        layout.minimumInteritemSpacing = pictureSpacing
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        let nibFile = UINib(nibName: "ImageCell", bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension LikesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemSpacing = pictureSpacing + (pictureSpacing / itemsPerRow)
        let gridWidth = view.frame.width / itemsPerRow - itemSpacing
        return CGSize(width: gridWidth, height: gridWidth * gridAspectRatio)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.pictures.value.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageCell",
            for: indexPath
        ) as? ImageCell else {
            return UICollectionViewCell()
        }
        cell.setUp(imageUrlString: viewModel.pictures.value[indexPath.item].imageUrl)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        
            guard let navigationController else {
                return
            }
            
            let pictureModel = viewModel.pictures.value[indexPath.item]
            delegate?.openPictureDetails(navigationController, model: pictureModel)
    }
}
