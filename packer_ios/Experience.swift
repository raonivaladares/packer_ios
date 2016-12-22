import Foundation

class Experience {
  var slug: String?
  var totalHits: Int?
  var url: String?
  var photoUrl: String?
  
  init(slug: String, totalHits: Int, url: String, photoUrl: String) {
    self.slug = slug
    self.totalHits = totalHits
    self.url = url
    self.photoUrl = photoUrl
  }
}
