import SwiftUI

struct ASTView: View {
    var body: some View {
        HStack{
            TabView{
                VStack(alignment:.leading){
                    Image(systemName: "tornado")
                        .font(.system(size: 50, weight: .black, design: .default))
                    
                    VStack(alignment: .leading){
                        Text("ABSTRACTSYNTAXTREE".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("So...how is expression handled?")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("After lexical analysis and syntax analysis, we can have a data structure called 'Abstract Syntax Tree'. It can be a self-defined data structure. Basically it let us know which kind of expression to translate first and marks the key locations.\nWe go from bottom to up, translate regular expressions first, then backpatch according to the marks inserted into the code.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    
                }
                .padding()
                VStack{
                    Image("if-then-else statement")
                        .resizable()
                        .aspectRatio(3006/1344, contentMode: .fit)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .frame(minWidth: 500, idealWidth: 600, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity, alignment: .center)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        )
        .padding()
        Spacer()
    }
}

struct ASTView_Previews: PreviewProvider {
    static var previews: some View {
        ASTView()
    }
}
