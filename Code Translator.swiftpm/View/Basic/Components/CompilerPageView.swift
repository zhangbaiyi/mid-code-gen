import SwiftUI

struct CompilerPageView: View {
    
    var body: some View {
        HStack{
            TabView{
                CompilerOnboardView(componentName: "Lexical Analysis", componentDetail: "This is the first step of the whole process. Our code contains keywords like 'if' and 'for'. Lexical analysis recognizes those words and remembers those symbols in its unique way.",beforeAnimationText: "var a = 1", afterAnimationText: "[keyword: var], [symbol: a], [equalsign], [integer: 1]")
                CompilerOnboardView(componentName: "Syntax Analysis", componentDetail: "Now that we have recognized every word of the code. But just put words together doesn't mean there's a sentence. It makes no sense if you say 'Want I meat eat' instead of saying 'I want to eat meat'. We have to check the syntax.",beforeAnimationText: "[keyword: var], [symbol: a], [equalsign], [integer: 1]", afterAnimationText: "[This is\nan assigning\nexpression]")
                CompilerOnboardView(componentName: "Intermediate Code", componentDetail: "What's next? Computer now knows what type of expression the code is. But it is not yet the actual machine code. We have to decompose the code to formatted '3-address code'.", beforeAnimationText: "[This is\nan assigning\nexpression]", afterAnimationText: "(=, 1, -, a)")
                CompilerOnboardView(componentName: "Optimizing and Generating", componentDetail: "Given the 3-address code, you can easily translate it into machine code you want. Usually we need optimizer to reduce the abundant code to look even cooler.", beforeAnimationText: "(=, 1, -, a)", afterAnimationText: "1 move %ra 0x01")
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .frame(width: 600, height: 400, alignment: .center)
    }
}

struct CompilerOnboardView: View {
    var componentName: String
    var componentDetail: String
    var beforeAnimationText: String
    var afterAnimationText: String
    @State var tap = false
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            HStack{
                VStack(alignment: .leading){
                    Text("COMPILERS")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(componentName)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(componentDetail)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                .padding()
            }
            VStack{
                ZStack{
                    Circle()
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607901573181, green: 0.2313726842403412, blue: 0.4784313440322876, alpha: 1.0)), Color(#colorLiteral(red: 0.5960784554481506, green: 0.16470599174499512, blue: 0.7372549176216125, alpha: 1.0))]), startPoint: .topLeading, endPoint: .bottomTrailing), in:Circle())
                        .foregroundColor(.secondary)
                        .opacity(0.7)
                        .onTapGesture {
                            tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                                tap = false
                            }
                        } 
                    Text(tap ? afterAnimationText : beforeAnimationText)
                        .font(.custom("courier", size: 20))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                }
                .padding()
                .animation(.easeInOut, value: tap)
                
            }
        }
        .padding()
        
    }
}

struct CompilerOnboardView_Previews: PreviewProvider {
    static var previews: some View {
        CompilerOnboardView(componentName: "Name", componentDetail: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", beforeAnimationText: "before", afterAnimationText: "after")
    }
}

struct CompilerPageView_Previews: PreviewProvider {
    static var previews: some View {
        CompilerPageView()
    }
}
