import SwiftUI

struct TryAssignView: View {
    
    @ObservedObject var assignExpViewModel = TryAssignExpViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack{
            HStack{
                Image(systemName: "hand.point.right")
                    .font(.custom("San Francisco", size: 50))
                Text("Try Assignment Expressions")
                    .font(.title)
                    .fontWeight(.black)
                Image(systemName: "hand.point.left")
                    .font(.custom("San Francisco", size: 50))
            }
            
            Spacer()
            HStack{
                Text("expression")
                    .font(.custom("courier", size: 20))
                    .fontWeight(.heavy)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.accentColor, lineWidth: 4))
                Text("=")
                    .font(.custom("courier", size: 20))
                    .fontWeight(.bold)
                Text("value")
                    .font(.custom("courier", size: 20))
                    .fontWeight(.heavy)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.accentColor, lineWidth: 4))
                Spacer()
            }
            .padding()
            Form{
                HStack{
                    Text("❓ = E\ne.g. 'x'")
                        .fontWeight(.black)
                    TextField(
                        "Left",
                        text: $assignExpViewModel.letterToAssign,
                        prompt: Text("One letter only")
                    )
                        .padding()
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                HStack{
                    Text("x = ❓\ne.g. 'a + b'")
                        .fontWeight(.black)
                    TextField(
                        "Right",
                        text: $assignExpViewModel.expressionToAssign,
                        prompt: Text("Only letters, one-digit-number and '+', '-', '*' are allowed")
                    )
                        .padding()
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
            }
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("(here, are, -, results)")
                        .font(.custom("courier", size: 20))
                        .fontWeight(.heavy)
                        .padding()
                    
                    VStack(alignment: .leading){
                        ForEach(assignExpViewModel.quadsToDisplay, id: \.self){ i in
                            Text(i)
                                .font(.custom("courier", size: 20))
                                .fontWeight(.bold)
                        }
                    }
                }
                Spacer()
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Dunno what to test?")
                            .font(.title3)
                            .fontWeight(.bold)
                        VStack(alignment: .leading){
                            HStack(){
                                Text("exp.")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary, lineWidth: 4))
                                    .frame(width: 100)
                                Group{
                                    Button("x"){
                                        assignExpViewModel.letterToAssign = "x"
                                    }
                                    Button("y"){
                                        assignExpViewModel.letterToAssign = "y"
                                    }
                                    Button("A"){
                                        assignExpViewModel.letterToAssign = "A"
                                    }
                                    Button("B"){
                                        assignExpViewModel.letterToAssign = "B"
                                    }
                                    Button("Z"){
                                        assignExpViewModel.letterToAssign = "Z"
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                            Divider()
                            HStack(){
                                Text("value")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary, lineWidth: 4))
                                    .frame(width: 100)
                                VStack(alignment: .leading){
                                    Group{
                                        Button("- a * ( b + ( - c + d ) * e + f - g )"){
                                            assignExpViewModel.expressionToAssign = "- a * ( b + ( - c + d ) * e + f - g )"
                                        }
                                        Button("x + 1"){
                                            assignExpViewModel.expressionToAssign = "x + 1"
                                        }
                                        Button("x + y + 1 - ( a * c )"){
                                            assignExpViewModel.expressionToAssign = "x + y + 1 - ( a * c )"
                                        }
                                    }
                                    .buttonStyle(.bordered)
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            Button("Generate"){
                guard validate() else {
                    showingAlert = true
                    return
                }
                assignExpViewModel.quadsToDisplay.removeAll()
                assignExpViewModel.assignExpresion = assignExpViewModel.letterToAssign + " = " + assignExpViewModel.expressionToAssign
                assignExpViewModel.test()
            }
            .alert("Please check your input", isPresented: $showingAlert) { 
                Button("OK", role: .cancel){
                    showingAlert = false
                }
            }
            .padding()
            .font(.custom("courier", size: 30))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607901573181, green: 0.2313726842403412, blue: 0.4784313440322876, alpha: 1.0)), Color(#colorLiteral(red: 0.5960784554481506, green: 0.16470599174499512, blue: 0.7372549176216125, alpha: 1.0))]), startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 30))
        }
        .padding()
    }
    
    func validate() -> Bool {
        if(!assignExpViewModel.checkLeftValidate()){
            assignExpViewModel.letterToAssign = ""
        }
        if(!assignExpViewModel.checkRightValidate()){
            assignExpViewModel.expressionToAssign = ""
        }
        return assignExpViewModel.checkRightValidate() && assignExpViewModel.checkLeftValidate()
    }
}



struct TryAssignView_Previews: PreviewProvider {
    static var previews: some View {
        TryAssignView()
    }
}
