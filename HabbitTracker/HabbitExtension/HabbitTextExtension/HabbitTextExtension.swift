import SwiftUI

extension Text {
    func PT(size: CGFloat,
            color: Color = .white)  -> some View {
        self.font(.custom("FuturaPT-Medium", size: size))
            .foregroundColor(color)
    }
    
    func PTBold(size: CGFloat,
             color: Color = .white)  -> some View {
            self.font(.custom("FuturaPT-Bold", size: size).weight(.heavy))
            .foregroundColor(color)
    }
}
