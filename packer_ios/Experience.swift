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
  
  static func experienceInfo(slug: String) -> (title: String, subTitle: String)? {
    var experienceInfo: (title: String, subTitle: String)?
    
    switch slug {
    case "hostel": experienceInfo = (title: "Hostel Life", subTitle: "Be the host to people from everywhere.")
    case "arts": experienceInfo = (title: "Hands On", subTitle: "Craft and build your perct trip")
    case "short_trip": experienceInfo = (title: "Short Trip", subTitle: "Help for one week. Make friends for life.")
    case "unexplored": experienceInfo = (title: "Nature Lovers", subTitle: "Breathe the freash air of collaboration.")
    case "beach_side": experienceInfo = (title: "Beach Side", subTitle: "Be cool, travel and smile.")
    case "big_city": experienceInfo = (title: "Big City", subTitle: "Enjoy the trip of your life.")
    case "language_teaching": experienceInfo = (title: "Language Teaching", subTitle: "Share knowloge and travel.")
    case "adventure": experienceInfo = (title: "Adventure", subTitle: "Be free, be happy, be adventurer.")
    case "party": experienceInfo = (title: "Party", subTitle: "Enjoy, live, party.")
    case "social_media": experienceInfo = (title: "Social Media", subTitle: "Spread the word. Travel is coming")
    default: experienceInfo = nil
    }
    return experienceInfo
  }
}
