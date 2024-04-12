import SwiftUI

struct TryView: View {
    
    var body: some View{
        TabView{
            TryAssignView()
                .tabItem { 
                    Image(systemName: "equal.square.fill")
                    Text("Assignment")
                }
            TryBoolView()
                .tabItem { 
                    Image(systemName: "checkmark.square.fill")
                    Text("Boolean")
                }
            TryConditionView()
                .tabItem { 
                    Image(systemName: "flowchart.fill")
                    Text("Control Flow")
                }
        }
    }
    
}

struct TryView_Previews: PreviewProvider {
    static var previews: some View {
        TryView()
    }
}
