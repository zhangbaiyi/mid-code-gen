import SwiftUI

struct MazeView: View {
    
    let data = Array(1...9).map{"Grid \($0)"}
    
    let layout = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    @State private var texts: [String] = []
    
    @State private var reached = false
    
    @State private var instructionNum = 0
    
    var endPoint = 9
    @State private var nowPoint = 1
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                ForEach(texts, id: \.self){text in
                    Text(text)
                        .padding()
                        .foregroundColor(Color.purple)
                        .font(.custom("courier", size: 15))
                }
            }
            GeometryReader{ geometry in
                LazyVGrid(columns:layout, spacing: 20){
                    ForEach(1..<10) { i in 
                        if(i == nowPoint){
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.purple)
                                    .frame(width: 25, height: 25)
                                    .onTapGesture {
                                        if(nowPoint < 3){
                                            addInstruction(curPoint: nowPoint)
                                            nowPoint = nowPoint + 1
                                        }
                                        else if(nowPoint == endPoint){
                                            if (!reached)
                                            {
                                                reachedGoal()
                                                reached = true
                                            }else{
                                                return
                                            }
                                            return
                                        }else{
                                            addInstruction(curPoint: nowPoint)
                                            nowPoint = nowPoint + 3
                                        }
                                    }
                            }
                        }else if(i == endPoint){
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.blue)
                                    .frame(width: 25, height: 25)
                            }
                        }else{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.primary)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
            .frame(width: 190, height: 190, alignment: .center)
        }
        .frame(width: 270, height: 350, alignment: .center)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.purple, lineWidth: 4)
        )
        .scaledToFit()
        .shadow(radius: 3.0)
    }
    
    func addInstruction(curPoint: Int) -> Void{
        self.instructionNum = self.instructionNum + 1
        if(curPoint<3){
            self.texts.append("\(instructionNum):👉")
        }else{
            self.texts.append("\(instructionNum):👇")
        }
    }
    
    func reachedGoal() -> Void{
        self.texts.append("🎯")
    }

}


struct MazeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeView()
    }
}
