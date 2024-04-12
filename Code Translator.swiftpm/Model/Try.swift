import Foundation

struct ENode{
    var trueList: [Int] 
    var falseList: [Int]
}

struct NNode{
    var nextlist: [Int]
}

struct Quaternary{
    var serial: Int
    var op: String
    var arg1: String
    var arg2: String
    var result: String
}

struct SNode{
    var nextlist :[Int]
}

enum StackError: Error {
    case PopEmptyStack
}

class IntermediateCode{
    private var Qs: [Quaternary]
    private var nextQuad: Int
    private var assignExpTempVarIndex: Int
    
    var eNodes: Stack<ENode>
    var mNodes: Stack<Int>
    var nNodes: Stack<NNode>
    var sNodes: Stack<SNode>

    
    init(){
        Qs = []
        eNodes = Stack<ENode>()
        mNodes = Stack<Int>()
        nNodes = Stack<NNode>()
        sNodes = Stack<SNode>()
        nextQuad = 0
        assignExpTempVarIndex = 0
    }
    
    var getNextQuad: Int {
        return self.nextQuad
    }
    
    var getAssignExpTempVarIndex: Int {
        return self.assignExpTempVarIndex
    }
    
    var getQuads: [Quaternary] {
        return self.Qs
    }
    
    func advanceAssignExpTempVarIndex() -> Void {
        assignExpTempVarIndex = assignExpTempVarIndex + 1
    }
    
    func emit(_op: String, _arg1: String, _arg2: String, _result: String) -> Void {
        Qs.append(Quaternary(serial: nextQuad, op: _op, arg1: _arg1, arg2: _arg2, result: _result))
        nextQuad = nextQuad + 1
    }
    
    func cancelOperation() -> Void {
        Qs.removeAll()
        Qs.append(Quaternary(serial: -1, op: "Error", arg1: "-", arg2: "-", result: "-"))
    }
    
    func backpatch(_list: [Int], quad: Int){
        for i in _list{
            if(i >= Qs.count){
                continue
            }
            self.Qs[i].result = String(quad)
        }
    }
}

struct Translate {
    
    static func handleInput(input: [String], codeBlock: IntermediateCode) -> Void{
        for i in input {
            let splittedLine: [String] = i.components(separatedBy: " ")
            print(splittedLine)
            let len = splittedLine.count
            switch(splittedLine.last){
            case "1":
                or_exp_handling(codeBlock: codeBlock)
            case "2":
                and_exp_handling(codeBlock: codeBlock)
            case "3":
                not_exp_handling(codeBlock: codeBlock)
            case "4":
                if(len < 4){
                    codeBlock.cancelOperation()
                    return
                }
                else {
                    print(Array(splittedLine)[0])
                    print(Array(splittedLine)[2])
                    print(Array(splittedLine)[1])
                    relop_exp_handling(codeBlock: codeBlock, id1: Array(splittedLine)[0], id2: Array(splittedLine)[2], op: Array(splittedLine)[1])
                }
            case "5":
                epsilon_m_exp_handling(codeBlock: codeBlock)
            case "6":
                id_exp_handling(codeBlock: codeBlock, id: Array(splittedLine)[0])
            case "7":
                if_then_else_exp_handling(codeBlock: codeBlock)
            case "8":
                epsilon_n_exp_handling(codeBlock: codeBlock)
            case "9":
                while_exp_handling(codeBlock: codeBlock)
            case "a":
                s_exp_handling(codeBlock: codeBlock, splittedString: splittedLine)
            default:
                codeBlock.cancelOperation()
                return
            }
        }
    }
    
    static func assignStrFormat(originalString: String) -> String{
        let splittedString = originalString.split(separator: " ")
        var result = ""
        for index in splittedString.indices{
            result+=splittedString[index]
        }
        for index in result.indices{
            if(result[index] == "-"){
                if (index == result.startIndex) {
                    result.insert("0", at: result.startIndex)
                }
                else if (result[result.index(before: index)] == "(" || result[result.index(before: index)] == "="){
                    result.insert("0", at: index)
                }
            }
        }
        return result
    }
    
