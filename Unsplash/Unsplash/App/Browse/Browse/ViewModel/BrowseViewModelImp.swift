//
//  BrowseViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import Foundation

final class BrowseViewModelImp: BrowseViewModel {
    
    private let searchPictureService: SearchPictureService
    private let presentationService: PresentationService
    private let fetchPicturesDetailsService: FetchPicturesDetailsService
    
    var pictures: Observable<[PictureLiteModel]>
    var presentationMode: Observable<BrowsePresentationMode>
    var requestState: Observable<RequestState>
   
    private var nextPage = 1
    
    var query: String = "flowers" {
        didSet {
            
            if oldValue == query {
                return
            }
            
            nextPage = 1
            pictures.value = []
            
            if !query.isEmpty {
                fetchPictures()
            } else {
                query = "flowers"
                fetchPictures()
            }
        }
    }
    
    init(
        searchPictureService: SearchPictureService,
        presentationService: PresentationService,
        fetchPicturesDetailsService: FetchPicturesDetailsService
    ) {
        self.searchPictureService = searchPictureService
        self.pictures = Observable([])
        self.presentationService = presentationService
        self.presentationMode = .init(presentationService.fetchPresentationMode())
        self.fetchPicturesDetailsService = fetchPicturesDetailsService
        self.requestState = Observable(.noData)
    }
    
    func fetchPictures() {
        
        guard requestState.value != .loading else {
            return
        }
        
        requestState.value = .loading
        
        searchPictureService.searchPictures(
            query: query,
            page: nextPage
        ) { result in
          
            DispatchQueue.main.async {
                
                switch result {
                case .success(let models):
                    self.pictures.value.append(contentsOf: models)
                    self.nextPage += 1
                    self.requestState.value = .finished
                case .failure(let error):
                    print(error)
                    self.requestState.value = self.nextPage > 1 ? .noMoreData : .noData
                }
            }
        }
    }
    
    func fetchPictureDetails(
        pictureID: String,
        completion: @escaping (Result<PictureModel, Error>) -> Void
    ) {
        fetchPicturesDetailsService.fetchPictureDetails(pictureID: pictureID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pictureModel):
                    completion(.success(pictureModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updatePresentation(to mode: BrowsePresentationMode) {
        presentationService.updatePresentation(to: mode)
    }
}
