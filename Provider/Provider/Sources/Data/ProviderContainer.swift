//
//  ProviderContext.swift
//  Provider
//
//  Created by Tiago Linhares on 28/02/24.
//

import CoreData
import UIKit

final class ProviderContainer {
    
    // MARK: Container
    
    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelDir = Bundle(
            for: type(of: self)).url(
                forResource: Constants.Entity.model,
                withExtension: Constants.Entity.modelExtension
            )
        else {
            fatalError()
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelDir) else { fatalError() }
        let container = NSPersistentContainer(name: Constants.Entity.model, managedObjectModel: mom)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: Context
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
