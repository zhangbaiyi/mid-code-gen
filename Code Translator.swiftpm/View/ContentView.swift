import SwiftUI

struct ContentView: View {
//    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeView()) {
                    NaviRow(title: "Basic", description: "👋, world!", SFSymbol: "number")
                }
                NavigationLink(destination: AdvanceView()) {
                    NaviRow(title: "Advance", description: "From 3AC to AST", SFSymbol: "arrow.up.forward.circle")
                }
                NavigationLink(destination: QuizView()) {
                    NaviRow(title: "Quiz", description: "TIL...", SFSymbol: "note.text")
                }
                NavigationLink(destination: TryView()) {
                    NaviRow(title: "Try It Out", description: "if (😎) then {🔧}", SFSymbol: "hand.point.right")
                }
            }
            .navigationTitle("Code Translator")
            VStack(alignment: .leading){
                Text("👋Welcome!")
                    .font(.custom("San Francisco", fixedSize: 75))
                    .fontWeight(.black)
                Text("Select a section to experience")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
        }
    }
    
}
