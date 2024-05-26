//
//  ViewData.swift
//  VolumeConversion
//
//  Created by Dmitriy Eliseev on 24.05.2024.
//

import SwiftUI

struct ViewData: View {
    
    @State var imputPicerData = ""
    var startData: [String]
   
    
    var body: some View {
        VStack (spacing: 20){
            Picker("Choose ...", selection: $imputPicerData) {
                ForEach(startData, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .onAppear{
                UISegmentedControl.appearance().backgroundColor = .orange
                UISegmentedControl.appearance().selectedSegmentTintColor = .blue
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                
                   UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
            }

        }//:VSTACK
    }
}

    #Preview(traits: .sizeThatFitsLayout) {
        ViewData(startData: [""])
    }

