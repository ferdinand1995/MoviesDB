//
//  MovieRecentItem.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import SwiftUI

struct MovieRecentItem: View {
    let itemName: String

    var onClickItem: () -> ()
    var clearItem: () -> ()

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button {
                        onClickItem()
                    } label: {
                        Text(itemName)
                            .font(.body)
                            .padding(.leading, .Spacing.xxSmall)

                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button {
                        clearItem()
                    } label: {
                        Image(systemName: "xmark").padding(.trailing, .Spacing.xxSmall)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            Divider()
        }.padding(.top, .Spacing.xxSmall)
    }
}

#Preview {
    MovieRecentItem(itemName: "RE", onClickItem: {}, clearItem: {})
}
