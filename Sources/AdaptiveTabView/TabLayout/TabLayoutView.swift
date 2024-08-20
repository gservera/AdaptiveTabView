//
//  TabLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct TabLayoutView<TabContent: Sequence>: View where TabContent.Element: TabContentView {

    private let selectedTab: Binding<TabIdentifier>
    private let tabViews: TabContent
    @Binding private var navigationPaths: [NavigationPath]

    init(
        selectedTab: Binding<TabIdentifier>,
        navigationPaths: Binding<[NavigationPath]>,
        @SequenceBuilder _ tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    ) {
        self.selectedTab = selectedTab
        self._navigationPaths = navigationPaths
        self.tabViews = tabViewBuilder(.tabView)
    }

    var body: some View {
        TabView(selection: selectedTab) {
            ForEach(sequence: tabViews) { (index, tabView) in
                TabNavigationView(path: $navigationPaths[index]) {
                    tabView
                }
                .tag(tabView.id)
            }
        }
    }
}

#if DEBUG
#Preview("TabLayoutView_Previews") {
    TabLayoutView(selectedTab: .constant("tabIdentifier"), navigationPaths: Binding(projectedValue: .constant([]))) { (_) in
        PreviewTitleImageProvidingView()
    }
}
#endif
