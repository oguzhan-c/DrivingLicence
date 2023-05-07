//
//  YouTubeAPI.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 5.05.2023.
//

import SwiftUI
import GoogleAPIClientForREST_YouTube

class YouTubeAPI {
    let service = GTLRYouTubeService()

    func searchVideos(searchQuery: String, completion: @escaping (Result<[GTLRYouTube_SearchResult], Error>) -> Void) {
        
        service.apiKey = loadDrivingLicenceAppConfig().apiKey
        
        let query = GTLRYouTubeQuery_SearchList.query(withPart: ["snippet"])
        query.q = searchQuery
        query.type = ["video"]
        query.maxResults = 10

        service.executeQuery(query) { (task, result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let result = result as? GTLRYouTube_SearchListResponse {
                completion(.success(result.items ?? []))
            } else {
                completion(.success([]))
            }
        }
    }
}
