////
////  PraznikView.swift
////  Pravoslavlje
////
////  Created by VELJKO on 30.7.22..
////
//
//import SwiftUI
//import CoreData
//
//struct PraznikView_Previews: PreviewProvider {
//    static var previews: some View {
//        PraznikView(selectedDay: 1, selectedMonth: "", selectedMonthLetter: "", selectedPraznik: 1)
//    }
//}
//
//struct PraznikView: View {
//
//    @Environment(\.managedObjectContext) var context
//    @FetchRequest(sortDescriptors: []) var praznici: FetchedResults<PraznikEntity>
//
//    @State var selectedDay : Int
//    @State var selectedMonth : String
//    @State var selectedMonthLetter : String
//    @State var selectedPraznik : Int
//    var praznikInDay: Int { getCount() }
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("\(selectedDay). \(selectedMonth)")
//                    .font(Font.custom("CormorantSC-Medium", size: 20))
//                ForEach(praznici) { praznik in
//                    if praznik.monthday == "\(selectedMonthLetter)\(selectedDay)" && praznik.prazniknumber == selectedPraznik {
//                        if let image = praznik.picture {
//                            VStack(spacing: 20) {
//                                Text(praznik.name!)
//                                    .multilineTextAlignment(.center)
//                                    .font(Font.custom("CormorantSC-Medium", size: 30))
//                                Image(image)
//                                    .scaledToFit()
//                                pageControl(currentPage: selectedPraznik - 1, numberOfPages: praznikInDay)
//                                    .padding()
//                            }
//                            .gesture(
//                                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
//                                    .onEnded { value in
//                                        let direction = self.detectDirection(value: value)
//                                        if direction == .left && selectedPraznik != praznikInDay {
//                                            withAnimation(.spring()) {
//                                                selectedPraznik += 1
//                                            }
//                                        }
//                                        if direction == .right && selectedPraznik != 1 {
//                                            withAnimation(.spring()) {
//                                                selectedPraznik -= 1
//                                            }
//                                        }
//                                    }
//                            )
//                        }
//                        if let aboutText = praznik.about {
//                            Text(aboutText)
//                                .multilineTextAlignment(.center)
//                                .font(Font.custom("CormorantSC-Medium", size: 25))
//                                .padding()
//                        }
//                    }
//                }
//            }
//        }
//
//    }//
//
//
//}//
//
//// MARK: - Get Count of Praznik items for Selected Day
//extension PraznikView {
//
//    func getCount() -> Int {
//        var praznikInDay: Int = 0
//
//        let praznikFetchRequest: NSFetchRequest<PraznikEntity> = PraznikEntity.fetchRequest()
//
//        praznikFetchRequest.predicate = NSPredicate(format: "monthday contains[c]%@","\(selectedMonthLetter)\(selectedDay)")
//
//        do {
//            praznikInDay = try context.count(for: praznikFetchRequest)
//        }
//        catch {
//            print(error)
//        }
//        return praznikInDay
//    }
//}
//
//// MARK: - Page Control
//struct pageControl : UIViewRepresentable {
//
//    typealias UIViewType = UIPageControl
//
//    var currentPage = 0
//    var numberOfPages = 1
//
//    func makeUIView(context: UIViewRepresentableContext<pageControl>) -> UIViewType {
//        let page = UIPageControl()
//        page.currentPageIndicatorTintColor = .systemGreen
//        page.numberOfPages = numberOfPages
//        page.pageIndicatorTintColor = .gray
//        return page
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<pageControl> ) {
//        uiView.currentPage = currentPage
//    }
//
//
//
//}
//
//
//extension PraznikView {
//
//    enum SwipeHVDirection: String {
//        case left, right, none
//    }
//
//    func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
//        if value.startLocation.x < value.location.x - 48 {
//            return .right
//        }
//        if value.startLocation.x > value.location.x + 48 {
//            return .left
//        }
//        return .none
//    }
//}
//
//
//
