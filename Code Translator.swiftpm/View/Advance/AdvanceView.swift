import SwiftUI

struct AdvanceView: View {
    var body: some View {
        ScrollView{
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("INTERMEDIATECODE".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("What is 3-address code?")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("This is a kind of intermediate code. The 3AC consists of 4 components: (op, arg1, arg2, result). arg1 and arg2 are two operands, sometimes there's only one or zero operands. op is operator and result is a temporary variable used in the process.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                TACView()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            //2
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("ABSTRACTION".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Learn by analogy")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("Expressions like 'let a = 1' and 'let b = 2' are the same kind of code. We can use the same strategy to translate them. In 'let a = 1', we see 'a' as a kind of symbol, like 'id'. Numbers like '1' can be seen as 'id' first. The id after the equal sign can be seen as an expression, 'E'. So we can handle codes like 'let a = 1 + 1' by acknowledging 'id + id' can conform to an 'E'.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                AbstractView()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            //3
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("ABSTRACTION".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Other Expressions")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("We use different strategies in other expressions. Boolean and condition expressions are slightly more complicated.  Imagine an 'if-then-else' expression. If the condition is satisfied, you continue to the code block inside 'then', otherwise jump out of the 'else' block. If the 'result' of 3AC is a number, it means the target line to which the machine jumps next. If we currently don't know where is the next line, we can simply set the 'result' to '-1'.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                OtherExpView()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            //4
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("ABSTRACTION".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("How on earth do you know where to jump?")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("We see complex expressions like 'if-then-else' as code blocks. In other words, we have to remember the beginning and the end of each block. So do that, we insert special symbols in the original expression to mark the locations.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                SymbolView()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            ASTView()
            
        }
    }
}

struct AdvanceView_Previews: PreviewProvider {
    static var previews: some View {
        AdvanceView()
    }
}
