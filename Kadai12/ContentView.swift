import SwiftUI

struct ContentView: View {
    // 税抜金額
    @State private var amountExcludingTax = ""
    // 消費税率 SwiftUIでUserDefaultsを利用
    @AppStorage("consumptionTaxRate") var consumptionTaxRate = ""
    // 税込金額
    @State private var amountIncludingTax = 0

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("税抜金額")
                TextField("", text: $amountExcludingTax)
                    .roundedBorderTextFieldStyle()
                Text("円")
                Spacer()
            }
            HStack {
                Spacer()
                Text("消費税率")
                TextField("", text: $consumptionTaxRate)
                    .roundedBorderTextFieldStyle()
                Text("%")
                Spacer()
            }
            Button(action: {
                checkAndCalculate()
            }, label: {
                Text("計算")
            })
            HStack {
                Spacer()
                Text("税込金額")
                Text(String(amountIncludingTax))
                    .frame(width: 100, alignment: .trailing)
                Text("円")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }

    func checkAndCalculate() {
        // 税抜金額の入力存在チェックし、スペース除去も実施
        guard let amountExcludingTaxValue = Double(amountExcludingTax.trimmingCharacters(in: .whitespaces)) else {
            return
        }

        // 消費税率の入力存在チェックし、スペース除去も実施
        guard  let consumptionTaxRateValue = Double(consumptionTaxRate.trimmingCharacters(in: .whitespaces)) else {
            return
        }

        let taxRateForCalculation = 1.0 + consumptionTaxRateValue / 100.0
        amountIncludingTax = Int(amountExcludingTaxValue * taxRateForCalculation)
    }
}

extension TextField {
    func roundedBorderTextFieldStyle() -> some View {
        return self
            .textFieldStyle(.roundedBorder)
            .frame(width: 100)
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
    }
}

#Preview {
    ContentView()
}
