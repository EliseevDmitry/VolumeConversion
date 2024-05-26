//
//  ContentView.swift
//  VolumeConversion
//
//  Created by Dmitriy Eliseev on 23.05.2024.
//

import SwiftUI

struct PickerSettings: ViewModifier {
    //MARK: - BODY
    func body(content: Content) -> some View {
        content
            .pickerStyle(.segmented)
            .onAppear{
                UISegmentedControl.appearance().backgroundColor = .orange
                UISegmentedControl.appearance().selectedSegmentTintColor = .blue
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
            }
    }//: BODY
}

//MARK: - EXTENSION
extension View {
    func pikerStyle() -> some View {
        modifier(PickerSettings())
    }
}//: EXTENSION

struct ContentView: View {
    
    //MARK: - PROPORTIES
    let data = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    @State private var inputVolimeData = 0.0
    @State private var outputVolumeData = 0.0
    @State private var inputParameter = "Milliliters"
    @State private var outputParametr = "Liters"
    @FocusState private var amountIsFocused: Bool

    //вычисляемое свойство
    var volumeConversion: Double {
        let unit: Measurement<UnitVolume>
        switch inputParameter {
            case data[0]: unit = Measurement(value: inputVolimeData, unit: UnitVolume.milliliters)
            case data[1]: unit = Measurement(value: inputVolimeData, unit: UnitVolume.liters)
            case data[2]: unit = Measurement(value: inputVolimeData, unit: UnitVolume.cups)
            case data[3]: unit = Measurement(value: inputVolimeData, unit: UnitVolume.pints)
            case data[4]: unit = Measurement(value: inputVolimeData, unit: UnitVolume.gallons)
            default:
                return 0.0
            }
        switch outputParametr {
            case data[0]: return unit.converted(to: .cubicMillimeters).value
            case data[1]: return unit.converted(to: .cubicDecimeters).value
            case data[2]: return unit.converted(to: .cups).value
            case data[3]: return unit.converted(to: .pints).value
            case data[4]: return unit.converted(to: .gallons).value
            default:
                return 0.0
            }
    }

    //MARK: - BODY
    var body: some View {
        NavigationStack{
            Form{
                
                Section("Input data"){
                    VStack (spacing: 20){
                        Picker("Choose ...", selection: $inputParameter) {
                            ForEach(data, id: \.self) {
                                Text($0)
                            }
                        }
                        .pikerStyle()
        
                        TextField("Enter data in field",
                                  value: $inputVolimeData,
                                  format: .number
                        )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    }//:VSTACK
                }//: SECTION 1
                
                Section ("outputdata"){
                    Picker("Choose ...", selection: $outputParametr) {
                        ForEach(data, id: \.self) {
                            Text($0)
                        }
                    }
                    .pikerStyle()
                    
                    Text(volumeConversion.formatted(.number))
                    
                }//: SECTION 2
                
            }//: FORM
            .navigationTitle("VolumeConversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }//: NAVIGATIONSTACK
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
