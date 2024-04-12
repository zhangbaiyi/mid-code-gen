import SwiftUI

struct AbstractView: View {
    @State private var texts: [String] = []
    @State var lineCount = 1
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "hand.point.up")
                    .font(.largeTitle)
                Text("Tap here")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
            ForEach(texts, id: \.self){text in
                Text(text)
                    .font(.title)
                    .fontWeight(.black)
            }
        }
        .onTapGesture {
            if(lineCount >= 1 && lineCount <= 6){
                addLine(curLines: lineCount)
                lineCount = lineCount + 1
            }
        }
        
    }

    func addLine(curLines: Int) -> Void {
        switch lineCount {
        case 1 :
            texts.append("let a = 1")
        case 2 :
            texts.append("let id = id")
        case 3 :
            texts.append("let id = E")
        case 4 :
            texts.append("<ACCEPTED>")
        case 5 :
            texts.append("(=, id.name, -, E.value)")
        case 6 :
            texts.append("(=,a,-,1)")
        default:
            texts.append("")
        }
    }
}


struct AbstractView_Previews: PreviewProvider {
    static var previews: some View {
        AbstractView()
    }
}
