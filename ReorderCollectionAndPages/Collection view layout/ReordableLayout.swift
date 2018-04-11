
import UIKit

class ReordableLayout: UICollectionViewFlowLayout {
    
    let idealCellWidth: CGFloat = 150
    lazy var gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
    var cellCenterToTouchPointVector = CGVector.zero

    override init() {
        super.init()
        
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //itemSize = CGSize(width: 150, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        // Calling `super.prepare()` prevents selected cell to disappear
        super.prepare()

        guard let collectionView = collectionView else { return }
        let availableWidth = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right - sectionInset.left - sectionInset.right
        let idealNumberOfCells = (availableWidth + minimumInteritemSpacing) / (idealCellWidth + minimumInteritemSpacing)
        let numberOfCells = idealNumberOfCells.rounded(.down)
        let cellWidth = (availableWidth + minimumInteritemSpacing) / numberOfCells - minimumInteritemSpacing
        itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        if let gestureRecognizers = collectionView.gestureRecognizers, !gestureRecognizers.contains(gesture) {
            collectionView.addGestureRecognizer(gesture)
        }
    }
    
    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
        // Set the layout attributes when moving a cell (we want to scale it to 1.1)
        let attributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath, withTargetPosition: position)
        attributes.transform = CGAffineTransform(scaleX: Constants.cellTransformUnit, y: Constants.cellTransformUnit)
        return attributes
    }
    
    // - MARK: Gesture management
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        switch gesture.state {
        case .began:    handleBeganState(withLocation: location)
        case .changed:  handleChangedState(withLocation: location)
        case .ended:    handleEndedState(withLocation: location)
        default:        handleCancelledState(withLocation: location)
        }
    }
    
    func handleBeganState(withLocation location: CGPoint) {
        guard let collectionView = collectionView else { fatalError() }
        
        // Manage interactive movement for collection view
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        guard collectionView.beginInteractiveMovementForItem(at: indexPath) else { return }
        
        // Manage picked up cell's animations
        guard let cell = collectionView.cellForItem(at: indexPath) as? (UICollectionViewCell & AnimateProtocol) else { return }
        cell.animatePickUp()
        
        // set vector between center of selected cell and point of touch location
        let location = gesture.location(in: collectionView)
        cellCenterToTouchPointVector = CGVector(dx: location.x - cell.center.x, dy: location.y - cell.center.y)
    }
    
    func handleChangedState(withLocation location: CGPoint) {
        guard let collectionView = collectionView else { fatalError() }
        
        // Manage interactive movement for collection view
        let location = gesture.location(in: collectionView)
        let updatedLocation = CGPoint(x: location.x - cellCenterToTouchPointVector.dx, y: location.y - cellCenterToTouchPointVector.dy)
        collectionView.updateInteractiveMovementTargetPosition(updatedLocation)
    }
    
    func handleEndedState(withLocation location: CGPoint) {
        guard let collectionView = collectionView else { fatalError() }
        
        // Manage interactive movement for collection view
        collectionView.endInteractiveMovement()
        
        // Manage picked up cell's animations
        guard let indexPath = collectionView.indexPathForItem(at: location), let cell = collectionView.cellForItem(at: indexPath) as? (UICollectionViewCell & AnimateProtocol) else { return }
        cell.animatePutDown()
    }
    
    func handleCancelledState(withLocation location: CGPoint) {
        guard let collectionView = collectionView else { fatalError() }
        
        // Manage interactive movement for collection view
        collectionView.cancelInteractiveMovement()
        
        // Manage picked up cell's animations
        guard let indexPath = collectionView.indexPathForItem(at: location), let cell = collectionView.cellForItem(at: indexPath) as? (UICollectionViewCell & AnimateProtocol) else { return }
        cell.animatePutDown()
    }
    
}
