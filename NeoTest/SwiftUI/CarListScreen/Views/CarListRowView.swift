//
//  CarListView.swift
//  NeoTest
//
//  Created by Bajrang Sinha on 05/01/25.
//

import SwiftUI

struct CarListRowView: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 52.0, height: 52.0)
                .cornerRadius(8.0)
                .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(UIColor.darkGray))
                    .lineLimit(1)
            }
            .padding(.leading, 4)
            
            Spacer()
        }
        .frame(height: 72.0)
        .background(Color(red: 204/255, green: 232/255, blue: 225/255))
        .cornerRadius(12.0)
    }
}

#Preview {
    CarListRowView(title: "Nexon", subtitle: "12.00", imageName: "Nexon")
}
