//
//  ClubInfo.swift
//  bigmarker
//
//  Created by hanqing on 8/26/16.
//  Copyright © 2016 hanqing. All rights reserved.
//

import Foundation
class ClubInfo: NSObject {
    
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
    
    var logo: String? {
        get {
            if let logo = self.dictionary["logo"] as? String {
                return logo
            }
            return nil
        }
    }
    
    
    var backgroundImage: String {
        get {
            if let backgroundImage = self.dictionary["background_image"] as? String {
                return backgroundImage
            }
            return ""
        }
    }
    
    var categories: Array<String>? {
        get {
            if let categories = self.dictionary["categories"] as? Array<String> {
                return categories
            }
            return nil
        }
    }
    
    var reviewsCount: String {
        get {
            if let reviewsCount = self.dictionary["reviews_count"] as? String {
                return "\(reviewsCount) reviews"
            }
            return "0 reviews"
        }
    }
    
    
    var name: String? {
        get {
            if let name = self.dictionary["name"] as? String {
                return name
            }
            return nil
        }
    }
    
    var overview: String? {
        get {
            if let overview = self.dictionary["overview"] as? String {
                return overview
            }
            return nil
        }
    }
    
    var averageRating: String {
        get {
            if let averageRating = self.dictionary["average_rating"] as? String {
                return averageRating
            }
            return "0"
        }
    }
    
    var organizers: Array<ClubProfile> {
        get {
            var organizers: Array<ClubProfile> = []
            if let organizerArray = self.dictionary["organizers"] as? NSArray {
                for organizer in organizerArray {
                    organizers.append(ClubProfile(dictionary: organizer as! NSDictionary))
                }
                return organizers
            }
            return []
        }
    }

    var members: Array<ClubProfile> {
        get {
            var members: Array<ClubProfile> = []
            if let memberArray = self.dictionary["members"] as? NSArray {
                for member in memberArray {
                    members.append(ClubProfile(dictionary: member as! NSDictionary))
                }
                return members
            }
            return []
        }
    }
    
    
    var pastConferences: Array<Conference> {
        get {
             var pastConferencesArray: Array<Conference> = []
            if let pastConferences = self.dictionary["past_conferences"] as? NSArray {
                for conference in pastConferences {
                    pastConferencesArray.append(Conference(dictionary: conference as! NSDictionary))
                }
                return pastConferencesArray
            }
            return []
        }
    }
    
    
    var upcomingConferences:  Array<Conference> {
        get {
             var upcomingConferencesArray: Array<Conference> = []
            if let upcomingConferences = self.dictionary["upcoming_conferences"] as? NSArray{
                for conference in upcomingConferences {
                    upcomingConferencesArray.append(Conference(dictionary: conference as! NSDictionary))
                }
               return upcomingConferencesArray
            }
            return []
        }
    }
    
    
}
