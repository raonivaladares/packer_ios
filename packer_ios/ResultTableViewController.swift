import UIKit

class ResultTableViewController: UITableViewController {
  var hits: [Hit]?
  var viewTitle: String?
  
  // ---------------------------------------------------------------------------
  // MARK: View life-cycle
  // ---------------------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    if let title = viewTitle {
      self.title = title
    }
  }
  
  // ---------------------------------------------------------------------------
  // MARK: UITableViewController
  // ---------------------------------------------------------------------------
  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (hits?.count)!
  }
  
  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
    if let url = URL(string: (hits?[indexPath.row].photoUrl)!) {
      cell.coverImageView.sd_setImage(with: url)
    }
    if let title = hits?[indexPath.row].title {
      cell.titleLabel.text = title
    }
    if let rating = hits?[indexPath.row].rating {
      cell.ratingView.rating = Double(rating)
      cell.ratingView.isHidden = false
    }
    cell.placeLabel.text = hits?[indexPath.row].local
    cell.accommodationTypeLabel.text = hits?[indexPath.row].accommodationTypeSlug
    cell.mealsCountLabel.text = hits?[indexPath.row].mealsCount.description
    cell.wishListCountLabel.text = hits?[indexPath.row].wishListCount.description
    cell.tripsCountLabel.text = hits?[indexPath.row].tripsCount.description
    
    return cell
  }
  
  override public func numberOfSections(in tableView: UITableView) -> Int {
    var numOfSections = 1
    if hits == nil || (hits?.isEmpty)! {
      let noDataLabel: UILabel     = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableView.bounds.size.width, height: tableView.bounds.size.height)))
      noDataLabel.text             = "No data available"
      noDataLabel.textColor        = UIColor.black
      noDataLabel.textAlignment    = .center
      tableView.backgroundView = noDataLabel
      tableView.separatorStyle = .none
      numOfSections = 0
    }
    return numOfSections
  }
}
