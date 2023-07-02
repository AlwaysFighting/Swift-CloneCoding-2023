import SwiftUI

struct BannerCard: View {
    
    var banner: AssetBanner
    
    var body: some View {
        ZStack {
            Color(banner.backgroundColor)
                .overlay(
                    VStack(content: {
                        Text(banner.title)
                            .font(.title)
                        Text(banner.descrioption)
                            .font(.subheadline)
                    })
                )
        }
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", descrioption: "추가된 공지사항을 확인하세요.", backgroundColor: .red)
        BannerCard(banner: banner0)
        BannerCard(banner: banner0)
    }
}
