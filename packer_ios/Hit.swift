import Foundation

class Hit {
  var id: Int
  var rating: Int
  var mealsCount: Int
  var url: String
  var accommodationTypeSlug: String
  var wishListCount: Int
  var title: String
  var price: Int
  var photoUrl: String
  var reviewsCount: Int
  var city: String
  var hostingSince: String
  var teaserBadge: String
  var country: String
  var tripsCount: Int
  
  init(id: Int,
       rating: Int?,
       mealsCount: Int,
       url: String,
       accommodationTypeSlug: String,
       wishListCount: Int,
       title: String?,
       price: Int,
       photoUrl: String,
       reviewsCount: Int,
       city: String,
       hostingSince: String,
       teaserBadge: String,
       country: String,
       tripsCount: Int ) {
    
    self.id = id
    self.rating = rating ?? 0
    self.mealsCount = mealsCount
    self.url = url
    self.accommodationTypeSlug = accommodationTypeSlug
    self.wishListCount = wishListCount
    self.title = title ?? ""
    self.price = price
    self.photoUrl = photoUrl
    self.reviewsCount = reviewsCount
    self.city = city
    self.hostingSince = hostingSince
    self.teaserBadge = teaserBadge
    self.country = country
    self.tripsCount = tripsCount
  }
}
