//
//  HomeView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift

struct HomeView: View {

    @State var user: User

    var body: some View {
        NavigationView{
            ZStack{
                UserStatisticsCalculator(user: $user)
            }
            .navigationTitle("Home")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    LogoutButton()
                }
                ToolbarItem(placement : .navigationBarTrailing){
                    NavigationLink("Account" , destination : AccountView(user: $user))
                }
            }
        }
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
