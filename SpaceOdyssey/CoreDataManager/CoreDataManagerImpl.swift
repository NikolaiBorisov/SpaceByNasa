//
//  CoreDataManagerImpl.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit
import CoreData

protocol CoreDataManager {
    func getContext() -> NSManagedObjectContext
    func createObject<T: NSManagedObject>(from entity: T.Type) -> T
    func save(context: NSManagedObjectContext)
    func delete(object: NSManagedObject)
    func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T]
}

/// Class helps to save and retrieve data from CoreData
final class CoreDataManagerImpl: CoreDataManager {
    
    // MARK: - Public Properties
    
    static let shared = CoreDataManagerImpl()
    
    // MARK: - Private Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteSpaceOdyssey")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    // MARK: - Public Methods
    
    public func getContext() -> NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T] {
        let context = getContext()
        let request: NSFetchRequest<T>
        var fetchResult = [T]()
        
        request = entity.fetchRequest() as! NSFetchRequest<T>
        do {
            fetchResult = try context.fetch(request)
        } catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return fetchResult
    }
    
    public func createObject<T: NSManagedObject>(from entity: T.Type) -> T {
        let context = getContext()
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! T
        return object
    }
    
    public func delete(object: NSManagedObject) {
        let context = getContext()
        context.delete(object)
        save(context: context)
    }
    
    /// Method clears all CoreData on the device
    public func clearCoreData() {
        let result = fetchData(for: Favorite.self)
        if !result.isEmpty {
            result.forEach({ delete(object: $0) })
        }
        let resultAfterClear = fetchData(for: Favorite.self)
        if resultAfterClear.isEmpty {
            print("Core data is empty")
        }
    }
    
}
