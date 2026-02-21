//
//  MoviesView.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 17/02/26.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct MoviesView: View {
    @EnvironmentObject var router: ViewRouter

    @State private var textInput: String = ""
    @State private var progress: CGFloat = 0
    @State private var isFocused: Bool = false

    @State private var state: MoviesState

    var coordinator = UICoordinator()
    
    init() {
        state = MoviesState()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                profileOptions(geometry)
            }.toolbar(.hidden, for: .navigationBar)
        }
    }

    private func profileOptions(_ geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            VStack(spacing: .Spacing.xxxSmall) {
                /// Grid Image View
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 8), count: 2), spacing: 8) {
                    ForEach(state.movies, id: \.id) { item in
                        movieCardView(item)
                    }
                }
            }
            .padding(.Spacing.small)
            .offset(y: isFocused ? 0 : (progress * 72))
            .padding(.bottom, 72)
            .safeAreaInset(edge: .top, spacing: 0) {
                resizeableHeader()
            }
            .background(ScrollViewExtractor(result: {
                coordinator.scrollView = $0
            }))
        }
        .scrollTargetBehavior(CustomScrollTarget())
        .animation(.snappy(duration: 0.3, extraBounce: 0), value: isFocused)
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y + geometry.contentInsets.top
        } action: { _, newValue in
            progress = max(min(newValue / 75, 1), 0)
        }
    }

    @ViewBuilder
    func resizeableHeader() -> some View {
        let progress = isFocused ? 1 : progress

        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: .Spacing.xxxSmall) {
                    Text("Welcome Back!")
                        .font(.callout)
                    Text("username")
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button {} label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(.circle)
                }
            }
            .frame(height: 64 - (64 * progress), alignment: .bottom)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .padding(.bottom, 16 - (16 * progress))
            .opacity(1 - progress)
            .offset(y: -10 * progress)

            SearchBar(
                placeHolderText: "Search Movie...",
                searchText: $textInput,
                isFocused: $isFocused
            )
            .background(.white)
            .padding(.bottom, 8)
            .padding(.top, isFocused ? -8 : 0)
            .padding(.horizontal, isFocused ? 4 : 16)
        }
        .background {
            ProgressiveBlurView()
                .blur(radius: 8)
                .padding(.horizontal, -16)
                .padding(.bottom, -8)
                .padding(.top, -96)
        }
        .visualEffect { content, proxy in
            content.offset(y: offsetY(proxy))
        }
    }

    private nonisolated func offsetY(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
        return minY > 0 ? (isFocused ? -minY : 0) : -minY
    }

    func movieCardView(_ movie: Movie) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)

            WebImage(url: URL(string: movie.posterURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.3))
            .scaledToFit()
            .frame(width: frame.width, height: frame.height)
            .clipShape(.rect(cornerRadius: 8))
            .contentShape(.rect(cornerRadius: 8))
            .onTapGesture {
                coordinator.rect = frame
                router.present(.detail(movieId: "tt10982034"))
            }
        }.frame(height: 184)
    }
}

struct CustomScrollTarget: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let endPoint = target.rect.minY

        guard endPoint < 72 else { return }
        if endPoint > 40 {
            target.rect.origin = .init(x: 0, y: 72)
        } else {
            target.rect.origin = .zero
        }
    }
}
