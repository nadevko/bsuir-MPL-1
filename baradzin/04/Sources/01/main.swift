import Foundation

protocol Person: CustomStringConvertible {
  var firstName: String { get }
  var lastName: String { get }
  var gender: String { get }
  var birthYear: Int { get }
}

struct Human: Person {
  var firstName: String
  var lastName: String
  var gender: String
  var birthYear: Int

  var description: String {
    return "Имя: \(firstName), Фамилия: \(lastName), Пол: \(gender), Год рождения: \(birthYear)"
  }
}

let people: [Person] = [
  Human(firstName: "Иван", lastName: "Иванов", gender: "мужчина", birthYear: 1990),
  Human(firstName: "Мария", lastName: "Петрова", gender: "женщина", birthYear: 1992),
  Human(firstName: "Алексей", lastName: "Сидоров", gender: "мужчина", birthYear: 1995),
  Human(firstName: "Ольга", lastName: "Кузнецова", gender: "женщина", birthYear: 1990),
  Human(firstName: "Дмитрий", lastName: "Михайлов", gender: "мужчина", birthYear: 1985),
  Human(firstName: "Елена", lastName: "Васильева", gender: "женщина", birthYear: 1990),
  Human(firstName: "Сергей", lastName: "Давыдов", gender: "мужчина", birthYear: 1987),
  Human(firstName: "Татьяна", lastName: "Семенова", gender: "женщина", birthYear: 1995),
  Human(firstName: "Владимир", lastName: "Павлов", gender: "мужчина", birthYear: 1980),
  Human(firstName: "Анна", lastName: "Новикова", gender: "женщина", birthYear: 1985),
]

func countByGender(_ people: [Person]) -> (men: Int, women: Int) {
  var menCount = 0
  var womenCount = 0

  for person in people {
    if person.gender == "мужчина" {
      menCount += 1
    } else if person.gender == "женщина" {
      womenCount += 1
    }
  }

  return (menCount, womenCount)
}

func countByBirthYear(_ people: [Person], _ year: Int) -> [Person] {
  return people.filter { $0.birthYear == year }
}

for person in people {
  print(person.description)
}

let genderCount = countByGender(people)
print("\nМужчин: \(genderCount.men)")
print("Женщин: \(genderCount.women)\n")

while true {
  print("Найти по году рождения: ", terminator: "")

  guard let input = readLine(), !input.isEmpty else {
    break
  }

  guard let year = Int(input) else {
    print("\nНекорректный ввод года\n")
    continue
  }

  let peopleBornInYear = countByBirthYear(people, year)

  if peopleBornInYear.isEmpty {
    print("\nНет людей, родившихся в \(year).\n")
  } else {
    print("Люди, родившиеся в \(year)\n")
    for person in peopleBornInYear {
      print(person.description)
    }
    print()
  }
}
