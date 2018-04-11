
import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let model: Model

    // - MARK: - Initializer
    
    init(model: Model) {
        self.model = model
        super.init()
    }
    
    // - MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.label.text = model.array[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model while moving cells
        let movingItem = model.array.remove(at: sourceIndexPath.item)
        model.array.insert(movingItem, at: destinationIndexPath.item)
    }

}
