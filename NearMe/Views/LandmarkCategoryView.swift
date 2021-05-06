//
//  LandmarkCategoryView.swift
//  NearMe
//
//  Created by Mohammad Azam on 5/6/21.
//

import SwiftUI

struct LandmarkCategoryView: View {
    
    let categories = ["Groceries", "Hotels", "Coffee", "Gas", "Takeout", "Pharmacies", "Hotels"]
    let onSelectedCategory: (String) -> ()
    @State private var selectedCategory: String = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        onSelectedCategory(category)
                    }, label: {
                        Text(category)
                    }).padding(10)
                    .foregroundColor(selectedCategory == category ? Color.white: Color(#colorLiteral(red: 0.204610765, green: 0.2861392498, blue: 0.3685011268, alpha: 1)))
                    .background(selectedCategory == category ? Color(#colorLiteral(red: 0.4982050061, green: 0.5490344763, blue: 0.5528618097, alpha: 1)): Color(#colorLiteral(red: 0.9254772663, green: 0.9412199855, blue: 0.9449794888, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                }
            }
            
        }
    }
}

struct LandmarkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCategoryView(onSelectedCategory: { _ in })
    }
}
