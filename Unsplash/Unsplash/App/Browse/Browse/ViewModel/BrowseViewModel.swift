//
//  BrowseViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

protocol BrowseViewModel {
    var pictures: Observable<[PictureLiteModel]> { get }
    var presentationMode: Observable<BrowsePresentationMode> { get set }
    func fetchPictures()
    func updatePresentation(to mode: BrowsePresentationMode)
    func fetchPictureDetails(
        pictureID: String,
        completion: @escaping (Result<PictureModel, Error>) -> Void
    )
    var query: String { get set }
    var requestState: Observable<RequestState> { get }
}
