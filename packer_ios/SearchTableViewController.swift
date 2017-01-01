import UIKit
import SwiftyJSON
import SDWebImage

class SearchTableViewController: UITableViewController {
  
  var experiences = [Experience]() //Injectable
  var hits: [Hit]?
  var searchText: String?
  
  // ---------------------------------------------------------------------------
  // MARK: View life-cycle
  // ---------------------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.backgroundColor = UIColor.blue
    self.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
    self.navigationController?.navigationBar.tintColor = UIColor.white
    
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
  // MARK: Segue
  // ---------------------------------------------------------------------------
  override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showResultsSegue" {
      if let viewController = segue.destination as? ResultTableViewController {
        viewController.viewTitle = searchText!
        viewController.hits = hits
      }
    }
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Action handlers
  // ---------------------------------------------------------------------------
  @IBAction func searchAction(_ sender: UITextField) {
    Alert.showProgress()
    searchText = sender.text!
    PackerClient.instance.search(text: searchText!) { result in
      Alert.hideProgress()
      switch(result) {
      case .success(let response): self.handleSuccess(response: response as! [Hit])
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
    if (indexPath.row == 0) {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
      return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell", for: indexPath) as! ExperienceTableViewCell
    if let experienceInfo = Experience.experienceInfo(slug: experiences[indexPath.row].slug) {
      cell.titleLabel.text = experienceInfo.title
      cell.subTitleLabel.text = experienceInfo.subTitle
    }
    if let url = URL(string: experiences[indexPath.row].photoUrl) {
      cell.backgroundImageView.sd_setImage(with: url)
    }
    
    return cell
  }
  
  override public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row > 0 {
      Alert.showProgress()
      PackerClient.instance.searchExperience(url: experiences[indexPath.row].url) { result in
        Alert.hideProgress()
        switch(result) {
        case .success(let response): print("ok")
        case .error(let title, let message): self.handleError(title: title, message: message)
        }
      }
    }
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Response handlers
  // ---------------------------------------------------------------------------
  private func handleSuccessGetExperiences(response: [Experience]) {
    print(response)
    experiences = response
    self.tableView.reloadData()
  }
  
  private func handleSuccess(response: [Hit]) {
    print(response)
    hits = response
    performSegue(withIdentifier: "showResultsSegue", sender: self)
  }
  
  private func handleError(title: String, message: String) {
    print(message)
  }
}
