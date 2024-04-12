import Foundation

struct Quiz {
    private let questions = Question.allQuestions.shuffled()
    private(set) var currentQuestionIndex = 0
    private(set) var guesses = [Question: Int]()
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    var questionCount: Int {
        questions.count
    }
    
    mutating func advanceQuiz(){
        let nextQuestionIndex = currentQuestionIndex + 1
        if !questions.indices.contains(nextQuestionIndex){
            currentQuestionIndex = 0
        }
        else {
            currentQuestionIndex = nextQuestionIndex 
        }
    }
    
    mutating func makeGuess(at index: Int) {
        guesses[currentQuestion] = index
    }
}
