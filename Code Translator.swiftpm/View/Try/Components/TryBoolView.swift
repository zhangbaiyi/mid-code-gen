import SwiftUI

struct TryBoolView: View {
    @ObservedObject var boolViewModel = TryBoolViewModel()
    @State private var selectedTypeIndex = 0
    @State private var LeftLeftVal = "a"
    @State private var LeftRightVal = "b"
    @State private var LeftOp = ">"
    @State private var RightLeftVal = "c"
    @State private var RightRightVal = "d"
    @State private var RightOp = "<"
    let alphaNumericSet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"]
    let signSet = [">","<","="]
    @State private var mixedSelecedIndex = 0
    let mixedExp = [
        "a < b or c < d and e < f",
        "not a or c < d and e = f or g > h and i > j",
        "a = 1 and b = 2 and c = 3 and d = 4 and e = 5"
    ]
    let mixedExpInput = [
        [
            "a < b , 4",
            "epsilon, 5",
            "c < d , 4",
            "epsilon , 5",
            "e < f , 4",
            "E and E , 2",
            "E or E , 1",
        ],
        [
            "a , 6",
            "not , 3",
            "epsilon , 5",
            "c < d , 4",
            "epsilon , 5",
            "e = f , 4",
            "AND , 2",
            "OR , 1",
            "epsilon , 5",
            "g > h , 4",
            "epsilon , 5",
            "i > j , 4",
            "AND , 2",
            "OR , 1"
        ],
        [
            "a = 1 , 4",
            "epsilon , 5",
            "b = 2 , 4",
            "AND , 2",
            "epsilon , 5",
            "c = 3 , 4",
            "AND , 2",
            "epsilon , 5",
            "d = 4 , 4",
            "AND , 2",
            "epsilon , 5",
            "e = 5 , 4",
            "AND , 2"
        ]
    ]
    