    static func assignToPostfix(formattedString: String) -> String{
        
        let leftOfEqualSign = formattedString[formattedString.startIndex]
        
        print(leftOfEqualSign)
        
        let firstAfterEqualSign = formattedString.index(formattedString.startIndex, offsetBy: 2)
        
        let s = String(formattedString.suffix(from: firstAfterEqualSign))
        print(s)
        
        var result = ""
        
        var st = Stack<Character>()
        let sizeOfString = s.count
        
        for i in 0..<sizeOfString {
            if (Array(s)[i] != "(" && Array(s)[i] != ")" && Array(s)[i] != "+" && Array(s)[i] != "-" && Array(s)[i] != "*"){
                result += String(Array(s)[i])
            }
            if(Array(s)[i] == "(" ){
                st.push(Array(s)[i])
            }
            if (Array(s)[i] == "+" || Array(s)[i] == "*" || Array(s)[i] == "-"){
                if (st.isEmpty) {
                    st.push(Array(s)[i])
                }else{
                    while(true){
                        let temp = st.top!
                        if (priorityLeftOverRight(leftVal: Array(s)[i], rightVal: temp)){
                            st.push(Array(s)[i])
                            break
                        } else {
                            result += String(temp)
                            if(!st.isEmpty){
                                _ = st.pop()
                            }
                            else {
                                return "ERR_POP_EMPTY_STACK"
                            }
                            if(st.isEmpty){
                                st.push(Array(s)[i])
                                break
                            }
                        }
                    }
                }
            }
            if (Array(s)[i] == ")") {
                while((st.top!) != "("){
                    result += String(st.top!)
                    if(!st.isEmpty){
                        _ = st.pop()
                    }
                    else {
                        return "ERR_POP_EMPTY_STACK"
                    }
                }
                if(!st.isEmpty){
                    _ = st.pop()
                }
                else {
                    return "ERR_POP_EMPTY_STACK"
                }
            }
        }
        while(!st.isEmpty){
            result += String(st.top!)
            if(!st.isEmpty){
                _ = st.pop()
            }
            else {
                return "ERR_POP_EMPTY_STACK"
            }
        }
        result = String(leftOfEqualSign) + result + "=" 
        return result
    }
    
    static func assignCompute(postfixString: String, intermediateCode: IntermediateCode) -> Void{
        
        if(postfixString == "ERR_POP_EMPTY_STACK"){
            intermediateCode.cancelOperation()
            return
        }
        
        var st = Stack<String>()
        let sizeOfString = postfixString.count
        let s = postfixString
        
        for i in 0..<sizeOfString {
            if ( Array(s)[i] != "+" && Array(s)[i] != "*" && Array(s)[i] != "-" && Array(s)[i] != "=" ){
                st.push(String(Array(s)[i]))
            }
            if ( Array(s)[i] == "+" || Array(s)[i] == "-" || Array(s)[i] == "*" ){
                guard let b = st.pop() else {
                    intermediateCode.cancelOperation()
                    return
                }
                guard let a = st.pop() else {
                    intermediateCode.cancelOperation()
                    return
                }
                let temp = "T" + String(intermediateCode.getAssignExpTempVarIndex)
                
                intermediateCode.advanceAssignExpTempVarIndex()
                
                intermediateCode.emit(_op: String(Array(s)[i]), _arg1: a, _arg2: b, _result: temp)
            
                st.push(temp)
            }
            if( Array(s)[i] == "=" ){
                guard let arg1 = st.pop() else {
                    intermediateCode.cancelOperation()
                    return
                }
                guard let res = st.pop() else {
                    intermediateCode.cancelOperation()
                    return
                }
                intermediateCode.emit(_op: String(Array(s)[i]), _arg1: arg1, _arg2: "-", _result: res)
                st.push(res)
            }
        }
    }
    
    static func priorityLeftOverRight(leftVal: Character, rightVal: Character) -> Bool {
        //plus
        if (leftVal == "+" && rightVal == "+"){
            return false
        }
        if (leftVal == "+" && rightVal == "*"){
            return false
        }
        if (leftVal == "+" && rightVal == "("){
            return true
        }
        if (leftVal == "+" && rightVal == "-"){
            return false
        }
        //minus
        if (leftVal == "-" && rightVal == "+"){
            return false
        }
        if (leftVal == "-" && rightVal == "*"){
            return true
        }
        if (leftVal == "-" && rightVal == "("){
            return true
        }
        if (leftVal == "-" && rightVal == "-"){
            return false
        }
        //multiply
        if (leftVal == "*" && rightVal == "+"){
            return true
        }
        if (leftVal == "*" && rightVal == "-"){
            return true
        }
        if (leftVal == "*" && rightVal == "*"){
            return false
        }
        if (leftVal == "*" && rightVal == "("){
            return true
        }
        return true
    }
    
    static func or_exp_handling(codeBlock: IntermediateCode) -> Void {
        if (codeBlock.eNodes.count<2) {
            codeBlock.cancelOperation()
            return
        }
        if (codeBlock.mNodes.isEmpty) {
            codeBlock.cancelOperation()
            return
        }
        guard let E2 = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let E1 = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let _quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        codeBlock.backpatch(_list: E1.falseList, quad: _quad)
        let E = ENode(trueList: mergeList(_list1: E1.trueList, _list2: E2.trueList), falseList: E2.falseList)
        codeBlock.eNodes.push(E)
    }
    
    static func and_exp_handling(codeBlock: IntermediateCode) -> Void {
        if (codeBlock.eNodes.count<2) {
            codeBlock.cancelOperation()
            return
        }
        if (codeBlock.mNodes.isEmpty) {
            codeBlock.cancelOperation()
            return
        }
        guard let E2 = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let E1 = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let _quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        
        codeBlock.backpatch(_list: E1.trueList, quad: _quad)
        let E = ENode(trueList: E2.trueList, falseList: mergeList(_list1: E1.falseList, _list2: E2.falseList))
        codeBlock.eNodes.push(E)
        
    }
    
