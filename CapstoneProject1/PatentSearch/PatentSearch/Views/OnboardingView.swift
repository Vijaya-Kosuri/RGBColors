import SwiftUI

struct OnboardingView: View {
  var onContinue: () -> Void
  
  @State private var imageScale: CGFloat = 1.0
  @State private var imageOpacity = 0.0
  @State private var imageOffset = CGSize(width: -100, height: 0)

    var body: some View {
        VStack {
            Text("Welcome to the Patent App!")
                .font(.largeTitle)
                .padding()

            Text("Discover and explore patents with our amazing app.")
                .multilineTextAlignment(.center)
                .padding()
          Image("Patent")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .offset(imageOffset)
            .opacity(imageOpacity)
            .onAppear {
              withAnimation(Animation.easeInOut(duration: 1.0)) {
                                      self.imageOffset = CGSize(width: 0, height: 0)
                                      self.imageOpacity = 1.0
              }
            }
            

            Button(action: {
              onContinue()
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView(onContinue: {})
        .preferredColorScheme(.light)
    }
}
