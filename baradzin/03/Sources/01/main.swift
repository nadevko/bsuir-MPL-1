import Foundation

class Person: CustomStringConvertible {
  var lastName: String
  var birthDate: Date

  init(lastName: String, birthDate: Date) {
    self.lastName = lastName
    self.birthDate = birthDate
  }

  func getAge() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
    return ageComponents.year ?? 0
  }

  var description: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return
      "Фамилия: \(lastName), Дата рождения: \(formatter.string(from: birthDate)), Возраст: \(getAge())"
  }
}

class Abiturient: Person {
  var faculty: String

  init(lastName: String, birthDate: Date, faculty: String) {
    self.faculty = faculty
    super.init(lastName: lastName, birthDate: birthDate)
  }

  override var description: String {
    return super.description + ", Факультет: \(faculty)"
  }
}

class Student: Abiturient {
  var course: Int

  init(lastName: String, birthDate: Date, faculty: String, course: Int) {
    self.course = course
    super.init(lastName: lastName, birthDate: birthDate, faculty: faculty)
  }

  override var description: String {
    return super.description + ", Курс: \(course)"
  }
}

class Teacher: Abiturient {
  var position: String
  var experience: Int

  init(lastName: String, birthDate: Date, faculty: String, position: String, experience: Int) {
    self.position = position
    self.experience = experience
    super.init(lastName: lastName, birthDate: birthDate, faculty: faculty)
  }

  override var description: String {
    return super.description + ", Должность: \(position), Стаж: \(experience) лет"
  }
}

let formatter = DateFormatter()
formatter.dateFormat = "dd.MM.yyyy"

let people: [Person] = [
  Abiturient(
    lastName: "Иванов", birthDate: formatter.date(from: "15.08.2000")!, faculty: "Математика"),
  Student(
    lastName: "Петров", birthDate: formatter.date(from: "10.11.1999")!, faculty: "Физика", course: 2
  ),
  Teacher(
    lastName: "Сидоров", birthDate: formatter.date(from: "25.12.1985")!, faculty: "Математика",
    position: "Профессор", experience: 10),
]

print("Перечень персон:\n")
for person in people {
  print(person)
}

print("\nВведите диапазон возрастов через пробел (к примеру, 20 30):")
while true {
  guard let input = readLine(), !input.isEmpty else {
    break
  }

  let ageRange = input.split(separator: " ").compactMap { Int($0) }

  guard ageRange.count == 2 else {
    print("Пожалуйста, введите два числа для диапазона возраста.")
    continue
  }

  let minAge = ageRange[0]
  let maxAge = ageRange[1]

  let filteredPeople = people.filter { person in
    let age = person.getAge()
    return age >= minAge && age <= maxAge
  }

  guard !filteredPeople.isEmpty else {
    print("Нет людей в этом возрасте.")
    continue
  }

  print("Персоны в возрасте от \(minAge) до \(maxAge) лет:\n")
  for person in filteredPeople {
    print(person)
  }
  print()
}
