import SwiftUI

struct NaviRow: View {
    let title: String
    let description: String
    let SFSymbol: String
    
    
    var body: some View {
        HStack {
            Image(systemName: SFSymbol)
                .frame(width: 30)
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                Text(description)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(10)
        }
    }
}

struct NaviRow_Previews: PreviewProvider {
    static var previews: some View {
        NaviRow(title: "MyTitle", description: "lorem blablabla", SFSymbol: "heart")
    }
}
