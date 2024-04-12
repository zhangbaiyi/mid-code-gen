import SwiftUI

struct HomeView: View {
    var body: some View{
        ScrollView{
            //1
            CardView(category: "CODETRANSLATOR101".uppercased(), headline: "Many a little, makes a mickle", content: "You may be a code master or new to the business. No matter what, there's one thing we may all agree. That is, to do something complicated, we can do simple things in order.\nFor instance, drinking water can be subdivided into 3 parts: picking up the cup🥛, opening the mouth😮, and tilting the cup🫗.")
            
            //2
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("CODETRANSLATOR101")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Sequential Instructions")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("It is the same thing when it comes to making your code do something for you. In fact, a program is a set of sequential instructions.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Tap the purple dot to see an example of instructions.")
                            .font(.custom("courier", size: 20))
                            .font(.title2)
                            .foregroundColor(Color.purple)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                MazeView()
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
            CardView(category: "CODETRANSLATOR101", headline: "Machine Code", content: "Yes, computers have instructions. Lines of code are definitely one type of instruction. But there's one problem. You can't make the computer print 'Hello World' on the screen by writing 'print(\"hello world\")' as if there's another person inside your computer who reads and understands what 'print' means.\nComputers use machine code deep inside. Compilers translate the language you can understand into the language machines can understand.")
            
            //4
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("CODETRANSLATOR101")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("An Example of Translation")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("Tap the card to see the difference")
                            .font(.custom("courier", size: 20))
                            .font(.title2)
                            .foregroundColor(.purple)
                        Text("In the machine code, computers can only do simple things like loading a number to an address, loading the result of adding two numbers to some address, etc.\nIn this example, the dollar sign($) means an integer while the percentage sign(%) means some address.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                CodeTranslationExample()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            //5
            CardView(category: "COMPILERS", headline: "What is a compiler?", content: "How to translate your code to the one computer recognizes? When you hit run/build/start on your IDE, compilers are doing the rest of the job.\nLike its name, compilers see your code as code blocks. Despite there are different mechanisms, compilers basically recognizes the reserved characters in your code and translates it block by block. ")
            
            //6
            HStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("swipe\nto\nexplore".uppercased())
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Image(systemName: "arrow.right.circle")
                            .font(.custom("San Francisco", size: 50))
                        Spacer()
                        Text("Tap the circle on the right to see the output")
                            .font(.custom("courier", size: 15))
                            .foregroundColor(.accentColor)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                CompilerPageView()
                    .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
            )
            .padding()
            Spacer()
            
            CardView(category: "IntermediateCode".uppercased(), headline: "Why there's intermediate code?", content: "Let's talk about difference first. Machines are not the same. If we directly translate code into machine code for each unique machine, the workload is unbearable.\nIntermediate code makes it easier for the compiler to translate into different machine codes since intermediate codes are the same.")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
