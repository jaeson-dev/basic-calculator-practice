//
//  ContentView.swift
//  MyCalculator_practice
//
//  Created by Jaeson.dev on 2022/03/15.
//

import SwiftUI

struct ContentView: View {
    
    @State var currents : String = "0"
    @State var currentOperation: Operation?
    @State var runningNumber = 0.0
    @State var tempValue = 0.0
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea((.all))
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Text(currents)
                        .bold()
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                }
                .padding(35)
                
                //buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .padding()
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight(item: item))
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .font(.system(size: 28))
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal :
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(currents) ?? 0
            }
           else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(currents) ?? 0
            }
           else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(currents) ?? 0
            }
           else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(currents) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.currents) ?? 0
                
                switch self.currentOperation {
                case .add: self.currents = "\(runningValue + currentValue)"
                case .subtract: self.currents = "\(runningValue - currentValue)"
                case .multiply: self.currents = "\(runningValue * currentValue)"
                case .divide: self.currents = "\(runningValue / currentValue)"
                case .nothing:
                    break
                default: break
                }
            }
            if button != .equal {
                self.currents = "0"
            }
        case .clear:
            self.currents = "0"
        case .decimal, .negative, .percent:
            break
            // 숫자 버튼 누르기
        default:
            let number = button.rawValue
            if self.currents == "0"{
                currents = number
            } else {
                self.currents = "\(self.currents)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (5*12)) / 2 + 10
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
