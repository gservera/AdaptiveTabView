//
//  SidebarLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct SidebarLayoutView<TabContent: Sequence, SidebarExtraContent: View, DefaultContentView: View, DefaultDetailView: View>: View where TabContent.Element: TabContentView {

    private let appName: String
    private let selectedTab: Binding<TabIdentifier>?
    @Binding private var navigationPaths: [NavigationPath]
    private let splitViewKind: AdaptiveTabViewSplitViewKind
    private let columnVisibility: Binding<NavigationSplitViewVisibility>
    private let tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    private let defaultContentView: DefaultContentView
    private let defaultDetailView: DefaultDetailView
    private let sidebarExtraContent: () -> SidebarExtraContent

    init(
        _ appName: String,
        selectedTab: Binding<TabIdentifier>?,
        navigationPaths: Binding<[NavigationPath]>,
        splitViewKind: AdaptiveTabViewSplitViewKind,
        columnVisibility: Binding<NavigationSplitViewVisibility>,
        @SequenceBuilder tabViewBuilder: @escaping (AdaptiveTabViewContainerKind) -> TabContent,
        @ViewBuilder defaultContentBuilder: () -> DefaultContentView,
        @ViewBuilder defaultDetailBuilder: () -> DefaultDetailView,
        @ViewBuilder sidebarExtraContent: @escaping () -> SidebarExtraContent
    ) {
        self.appName = appName
        self.selectedTab = selectedTab
        self._navigationPaths = navigationPaths
        self.splitViewKind = splitViewKind
        self.columnVisibility = columnVisibility
        self.tabViewBuilder = tabViewBuilder
        self.defaultContentView = defaultContentBuilder()
        self.defaultDetailView = defaultDetailBuilder()
        self.sidebarExtraContent = sidebarExtraContent
    }

    var body: some View {
        switch splitViewKind {
        case .twoColumn:
            NavigationSplitView(columnVisibility: columnVisibility) {
                SidebarView(
                    appName,
                    selectedTab: selectedTab,
                    tabViewBuilder: tabViewBuilder,
                    sidebarExtraContent: sidebarExtraContent
                )
            } detail: {
                defaultDetailView
            }
        case .threeColumn:
            NavigationSplitView(columnVisibility: columnVisibility) {
                SidebarView(
                    appName,
                    selectedTab: selectedTab,
                    tabViewBuilder: tabViewBuilder,
                    sidebarExtraContent: sidebarExtraContent
                )
            } content: {
                defaultContentView
            } detail: {
                defaultDetailView
            }
        }
    }
}

//struct SidebarLayoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        SidebarLayoutView(
//            "AdaptiveTabView",
//            selectedTab: nil,
//            splitViewKind: .threeColumn,
//            columnVisibility: .constant(.doubleColumn)
//        ) { (_) in
//            PreviewTitleImageProvidingView()
//        } defaultContentBuilder: {
//            Text("Content")
//        } defaultDetailBuilder: {
//            Text("Detail")
//        } sidebarExtraContent: {
//            Text("Hello World")
//        }
//
//        SidebarLayoutView(
//            "AdaptiveTabView",
//            selectedTab: nil,
//            splitViewKind: .twoColumn,
//            columnVisibility: .constant(.doubleColumn)
//        ) { (_) in
//            PreviewTitleImageProvidingView()
//        } defaultContentBuilder: {
//            Text("Content")
//        } defaultDetailBuilder: {
//            Text("Detail")
//        } sidebarExtraContent: {
//            Text("Hello World")
//        }
//    }
//}
