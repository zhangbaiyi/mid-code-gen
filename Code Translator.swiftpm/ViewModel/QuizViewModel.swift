import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var quiz = Quiz()
    
    var questionText: String {
        quiz.currentQuestion.questionText
    }
    
    var questionDetail: String {
        quiz.currentQuestion.questionDetail
    }
    
    var answerIndices: Range<Int> {
        quiz.currentQuestion.possibleAnswers.indices
    }
    
    var progress: String {
        "Question \(quiz.currentQuestionIndex + 1) / \(quiz.questionCount)"
    }
    
    var correctAnswerIndex: Int {
        quiz.currentQuestion.correctAnswerIndex
    }
    
    var guessMade: Bool {
        quiz.guesses[quiz.currentQuestion] != nil
    }
    
    func answerText(for index: Int) -> String {
        quiz.currentQuestion.possibleAnswers[index]
    }
    
    func advanceQuiz() {
        quiz.advanceQuiz()
    }
    
    func makeGuessForCurrentQuestion(at index: Int){
        quiz.makeGuess(at: index)
    }
    
    func colorForButton(at buttonIndex: Int) -> Color {
//        
        if self.guessMade {
            let guessedIndex = quiz.guesses[quiz.currentQuestion]
            if buttonIndex == quiz.currentQuestion.correctAnswerIndex{
                return .green
            }else if(buttonIndex == guessedIndex){
                return .red
            }
            else{
                return .clear
            }
        }
        else {
            return .clear
        }
//        if guessedIndex == quiz.currentQuestion.correctAnswerIndex{
//            return .green
//        }else {
//            return .red
//        }
    }
}
