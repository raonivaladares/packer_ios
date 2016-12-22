import Foundation
import Alamofire
import SwiftyJSON

class PackerClient {
  enum Result {
    case error(title: String, message: String)
    case success(response: JSON)
  }
  
  var headers: [String: String] = [:]
  var baseURL = "https://staging-worldpackersplatform.herokuapp.com"
  static let instance = PackerClient()
  
  // ---------------------------------------------------------------------------
  // MARK: Inits
  // ---------------------------------------------------------------------------
  private init() {
    self.headers["Accept"] = "application/vnd.worldpackers.com.v6+json"
    self.headers["Authorization"] = "bearer 9e5a86cfca45eba00668e1baf15fd8dd65c15ad760e00845b81995d242844cdd"
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Public methods
  // ---------------------------------------------------------------------------
  func search(text: String, completionHandler: @escaping (Result) -> Void) {
    
    return request(url: self.baseURL + "/api/search?q=" + text,
                   method: .post,
                   completionHandler: completionHandler)
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Private methods
  // ---------------------------------------------------------------------------
  private func request(url: String, method: Alamofire.HTTPMethod,
                       params: [String : AnyObject]? = nil,
                       headers: [String: String]? = nil,
                       completionHandler: @escaping (Result) -> Void) {
    let headers = headers ?? self.headers
    Alamofire.request(url, method: method, parameters: params, headers: headers)
      .responseJSON { response in
        self.responseHandler(response: response, completionHandler: completionHandler)
    }
  }
  
  private func responseHandler(response: DataResponse<Any>, completionHandler: @escaping (Result) -> Void) {
    guard (response.result.isSuccess) else {
      return completionHandler(.error(title: "Atenção", message: "Nossos servidores não estão respondendo, isso pode ser causado por uma fraca conexão ou um erro em nossos próprios servidores."))
    }
    
    let responseResult = JSON(data: response.data!)
    
    if ((response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300) {
      
      return completionHandler(.success(response: responseResult))
    }
    
    if (response.response?.statusCode == 422) {
      let message = "Parece que os servidores estão um pouco instáveis, tente novamente em instantes."
      
      return completionHandler(.error(title: "Atenção", message: message))
    }
  }
}
