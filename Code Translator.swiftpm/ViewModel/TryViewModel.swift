import Foundation

class TryAssignExpViewModel: ObservableObject {
    @Published var assignExpresion = ""
    @Published var letterToAssign = ""
    @Published var expressionToAssign = ""
    @Published var quadsToDisplay: [String] = []
    
    func test(){
        let intermediateCode = IntermediateCode()
        let formattedStr = Translate.assignStrFormat(originalString: assignExpresion)
        let postfixStr = Translate.assignToPostfix(formattedString: formattedStr)
        Translate.assignCompute(postfixString: postfixStr, intermediateCode: intermediateCode)
        
        for quad in intermediateCode.getQuads{
            quadsToDisplay.append("\(quad.serial) (" + "\(quad.op), " + "\(quad.arg1), " + "\(quad.arg2), " + "\(quad.result))")
        }
        
    }
    
    func checkRightValidate() -> Bool{
        
        let s = expressionToAssign
        if(s.count == 0){
            return false
        }
        
        //check illegal symbol
        for i in 0..<s.count
        {
            if( Array(s)[i] >= "a" && Array(s)[i] <= "z" )
            {
                continue
            }
            else if( Array(s)[i] >= "a" && Array(s)[i] <= "Z" )
            {
                continue
            }
            else if ( Array(s)[i] >= "0" && Array(s)[i] <= "9" )
            {
                continue
            }
            else if ( Array(s)[i] == " " || Array(s)[i] == "+" || Array(s)[i] == "-" || Array(s)[i] <= "*" || Array(s)[i] == "(" || Array(s)[i] == ")" )
            {
                continue
            }
            else
            {
                return false
            }
        }
        
        //check "12"
        for i in 1..<s.count{
            if ( Array(s)[i] >= "0" && Array(s)[i] <= "9" )
            {
                if ( Array(s)[i-1] >= "0" && Array(s)[i-1] <= "9" ){
                    return false
                }
            }
        }
        
        //check "()"
        var st = Stack<Character>()
        for i in 0..<s.count
        {
            if(Array(s)[i] == "("){
                st.push(Array(s)[i])
            }else if (Array(s)[i] == ")"){
                if(st.isEmpty){
                    return false
                }
                else if ( st.top == "(") {
                    _ = st.pop()
                }
                else {
                    return false
                }
            }
        }
        if(!st.isEmpty){
            return false
        }
        else {
            return true
        }
        
        
    }
    
    func checkLeftValidate() -> Bool {
        if letterToAssign.count > 1 {
            return false
        }
        else {
            if (letterToAssign.isAlphabet){
                return true
            }
            else{
                return false
            }
        }
    }
    
}

class TryBoolViewModel: ObservableObject{
    @Published var input: [String] = ["a < b , 4", "epsilon , 5", "c < d , 4", "E or E , 1"]
    @Published var quadsToDisplay: [String] = []
    
    func test(){
        let intermediateCode = IntermediateCode()
        Translate.handleInput(input: input, codeBlock: intermediateCode)
        for quad in intermediateCode.getQuads{
            quadsToDisplay.append("\(quad.serial) (" + "\(quad.op), " + "\(quad.arg1), " + "\(quad.arg2), " + "\(quad.result))")
        }
        
        print(quadsToDisplay)
    }
}

class TryConViewModel: ObservableObject{
    @Published var input: [String] = ["a < b , 4", "epsilon , 5", "c < d , 4", "E or E , 1"]
    @Published var quadsToDisplay: [String] = []
    
    func test(){
        let intermediateCode = IntermediateCode()
        Translate.handleInput(input: input, codeBlock: intermediateCode)
        for quad in intermediateCode.getQuads{
            quadsToDisplay.append("\(quad.serial) (" + "\(quad.op), " + "\(quad.arg1), " + "\(quad.arg2), " + "\(quad.result))")
        }
        
        print(quadsToDisplay)
    }
}

extension String {
    var isAlphabet : Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
