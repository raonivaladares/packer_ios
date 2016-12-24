import UIKit
import Cosmos

class ResultTableViewCell: UITableViewCell {
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var ratingQtdLabel: UILabel!
}
