import Foundation

struct Question: Hashable{
    let questionText: String
    let possibleAnswers: [String]
    let correctAnswerIndex: Int
    let questionDetail: String
    static let allQuestions:[Question] = [
        Question(questionText: "What is the first step of compiling?", possibleAnswers: [
            "Syntax Analysis",
            "Lexical Analysis",
            "Translating",
            "Optimizing"
        ], correctAnswerIndex: 1, questionDetail: "Let's recap the whole process. First we scan the code to recognize each 'word', then we check if the words can form a sentence which makes sense. Finally we translate it for further operations."),
        Question(questionText: "Wicht is indispensible in 3AC?", possibleAnswers: [
            "arg1",
            "arg2",
            "result",
            "Operator"
        ], correctAnswerIndex: 3, questionDetail: "3AC is a type of intermediate code, which means it can present many sorts of code. What is really crucial in the instruction we give to the computer may be 'What to do' instead of 'How to do'."),
        Question(questionText: "On the right is 3AC for code 'if (a > b) OR (c < d) then x = a + b else y = c - d'\nWhat best replaces the question mark?", possibleAnswers: [
            "1",
            "2",
            "4",
            "8"
        ], correctAnswerIndex: 2, questionDetail: "0 (j>,a,b,❓)\n1 (j,-,-,4)\n2 (j<,c,d,4)\n3 (j,-,-,7)\n4 (+,a,b,T1)\n5 (=,T1,-,X)\n6 (j,-,-,-1)\n7 (-,c,d,T2)\n8 (=,T2,-,Y) ")
    ]
}


