//
//  ContentView.swift
//  WeSplit
//
//  Created by Hector Barrios on 7/18/20.
//  Copyright © 2020 Hector Barrios. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermoine", "Ron"]
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount  + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson.isNaN || amountPerPerson.isInfinite ? 0.0: amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                    /*Picker("Number of people", selection:
                    $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }*/
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentages", selection:
                    $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total")) {
                    Text("$\(totalPerPerson * (Double(numberOfPeople) ?? 0), specifier: "%.2f")")
                }
            .navigationBarTitle("WeSplit")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
