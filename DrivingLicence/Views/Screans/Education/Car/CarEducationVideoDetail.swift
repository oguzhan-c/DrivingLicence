//
//  CarEducationVideoDetail.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 7.05.2023.
//

import SwiftUI
import WebKit
import GoogleAPIClientForREST_YouTube
import RealmSwift

struct CarEducationVideoDetail: View {
    @ObservedResults(Tutorial.self) var tutorials
    @State var tutorialName : String
    var body: some View {
        Video(searchQuery: tutorialName)
            .frame(width: 350 , height: 190)
            .cornerRadius(12)
            .padding(.horizontal , 24)
    }

}

struct Video : UIViewRepresentable{
    @ObservedResults(Tutorial.self) var tutorials
    @State  var searchQuery : String
    @State private var searchResults: [GTLRYouTube_SearchResult] = []
    private let youTubeAPI = YouTubeAPI()
    
    func search() {
        youTubeAPI.searchVideos(searchQuery: searchQuery) { result in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.searchResults = results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        search()
        guard let videoId = searchResults.first?.identifier?.videoId
        else {return}
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else{return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
    
    
 
    
}
