//
//  MovieRecentItem.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import SwiftUI

struct MovieRecentItem: View {
    
    let itemName: String
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text(itemName)
                        .font(.body)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .padding()
                }
            }
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.8), radius: 8, x: 6, y: 10)
        
    }
}

#Preview {
    MovieRecentItem(itemName: "RE")
}
