//
//  CoreDataContainer.swift
//  fefuactivity
//
//  Created by Котик on 15.06.2022.
//

import CoreData


class FEFUCoreDataContainer {

    static let instance = FEFUCoreDataContainer()
    
    private init() { }
    
    private static let persistentContainerName = "fefuactivity"
    
    // MARK: - Privates
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Self.persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Public properties
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Public functions
    
    func saveContext() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
