
import UIKit

class CollectionViewCell: UICollectionViewCell, AnimateProtocol {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .green
        contentView.layer.borderColor = UIColor.orange.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            // This is called when user selects/deselects cell
            // This is also automatically called every time the cell is reused
            contentView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
    
}
