import UIKit

class ResultTableViewController: UITableViewController {
  
  // ---------------------------------------------------------------------------
  // MARK: View life-cycle
  // ---------------------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // ---------------------------------------------------------------------------
  // MARK: UITableViewController
  // ---------------------------------------------------------------------------
  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  //  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  //    return nil
  //  }
  
  override public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
