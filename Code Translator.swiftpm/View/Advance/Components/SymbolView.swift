import SwiftUI

struct SymbolView: View {
    @State var tap = false
    var symbolText = "if a > b then [mark] x = 1 [mark] else [mark] y = 1"
    var body: some View {
        VStack {
            Text(tap ? symbolText : "if a > b then x = 1 else y = 1")
                .foregroundColor(.primary)
                .fontWeight(.black)
        }
        .padding()
        .frame(width: 200, height: 200)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .strokeBorder()
        )
        .shadow(color: .secondary, radius: tap ? 20 : 10, x: 0, y: tap ? 10 : 20
        )
        .scaleEffect(tap ? 1.1 : 1)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: tap)
        .onTapGesture {
            tap = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                tap = false
            }
        }
    }
}

struct SymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolView()
    }
}
