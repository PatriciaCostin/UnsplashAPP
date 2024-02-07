//
//  PictureDetailsViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

final class PictureDetailsViewController: UIViewController, PictureDetailsView {
    
    var viewModel: PictureDetailsViewModel
    weak var delegate: PictureDetailsViewDelegate?

    private struct Constants {
        static let heartImageScaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        static let gradientBottomColor = UIColor(
            red: 0.067,
            green: 0.067,
            blue: 0.067,
            alpha: 1
        )
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var imageInfoLabel: UILabel!
    @IBOutlet private weak var heartImageView: UIImageView!
    
    private var likeButton: UIBarButtonItem!
    private var isLiked = false
    private var isImageInfoShown = false
    
    init(viewModel: PictureDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpGestures()
        setUpBindings()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.isLiked() {
            isLiked = true
            likeButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    private func setUpViews() {
        
        imageInfoLabel.textColor = .white
        imageInfoLabel.numberOfLines = 0
        
        heartImageView.tintColor = .white
        heartImageView.alpha = 0
        heartImageView.transform = Constants.heartImageScaleTransform
        
        gradientView.topColor = .clear
        gradientView.bottomColor = Constants.gradientBottomColor
        gradientView.locations = [0.5, 0.9]
        gradientView.alpha = 0
        gradientView.isUserInteractionEnabled = false
        
        likeButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(likeButtonPressed)
        )
        likeButton.tintColor = UIColor(named: "mainColor")
        navigationItem.rightBarButtonItems = [likeButton]
    }
    
    private func setUpGestures() {
        let likeTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleLikeDoubleTap)
        )
        likeTapGesture.numberOfTapsRequired = 2
        
        let showInfoTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(showInfoTap)
        )
        showInfoTapGesture.require(toFail: likeTapGesture)
        
        view.addGestureRecognizer(showInfoTapGesture)
        view.addGestureRecognizer(likeTapGesture)
    }
    
    private func setUpBindings() {
        
        viewModel.picture.bind(fire: true) { [weak self] picture in
            guard let self = self else {
                return
            }
            
            self.imageInfoLabel.attributedText = picture.formattedDescription()
            let imageUrl = URL(string: picture.imageUrl)
            self.imageView.sd_setImage(with: imageUrl)
        }
    }
    
    @objc
    func likeButtonPressed() {
        likeImage(animated: false)
    }
    
    @objc
    func handleLikeDoubleTap() {
        likeImage(animated: true)
    }
    
    @objc
    func likeImage(animated: Bool = true) {
        
        let image = isLiked ? UIImage(systemName: "heart")
                            : UIImage(systemName: "heart.fill")
        
        likeButton.image = image
        heartImageView.image = image
        
        isLiked.toggle()
        
        if isLiked {
            viewModel.addToLiked()
        } else {
            viewModel.removeFromLiked()
        }
        
        guard animated else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.heartImageView.alpha = 1
            self.heartImageView.transform = .identity
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5) {
                self.heartImageView.transform = Constants.heartImageScaleTransform
                self.heartImageView.alpha = 0
            }
        }
    }
    
    @objc
    func showInfoTap() {
        let alpha: CGFloat = self.isImageInfoShown ? 0 : 1
        UIView.animate(withDuration: 0.3) {
            self.gradientView.alpha = alpha
        }
        self.isImageInfoShown.toggle()
    }
}
