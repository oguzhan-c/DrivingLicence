////
////  EducationVideoRow.swift
////  DrivingLicence
////
////  Created by Oğuzhan Can on 1.05.2023.
////
//
import SwiftUI
import RealmSwift

struct CarEducationVideoRow: View {
////    @State private var videoNames : [String] =
////    [
////        "KURUM VE KURULUŞLAR - DERS1 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "GENEL TANIMLAR - DERS2 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "ARAÇLAR İLE İLGİLİ GENEL TANIMLAR - DERS3 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "TRAFİK İŞARETLERİ VE TRAFİK POLİSİ HAREKETLERİ - DERS4 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "TEHLİKE UYARI İŞARET LEVHALARI - DERS5 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "TRAFİK TANZİM İŞARET LEVHALARI - DERS6 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "KARAYOLU ÇİZGİLERİ VE OTOYOL KURALLARI - DERS7 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "HIZ KURALLARI VE TAKİP MESAFESİ - DERS8 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "ÖNDEKİ ARACI GEÇME KURALLARI - DERS9 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS10 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS11 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS12 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS13 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS14 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS15 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS16 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS17 - TRAFİK VE ÇEVRE BİLGİSİ" ,
////        "DERS1 - MOTOR VE ARAÇ TEKNİĞİ" ,
////        "DERS2 - MOTOR VE ARAÇ TEKNİĞİ" ,
////        "DERS3 - MOTOR VE ARAÇ TEKNİĞİ" ,
////        "DERS4 - MOTOR VE ARAÇ TEKNİĞİ" ,
////        "DERS5 - MOTOR VE ARAÇ TEKNİĞİ" ,
////        "İLKYARDIM NEDİR?" ,
////        "TEMEL YAŞAM DESTEĞİ" ,
////        "SOLUNUM YOLU TIKANIKLIĞI" ,
////        "SOLUNUM YOLU TIKANIKLIĞI" ,
////        "SOLUNUM YOLU TIKANIKLIĞI" ,
////        "YARALANMALARINDA İLKYARDIM"
////    ]
//    @Binding var tutorialName : String
//    var body: some View {
//        VStack(alignment: .leading){
//            ScrollView{
//                ForEach((videoNames.indices) ){ (index) in
//                    NavigationLink(destination: EducationVideoDetail(tutorialName: videoNames[index])) {
//                        VStack{
//                            Text("Ders :\t\(index + 1 )")
//                                .frame(alignment: .leading)
//                        }
//                    }
//                }
//            }
//        }
//    }
    var tutorialName : String
    var id : Int
    var body: some View {
        NavigationLink(destination : CarEducationVideoDetail(tutorialName: tutorialName)){
            Text("Ders :\t\(id + 1)")
        }
    }
}


