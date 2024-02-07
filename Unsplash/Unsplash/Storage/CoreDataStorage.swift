//
//  CoreDataStorage.swift
//  Unsplash
//
//  Created by Ion Belous on 20.10.2023.
//

import CoreData

final class CoreDataStorage: PersistentStorage {

    typealias Object = Codable & Identifiable
    
    private let viewContext: NSManagedObjectContext
    static var shared = CoreDataStorage()
    
    private init() {
        viewContext = Self.persistentContainer().viewContext
    }

    static private func persistentContainer() -> NSPersistentContainer {
        
        let container = NSPersistentContainer(name: "PictureDatabase")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func save<T>(_ object: T) where T: Object {
        
        guard let picture = object as? PictureModel else {
            return
        }
        
        let pictureCoreDataModel = PictureCoreDataModel(context: viewContext)
        pictureCoreDataModel.id = picture.id
        pictureCoreDataModel.url = URL(string: picture.imageUrl)
        pictureCoreDataModel.author = picture.author
        pictureCoreDataModel.device = picture.device
        pictureCoreDataModel.licence = picture.licence
        pictureCoreDataModel.location = picture.location
        pictureCoreDataModel.published = picture.publicationDate
        
        saveContext()
    }
    
    func retrieve<T>(type: T.Type) -> T? where T: Codable {
        
        let request = PictureCoreDataModel.fetchRequest()
        
        let foundObjects = try? viewContext.fetch(request)
        
        if let foundObjects = foundObjects {
            return foundObjects.map { model in
                return PictureModel(
                    id: model.id ?? "",
                    imageUrl: model.url?.absoluteString ?? "",
                    author: model.author ?? "",
                    location: model.location ?? "",
                    publicationDate: model.published ?? Date(),
                    device: model.device ?? "",
                    licence: model.licence ?? ""
                )
            } as? T
        }
        
        return nil
    }
    
    func retrieve<T>(type: T.Type, id: String) -> T? where T: Codable {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let request = PictureCoreDataModel.fetchRequest()
        request.predicate = predicate
        
        let foundObjects = try? viewContext.fetch(request)
        
        if let foundObjects = foundObjects {
            return foundObjects.map { model in
                return PictureLiteModel(
                    imageID: model.id!,
                    imageURL: model.url?.absoluteString ?? ""
                )
            } as? T
        }
        
        return nil
    }
    
    func delete<T>(_ object: T) where T: Object {
        
        guard let picture = object as? PictureModel else {
            return
        }
        
        let predicate = NSPredicate(format: "id == %@", picture.id)
        let request = PictureCoreDataModel.fetchRequest()
        request.predicate = predicate
        
        let foundObjects = try? viewContext.fetch(request)
        
        if let foundObjects = foundObjects {
            foundObjects.forEach { object in
                viewContext.delete(object)
            }
            saveContext()
        }
    }
}
