//
//  TabNavigationView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI

struct TabNavigationView<Content: TabContentView>: View {

    private let content: Content
    
    var path: Binding<NavigationPath>

    init(path: Binding<NavigationPath>, @ViewBuilder contentBuidler: () -> Content) {
        self.content = contentBuidler()
        self.path = path
    }

    var body: some View {
        NavigationStack(path: path) {
            content
                .navigationTitle(content.title)
        }
        .tabItem {
            content.label
        }
    }
}

//#if DEBUG
//#Preview("TabNavigationView_Previews") {
//    @Previewable @State var path = NavigationPath()
//    
//    TabView {
//        TabNavigationView(path: $path) {
//            PreviewTitleImageProvidingView()
//        }
//    }
//}
//#endif
