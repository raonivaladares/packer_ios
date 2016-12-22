import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {
  
  @IBOutlet private weak var searchTextField: UITextField!
  
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
  // MARK: Action handlers
  // ---------------------------------------------------------------------------
  @IBAction private func searchAction(_ sender: UIButton) {
    let text = searchTextField.text!
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Response handlers
  // ---------------------------------------------------------------------------
  private func handleSuccessGetExperiences(response: [Experience]) {
    print(response)
  }
  
  private func handleSuccess(response: JSON) {
    print(response)
  }
  
  private func handleError(title: String, message: String) {
    print(message)
  }
}

