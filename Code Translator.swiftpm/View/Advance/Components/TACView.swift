import SwiftUI

struct TACView: View {
    var body: some View {
        HStack{
            VStack{
                Text("(")
                    .fontWeight(.black)
            }
            VStack{
                Text("+,")
                    .fontWeight(.black)
            }
            VStack{
                Text("1,")
                    .fontWeight(.black)
            }
            VStack{
                Text("2,")
                    .fontWeight(.black)
            }
            VStack{
                Text("res")
                    .fontWeight(.black)
            }
            VStack{
                Text(")")
                    .fontWeight(.black)
            }
        }
        .font(.largeTitle)
        
    }
}

struct TACView_Previews: PreviewProvider {
    static var previews: some View {
        TACView()   }
}
