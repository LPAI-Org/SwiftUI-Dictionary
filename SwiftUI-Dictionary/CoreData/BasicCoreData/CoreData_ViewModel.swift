import Foundation
import CoreData

//MARK: ViewModel
class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core-Data: \(error)")
            } else {
                print("Successfully loaded Core-Data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        
        newFruit.name = text
        saveData()
    }
    
    func saveData() {
        do {
            try  container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving: \(error)")
        }
        
    }
    
    func delete(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
        
    }
    
}
