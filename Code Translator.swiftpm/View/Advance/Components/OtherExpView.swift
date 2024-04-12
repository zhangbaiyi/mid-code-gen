import SwiftUI

struct OtherExpView: View {
    @State private var texts: [String] = []
    @State var lineCount = 1
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "hand.point.up")
                        .font(.largeTitle)
                    Text("Tap here")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                Text("'if a > b then x = 1 else y = 1'")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            ForEach(texts, id: \.self){text in
                Text(text)
                    .font(.title)
                    .fontWeight(.black)
            }
        }
        .onTapGesture {
            if(lineCount >= 1 && lineCount <= 5){
                addLine(curLines: lineCount)
                lineCount = lineCount + 1
            }
        }
        
    }
    
    func addLine(curLines: Int) -> Void {
        switch lineCount {
        case 1 :
            texts.append("0 (j>, a, b, 2)")
        case 2 :
            texts.append("1 (j, -, -, 4)")
        case 3 :
            texts.append("2 (=, 1, -, x)")
        case 4 :
            texts.append("3 (j, -, -, -1)")
        case 5 :
            texts.append("4 (=, 1, -, y)")
        default:
            texts.append("")
        }
    }
}


struct OtherExpView_Previews: PreviewProvider {
    static var previews: some View {
        OtherExpView()
    }
}
