//
//  InfoView.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import SwiftUI

struct InfoCard: View {
    
    let title: String
    let value: String
    let iconName: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                Spacer()
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            Text(value)
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .padding(.bottom, 10)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    InfoCard(title: "Humidity", value: "70%", iconName: "humidity.fill")
}
