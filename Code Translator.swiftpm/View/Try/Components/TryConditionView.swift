import SwiftUI

struct TryConditionView: View {
    @ObservedObject var conViewModel = TryConViewModel()
    @State private var mixedSelecedIndex = 0
    let mixedExp = [
        "if a > b or c < d then X = a + b else Y = c - d",
        "while g < h do Y = x * ( 9 + a )",
        "while i = j do if a < b or c < d and e < f then X = X + 3 else Y = Y - 1"
    ]
    let mixedExpInput = [
        [
            "a > b , 4",
            "epsilon, 5",
            "c < d , 4",
            "E or E , 1",
            "epsilon , 5",
            "X = a + b , a",
            "n - ep, 8",
            "epsilon , 5",
            "Y = c - d , a",
            "if-then-else , 7"
        ],
        [
            "epsilon , 5",
            "g < h , 4",
            "epsilon , 5",
            "Y = x * ( 9 + a ) , a",
            "while , 9"
        ],
        [
            "epsilon , 5",
            "i = j , 4",
            "epsilon , 5",
            "a < b , 4",
            "epsilon , 5",
            "c < d , 4",
            "epsilon , 5",
            "e < f , 4",
            "E and E , 2",
            "E or E , 1",
            "epsilon , 5",
            "X = X + 3 , a",
            "n - ep , 8",
            "epsilon , 5",
            "Y = Y - 1 , a",
            "if-then-else , 7",
            "while , 9"
        ]
    ]
    
    var body: some View {
        
        VStack{
            HStack{
                Image(systemName: "hand.point.right")
                    .font(.custom("San Francisco", size: 50))
                Text("Try Control Flow Expressions")
                    .font(.title)
                    .fontWeight(.black)
                Image(systemName: "hand.point.left")
                    .font(.custom("San Francisco", size: 50))
            }
            
            VStack{
                HStack{
                    Text(mixedExp[mixedSelecedIndex])
                        .font(.custom("courier", size: 40))
                        .fontWeight((.black))
                        .padding(30)
                }
                Button("Shuffle!"){
                    mixedSelecedIndex = Int.random(in: 0...2)
                }
                .buttonStyle(.bordered)
            }

            Spacer()
            VStack(alignment: .leading){
                Text("(here, are, -, results)")
                    .font(.custom("courier", size: 20))
                    .fontWeight(.heavy)
                    .padding()
                
                VStack(alignment: .leading){
                    ForEach(conViewModel.quadsToDisplay, id: \.self){ i in
                        Text(i)
                            .font(.custom("courier", size: 20))
                            .fontWeight(.bold)
                    }
                }
            }
            Button("Generate"){
                conViewModel.quadsToDisplay.removeAll()
                conViewModel.input.removeAll()
                conViewModel.input = mixedExpInput[mixedSelecedIndex]
                conViewModel.test()
            }
            .padding()
            .font(.custom("courier", size: 30))    
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607901573181, green: 0.2313726842403412, blue: 0.4784313440322876, alpha: 1.0)), Color(#colorLiteral(red: 0.5960784554481506, green: 0.16470599174499512, blue: 0.7372549176216125, alpha: 1.0))]), startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 30))
        }
    }
}

struct TryConditionView_Previews: PreviewProvider {
    static var previews: some View {
        TryConditionView()
    }
}
