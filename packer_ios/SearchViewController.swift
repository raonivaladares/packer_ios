import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {

  @IBOutlet private weak var searchTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction private func searchAction(_ sender: UIButton) {
    let text = searchTextField.text!
    PackerClient.instance.search(text: text) { result in
    switch(result) {
    case .success(let response): self.handleSuccess(response: response)
    case .error(let title, let message): self.handleError(title: title, message: message)
    }
  }
  }

  // ---------------------------------------------------------------------------
  // MARK: Response handlers
  // ---------------------------------------------------------------------------
  private func handleSuccess(response: JSON) {
   print(response)
  }
  
  private func handleError(title: String, message: String) {
    print(message)
  }
}

