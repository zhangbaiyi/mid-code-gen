import SwiftUI

struct CodeTranslationExample: View {
    
    @State private var flipped = false
    @State private var animated3d = false;
    
    var body: some View {
        VStack {
            ZStack{
                FrontView().opacity(flipped ? 0.0 : 1.0)
                BackView().opacity(flipped ? 1.0 : 0.0)
            }
        }
        .frame(width: 200, height: 200)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607901573181, green: 0.2313726842403412, blue: 0.4784313440322876, alpha: 1.0)), Color(#colorLiteral(red: 0.5960784554481506, green: 0.16470599174499512, blue: 0.7372549176216125, alpha: 1.0))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .purple.opacity(0.4), radius: 8, x: 0, y:  10)
        .modifier(FlipEffect(flipped: $flipped, angle: animated3d ? 180 : 0, axis: (x: 0, y: 1)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.4)){
                self.animated3d.toggle()
            }
        }
    }
}

struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get {angle}
        set {angle = newValue}
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        let tweakedAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
        
    }
}

struct FrontView : View {
    var body: some View{
        Text("var num = 1\nlet two = 2\nlet three = 3\nnum = two + three").padding()
            .foregroundColor(Color.white)
            .font(.custom("courier", size: 20))
    }
}

struct BackView : View {
    var body: some View {
        Text("1 move %rnum, $0x1\n2 move %rtwo, $0x2\n3 move %rthree, $0x3\n4 add %rtemp, %rtwo, %rthree\n5 move %rnum, %rtemp").padding()
            .foregroundColor(Color.white)
            .font(.custom("courier", size: 16))
    }
}

struct CodeTranslationExample_Previews: PreviewProvider {
    static var previews: some View {
        CodeTranslationExample()
    }
}
