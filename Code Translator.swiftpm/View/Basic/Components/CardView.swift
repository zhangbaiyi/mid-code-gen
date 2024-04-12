import SwiftUI

struct CardView: View {
    
    var category: String
    var headline: String
    var content: String
    
    var body: some View {
        HStack{
            HStack{
                VStack(alignment: .leading){
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(headline)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(content)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
            
            }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        )
        .padding()
        Spacer()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(category: "What is machine code?", headline: "MachineCode10", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus congue, mauris vel tincidunt consequat, augue nibh pretium risus, laoreet eleifend orci quam vitae sapien. Cras hendrerit, ipsum iaculis pellentesque auctor, enim augue tempor augue, quis sollicitudin neque leo vel mauris. Etiam ac mattis massa.")
    }
}