    static func not_exp_handling(codeBlock: IntermediateCode) -> Void {
        if (codeBlock.eNodes.isEmpty) {
            codeBlock.cancelOperation()
            return
        }
        guard let E1 = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        let newE = ENode(trueList: E1.falseList, falseList: E1.trueList)
        codeBlock.eNodes.push(newE)
    }
    
    static func makeList(next: Int) -> [Int]{
        let result: [Int] = [next]
        return result
    }
    
    //TODO
    static func mergeList(_list1:  [Int], _list2:  [Int]) -> [Int] {
        var result: [Int] = _list1
        for i in _list2 {
            result.append(i)
        }
        return result
    }
    
    static func relop_exp_handling(codeBlock: IntermediateCode, id1: String, id2: String, op: String) -> Void {
        
        let ETrueList = makeList(next: codeBlock.getNextQuad)
        codeBlock.emit(_op: "j"+op, _arg1: id1, _arg2: id2, _result: "-1")
        let EFalseList = makeList(next: codeBlock.getNextQuad)
        codeBlock.emit(_op: "j", _arg1: "-", _arg2: "-", _result: "-1")
        let E = ENode(trueList: ETrueList, falseList: EFalseList)
        codeBlock.eNodes.push(E)
    }
    
    static func epsilon_m_exp_handling(codeBlock: IntermediateCode) -> Void {
        codeBlock.mNodes.push(codeBlock.getNextQuad)
}
    
    static func id_exp_handling(codeBlock: IntermediateCode, id: String) -> Void {
        let ETrueList = makeList(next: codeBlock.getNextQuad)
        codeBlock.emit(_op: "jnz", _arg1: id, _arg2: "-", _result: "-1")
        let EFalseList = makeList(next: codeBlock.getNextQuad)
        codeBlock.emit(_op: "j", _arg1: "-", _arg2: "-", _result: "-1")
        let E = ENode(trueList: ETrueList, falseList: EFalseList)
        codeBlock.eNodes.push(E)
}
    
    static func if_then_else_exp_handling(codeBlock: IntermediateCode) -> Void {
        if ( codeBlock.eNodes.count < 1 || codeBlock.sNodes.count < 2 || codeBlock.mNodes.count < 2 || codeBlock.nNodes.count < 1 ) {
            codeBlock.cancelOperation()
            return
        }
        guard let E = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let N = codeBlock.nNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let m2Quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let m1Quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let S2 = codeBlock.sNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let S1 = codeBlock.sNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        
        codeBlock.backpatch(_list: E.trueList, quad: m1Quad)
        codeBlock.backpatch(_list: E.falseList, quad: m2Quad)
        
        let tmp = mergeList(_list1: S1.nextlist, _list2: N.nextlist)
        codeBlock.sNodes.push(SNode(nextlist: mergeList(_list1: tmp, _list2: S2.nextlist)))
    }
    
    static func epsilon_n_exp_handling(codeBlock: IntermediateCode) -> Void 
    {
        let N = NNode(nextlist: makeList(next: codeBlock.getNextQuad))
        codeBlock.nNodes.push(N)
        codeBlock.emit(_op: "j", _arg1: "-", _arg2: "-", _result: "-1")
}
    
    static func while_exp_handling(codeBlock: IntermediateCode) -> Void 
    {
        if ( codeBlock.eNodes.count < 1 || codeBlock.sNodes.count < 1 || codeBlock.mNodes.count < 2 ) {
            codeBlock.cancelOperation()
            return
        }
        guard let E = codeBlock.eNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let m2Quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let m1Quad = codeBlock.mNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        guard let S1 = codeBlock.sNodes.pop() else {
            codeBlock.cancelOperation()
            return
        }
        
        codeBlock.backpatch(_list: S1.nextlist, quad: m1Quad)
        codeBlock.backpatch(_list: E.trueList, quad: m2Quad)
        
        let S = SNode(nextlist: E.falseList)
        codeBlock.emit(_op: "j", _arg1: "-", _arg2: "-", _result: String(m1Quad))
        codeBlock.sNodes.push(S)
    }
    
    static func s_exp_handling(codeBlock: IntermediateCode, splittedString: [String]) -> Void 
    {
        let splitCount = splittedString.count
        var originalStr = ""
        for i in 0..<(splitCount-2) {
            originalStr += Array(splittedString)[i] 
        }
        
        let formattedStr = Translate.assignStrFormat(originalString: originalStr)
        let postfixStr = Translate.assignToPostfix(formattedString: formattedStr)
        Translate.assignCompute(postfixString: postfixStr, intermediateCode: codeBlock)
        let S = SNode(nextlist: makeList(next: codeBlock.getNextQuad))
        codeBlock.sNodes.push(S)
    }
    
}
