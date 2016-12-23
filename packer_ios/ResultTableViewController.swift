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
    return 0
  }
  
  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
    return cell
  }
  
  override public func numberOfSections(in tableView: UITableView) -> Int {
    var numOfSections = 1
    if hits == nil {
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
