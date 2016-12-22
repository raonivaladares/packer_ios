import UIKit
import SwiftyJSON

class SearchTableViewController: UITableViewController {
  
  var experiences = [Experience]()
  
  // ---------------------------------------------------------------------------
  // MARK: View life-cycle
  // ---------------------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    Alert.showProgress()
    PackerClient.instance.getExperiences() { result in
      Alert.hideProgress()
      switch(result) {
      case .success(let response): self.handleSuccessGetExperiences(response: response as! [Experience])
      case .error(let title, let message): self.handleError(title: title, message: message)
      }
    }
  }
  
  // ---------------------------------------------------------------------------
  // MARK: UITableViewController
  // ---------------------------------------------------------------------------
  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return experiences.count
  }
  
  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell", for: indexPath) as! ExperienceTableViewCell
    cell.titleLabel.text = "a aaaa"
    cell.subTitleLabel.text = "a aaaa"
//    cell.backgroundImageView
    
    return cell
    
    
    
  }
  
  override public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Response handlers
  // ---------------------------------------------------------------------------
  private func handleSuccessGetExperiences(response: [Experience]) {
    print(response)
    experiences = response
    self.tableView.reloadData()
  }
  
  private func handleSuccess(response: JSON) {
    print(response)
  }
  
  private func handleError(title: String, message: String) {
    print(message)
  }
}

