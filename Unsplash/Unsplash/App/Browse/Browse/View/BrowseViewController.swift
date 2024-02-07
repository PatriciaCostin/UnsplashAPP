//
//  BrowseViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit
import SDWebImage
import Combine

final class BrowseViewController: UIViewController, BrowseView {
    
    var viewModel: BrowseViewModel
    weak var delegate: BrowseViewDelegate?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var emptyMessageView = MessageView(
        message: "No pictures found!",
        sfSymbolName: "photo.on.rectangle.angled"
    )
    private var footerView: FooterView?
    
    private var portraitButton: UIBarButtonItem!
    private var gridButton: UIBarButtonItem!
    
    private let itemsPerRow: CGFloat = 2
    private let gridAspectRatio: CGFloat = 1.3
    private let portraitAspectRatio: CGFloat = 1.3
    private let pictureSpacing: CGFloat = 16
    private let footerHeight: CGFloat = 50
    private let remainingCellsBeforeEnd: Int = 4
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: BrowseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Browse"
        tabBarItem = UITabBarItem(
            title: "Browse",
            image: .init(systemName: "magnifyingglass"),
            selectedImage: .init(systemName: "magnifyingglass.circle.fill")
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBarView()
        setUpCollectionView()
        setupNavigationButtons()
        emptyMessageView.addToSuperViewAndCenter(self.view)
        setupBindings()
        viewModel.fetchPictures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

private extension BrowseViewController {
    func setupBindings() {

        viewModel.presentationMode.bind(fire: true, { [weak self] mode in
            guard let self else {
                return
            }
            self.viewModel.updatePresentation(to: mode)
        })
        
        viewModel.requestState.bind(fire: false) { [weak self] request in
            guard let self else {
                return
            }
            
            switch request {
            case .loading:
                footerView?.showSpinner(true)
                emptyMessageView.isHidden = true
            case .finished:
                footerView?.showSpinner(false)
                emptyMessageView.isHidden = true
                self.collectionView.reloadData()
            case .noData:
                footerView?.showSpinner(false)
                emptyMessageView.isHidden = false
                self.collectionView.reloadData()
            case .noMoreData:
                self.footerView?.showSpinner(false)
            }
        }
    }
    
    func setUpSearchBarView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        let searchController = UISearchController(searchResultsController: nil)
        let textPublisher = searchController.searchBar.searchTextField.textPublisher()
        textPublisher.receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.viewModel.query = value
            })
            .store(in: &cancellables)
        
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
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
        collectionView.register(
            FooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "FooterView"
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupNavigationButtons() {
        
        let portraitImage = viewModel.presentationMode.value == .feed
                          ? BrowsePresentationMode.feed.filledImageName
                          : BrowsePresentationMode.feed.imageName
        
        let gridImage = viewModel.presentationMode.value == .grid
                      ? BrowsePresentationMode.grid.filledImageName
                      : BrowsePresentationMode.grid.imageName
        
        portraitButton = UIBarButtonItem(
            image: UIImage(systemName: portraitImage),
            style: .plain,
            target: self,
            action: #selector(portraitButtonTapped)
        )
        portraitButton.tintColor = UIColor(named: "mainColor")
        
        gridButton = UIBarButtonItem(
            image: UIImage(systemName: gridImage),
            style: .plain,
            target: self,
            action: #selector(gridButtonTapped)
        )
        gridButton.tintColor = UIColor(named: "mainColor")
        navigationItem.rightBarButtonItems = [gridButton, portraitButton]
    }
    
    @objc func portraitButtonTapped() {
        portraitButton.image = UIImage(systemName: BrowsePresentationMode.feed.filledImageName)
        gridButton.image = UIImage(systemName: BrowsePresentationMode.grid.imageName)
        viewModel.presentationMode.value = .feed
        collectionView.reloadData()
    }
    
    @objc func gridButtonTapped() {
        portraitButton.image = UIImage(systemName: BrowsePresentationMode.feed.imageName)
        gridButton.image = UIImage(systemName: BrowsePresentationMode.grid.filledImageName)
        viewModel.presentationMode.value = .grid
        collectionView.reloadData()
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch viewModel.presentationMode.value {
        case .grid:
            let itemSpacing = pictureSpacing + (pictureSpacing / itemsPerRow)
            let gridWidth = view.frame.width / itemsPerRow - itemSpacing
            return CGSize(width: gridWidth, height: gridWidth * gridAspectRatio)
        case .feed:
            let portraitWidth = view.frame.width - (pictureSpacing * 2)
            return CGSize(width: portraitWidth, height: portraitWidth * portraitAspectRatio)
        }
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
        cell.setUp(imageUrlString: viewModel.pictures.value[indexPath.row].imageURL)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
            
        let pictureID = viewModel.pictures.value[indexPath.item].imageID
        openPictureDetails(with: pictureID)
    }
    
    private func openPictureDetails(with id: String) {
        
        guard let navigationController else {
            return
        }
        self.showSpinner()
        viewModel.fetchPictureDetails(
            pictureID: id
        ) { result in
            
            switch result {
            case .success(let pictureModel):
                DispatchQueue.main.async {
                    if let imageUrl = URL(string: pictureModel.imageUrl) {
                        SDWebImagePrefetcher.shared.prefetchURLs([imageUrl]) { _, _ in
                            self.hideSpinner()
                            self.delegate?.openPictureDetails(navigationController, model: pictureModel)
                        }
                    }
                }
            case .failure:
                self.hideSpinner()
                self.showAlert(title: "Error", message: "Can't fetch picture details")
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "FooterView",
                for: indexPath
            ) as? FooterView else {
                return UICollectionReusableView()
            }
            
            self.footerView = footerView
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: footerHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if (indexPath.item + remainingCellsBeforeEnd) == viewModel.pictures.value.count {
            viewModel.fetchPictures()
        }
    }
}

extension BrowseViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.query = ""
    }
}

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}
