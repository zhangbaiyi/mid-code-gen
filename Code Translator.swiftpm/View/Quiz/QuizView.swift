import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    var body: some View {
        HStack{
            VStack{
                Image(systemName: "lightbulb")
                    .font(.system(size: 50, weight: .black, design: .default))
                    .padding()
                Spacer()
                Button { 
                    viewModel.advanceQuiz()
                    
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                        .padding()
                }
                .padding()
                .background(.clear)
            }
            VStack(alignment: .leading){
                Text("QUIZtime".uppercased())
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(viewModel.progress)
                    .font(.headline)
                Text(viewModel.questionText)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                VStack{
                    Text(viewModel.questionDetail)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding()
                }
            }
            .padding()
            VStack{
                ForEach(viewModel.answerIndices) {index in
                    AnswerButton(text: viewModel.answerText(for: index)){
                        viewModel.makeGuessForCurrentQuestion(at: index)
                        
                    }
                    .background(viewModel.colorForButton(at: index).opacity(0.5), in: RoundedRectangle(cornerRadius: 30), fillStyle: .init())
                    .disabled(viewModel.guessMade)
                    
                }
            }
            .padding()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        )
        .padding()
        Spacer()
    }
}

struct AnswerButton: View {
    let text: String
    let onClick: () -> Void
    var body: some View {
        Button(action: {
            onClick()
        }) {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                
        }
        .frame(width: 300, height: 50, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder()
        )
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