    var body: some View {
        
        VStack{
            HStack{
                Image(systemName: "hand.point.right")
                    .font(.custom("San Francisco", size: 50))
                Text("Try Boolean Expressions")
                    .font(.title)
                    .fontWeight(.black)
                Image(systemName: "hand.point.left")
                    .font(.custom("San Francisco", size: 50))
            }
            HStack{
                Picker("Type", selection: $selectedTypeIndex, content: {
                    Text("AND").tag(0)
                    Text("OR").tag(1)
                    Text("NOT").tag(2)
                    Text("MIXED").tag(3)
                }).pickerStyle(SegmentedPickerStyle())
            }
            switch(selectedTypeIndex){
                case 0:
                VStack{
                    HStack{
                        HStack{
                            Text(LeftLeftVal)
                                .font(.custom("courier", size: 30))
                            Text(LeftOp)
                                .font(.custom("courier", size: 30))
                            Text(LeftRightVal)
                                .font(.custom("courier", size: 30))
                        }
                        Text("AND")
                            .font(.custom("courier", size: 40))
                            .fontWeight((.black))
                        HStack{
                            Text(RightLeftVal)
                                .font(.custom("courier", size: 30))
                            Text(RightOp)
                                .font(.custom("courier", size: 30))
                            Text(RightRightVal)
                                .font(.custom("courier", size: 30))
                        }
                    }
                    Button("Shuffle!"){
                        LeftLeftVal = alphaNumericSet.randomElement() ?? "a"
                        LeftRightVal = alphaNumericSet.randomElement() ?? "b"
                        LeftOp = signSet.randomElement() ?? ">"
                        RightLeftVal = alphaNumericSet.randomElement() ?? "c"
                        RightRightVal = alphaNumericSet.randomElement() ?? "d"
                        RightOp = signSet.randomElement() ?? "<"
                    }
                    .buttonStyle(.bordered)
                }
                
            case 1:
                VStack{
                    HStack{
                        HStack{
                            Text(LeftLeftVal)
                                .font(.custom("courier", size: 30))
                            Text(LeftOp)
                                .font(.custom("courier", size: 30))
                            Text(LeftRightVal)
                                .font(.custom("courier", size: 30))
                        }
                        Text("OR")
                            .font(.custom("courier", size: 40))
                            .fontWeight((.black))
                        HStack{
                            Text(RightLeftVal)
                                .font(.custom("courier", size: 30))
                            Text(RightOp)
                                .font(.custom("courier", size: 30))
                            Text(RightRightVal)
                                .font(.custom("courier", size: 30))
                        }
                    }
                    Button("Shuffle!"){
                        LeftLeftVal = alphaNumericSet.randomElement() ?? "a"
                        LeftRightVal = alphaNumericSet.randomElement() ?? "b"
                        LeftOp = signSet.randomElement() ?? ">"
                        RightLeftVal = alphaNumericSet.randomElement() ?? "c"
                        RightRightVal = alphaNumericSet.randomElement() ?? "d"
                        RightOp = signSet.randomElement() ?? "<"
                    }
                    .buttonStyle(.bordered)
                }
                
            case 2:
                VStack{
                    HStack{
                        Text("NOT")
                            .font(.custom("courier", size: 40))
                            .fontWeight((.black))
                        HStack{
                            Text(RightLeftVal)
                                .font(.custom("courier", size: 30))
                            Text(RightOp)
                                .font(.custom("courier", size: 30))
                            Text(RightRightVal)
                                .font(.custom("courier", size: 30))
                        }
                    }
                    Button("Shuffle!"){
                        RightLeftVal = alphaNumericSet.randomElement() ?? "c"
                        RightRightVal = alphaNumericSet.randomElement() ?? "d"
                        RightOp = signSet.randomElement() ?? "<"
                    }
                    .buttonStyle(.bordered)
                }
                
            default:
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
                
            }
            
            HStack{
                Text("Please don't be confused.\nIf condition is satisfied, then the 3AC's result is called 'true exit', the line to jump at. We don't know yet where to jump, so 'true exit' and 'false exit' are replaced by -1 here. ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
            }
            
            Spacer()
            VStack(alignment: .leading){
                Text("(here, are, -, results)")
                    .font(.custom("courier", size: 20))
                    .fontWeight(.heavy)
                    .padding()
                
                VStack(alignment: .leading){
                    ForEach(boolViewModel.quadsToDisplay, id: \.self){ i in
                        Text(i)
                            .font(.custom("courier", size: 20))
                            .fontWeight(.bold)
                    }
                }
            }
            Button("Generate"){
                
                switch(selectedTypeIndex) {
                    
                case 0:
                    //AND
                    boolViewModel.quadsToDisplay.removeAll()
                    boolViewModel.input.removeAll()
                    boolViewModel.input.append("\(LeftLeftVal) \(LeftOp) \(LeftRightVal) , 4")
                    boolViewModel.input.append("epsilon , 5")
                    boolViewModel.input.append("\(RightLeftVal) \(RightOp) \(RightRightVal) , 4")
                    boolViewModel.input.append("E and E , 1")
                    boolViewModel.test()
                case 1:
                    //OR
                    boolViewModel.quadsToDisplay.removeAll()
                    boolViewModel.input.removeAll()
                    boolViewModel.input.append("\(LeftLeftVal) \(LeftOp) \(LeftRightVal) , 4")
                    boolViewModel.input.append("epsilon , 5")
                    boolViewModel.input.append("\(RightLeftVal) \(RightOp) \(RightRightVal) , 4")
                    boolViewModel.input.append("E or E , 1")
                    boolViewModel.test()
                case 2:
                    //NOT
                    boolViewModel.quadsToDisplay.removeAll()
                    boolViewModel.input.removeAll()
                    boolViewModel.input.append("\(RightLeftVal) \(RightOp) \(RightRightVal) , 4")
                    boolViewModel.input.append("not E , 3")
                    boolViewModel.test()
                default:
                    //MIXED
                    boolViewModel.quadsToDisplay.removeAll()
                    boolViewModel.input.removeAll()
                    boolViewModel.input = mixedExpInput[mixedSelecedIndex]
                    boolViewModel.test()
                }
            }
            .padding()
            .font(.custom("courier", size: 30))          
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607901573181, green: 0.2313726842403412, blue: 0.4784313440322876, alpha: 1.0)), Color(#colorLiteral(red: 0.5960784554481506, green: 0.16470599174499512, blue: 0.7372549176216125, alpha: 1.0))]), startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 30))
        }
    }
}

struct TryBoolView_Previews: PreviewProvider {
    static var previews: some View {
        TryBoolView()
    }
}
