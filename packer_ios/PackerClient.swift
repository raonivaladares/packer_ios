import Foundation
import Alamofire
import SwiftyJSON

class PackerClient {
  enum Result {
    case error(title: String, message: String)
    case success(response: Any)
  }
  
  private var headers: [String: String] = [:]
  private var baseURL = "https://staging-worldpackersplatform.herokuapp.com"
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
                   method: .get,
                   completionHandler: completionHandler)
  }
  
  func getExperiences(completionHandler: @escaping (Result) -> Void) {
    request(url: self.baseURL + "/api/search?q=",
            method: .get) { result in
              switch(result) {
              case .success(let response):
                let response = response as! JSON
                var experiences = [Experience]()
                if let experiencesResponse = response["experiences"].array {
                  for  item in experiencesResponse {
                    if let slug = item["slug"].string, let totalHits = item["total_hits"].int, let url = item["url"].string, let photoUrl = item["photo_url"].string {
                      let experience = Experience(slug: slug, totalHits: totalHits, url: url, photoUrl: photoUrl)
                      experiences.append(experience)
                    }
                  }
                }
                return completionHandler(.success(response: experiences))
              case .error(let title, let message):
                return completionHandler(.error(title: title, message: message))
              }
    }
  }
  
  // ---------------------------------------------------------------------------
  // MARK: Private methods
  // ---------------------------------------------------------------------------
  private func request(url: String, method: Alamofire.HTTPMethod,
                       params: [String : AnyObject]? = nil,
                       completionHandler: @escaping (Result) -> Void) {
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
