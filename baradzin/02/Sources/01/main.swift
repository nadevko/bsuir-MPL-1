import Foundation

print("Вводите номера машин:")

var numbers = [String]()
while let input = readLine()?.trimmingCharacters(in: .whitespaces), !input.isEmpty {
  if input.count == 4, input.allSatisfy({ $0.isNumber }) {
    let digitCount = input.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
    if digitCount.values.contains(3) {
      numbers.append(input)
    }
  } else {
    print("Неверный номер машины. Введите 4 цифры.")
  }
}

print("Количество номеров, содержащих ровно три одинаковые цифры: \(numbers.count)")
