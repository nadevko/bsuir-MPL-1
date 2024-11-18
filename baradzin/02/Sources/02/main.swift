import Foundation

struct Complex: CustomStringConvertible {
  var real: Double
  var imaginary: Double

  init(_ real: Double, _ imaginary: Double) {
    self.real = real
    self.imaginary = imaginary
  }

  var description: String {
    return "\(real)+\(imaginary)i"
  }
}

func readNumber<T: Numeric & LosslessStringConvertible>(_ prompt: String) -> T {
  while true {
    print(prompt, terminator: "")
    if let input = readLine(), let number = T(input) {
      return number
    } else {
      print("Неверный ввод. Пожалуйста, введите число.")
    }
  }
}

func readComplex(_ prompt: String) -> Complex {
  let real: Double = readNumber(prompt + " (действительная часть): ")
  let imaginary: Double = readNumber(prompt + " (мнимая часть): ")
  return Complex(real, imaginary)
}

typealias MultiplyType<T> = (T, T) -> T

let multiplyInts: MultiplyType<Int> = { a, b in
  return a * b
}
let int1: Int = readNumber("Введите первое целое число: ")
let int2: Int = readNumber("Введите второе целое число: ")
print("Произведение целых чисел: \(multiplyInts(int1, int2))")

let multiplyComplex: MultiplyType<Complex> = { a, b in
  Complex(
    a.real * b.real - a.imaginary * b.imaginary,
    a.real * b.imaginary + a.imaginary * b.real
  )
}
let complex1: Complex = readComplex("Введите первое комплексное число")
let complex2: Complex = readComplex("Введите второе комплексное число")
print("Произведение целых чисел: \(multiplyComplex(complex1, complex2))")
