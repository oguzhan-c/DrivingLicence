//
//  EducationListView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift
import GoogleAPIClientForREST_YouTube

struct EducationListView: View {
    
    let service = GTLRYouTubeService()
    @State var videos = [GTLRYouTube_PlaylistItem]()
    
    var body: some View {
        NavigationView{
            List(videos , id: \.eTag){ video in
                VStack(alignment: .leading) {
                    Text(video.snippet?.title ?? "")
                    Text(video.snippet?.descriptionProperty ?? "")
                }
            }
            .navigationTitle("Playlist")
        }
        .onAppear{
            fetchVideos()
        }
    }
    func fetchVideos(){
        let query = GTLRYouTubeQuery_PlaylistItemsList.query(withPart: ["PLzCetkPXLuZUZhcyFEG13zBkWXcppMSih"])
        query.maxResults = 29
        query.fields = "nextPageToken,items(etag,snippet/title,snippet/description)"
        
        service.apiKey = "AIzaSyBwI1U-FvVN-gYiqsU8MlfychxsYbkV8uw"
        service.executeQuery(query) { (ticket, response, error) in
            if let error = error {
                print(error.localizedDescription)
                print("error")
                print(videos.count)
                return
            }
            
            if let playlistItems = (response as? GTLRYouTube_PlaylistItemListResponse)?.items {
                videos = playlistItems
                print("deneme")
            }
        }
    }
}

