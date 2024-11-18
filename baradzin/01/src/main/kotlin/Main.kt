package io.github.nadevko.bsuir.MPL1

import kotlin.random.Random

abstract class Employee(val name: String) {
    private var money: Int = 0

    fun setMoney(money: Int): Int {
        val oldMoney = this.money
        this.money = money
        return oldMoney
    }

    fun getMoney() = money
}

class Worker(name: String) : Employee(name) {

    fun work(product: String, money: Int) {
        print("$name працуе над \"$product\"")
        setMoney(getMoney() + money)
        println(" і зарабляе $money (рахунак: ${getMoney()})")
    }

    fun smoke(match: Match) {
        println("\n$name ідзе паліць...")
        if (light(match)) {
            println("$name запальвае цыгарку...")
            println("$name паліць")
        } else {
            println("$name думае, ці не бросіць яму...")
        }
    }

    fun light(match: Match): Boolean {
        println("$name спрабуе запаліць запалку")
        return match.light()
    }
}

class Director(name: String) : Employee(name) {

    fun setProductType(factory: Factory, type: ProductType) {
        factory.setProductType(type)
        println(
                "$name змяніў тып вырабу на ${when (type) {
            ProductType.CAR -> "машыны"
            ProductType.POT -> "рондалі"
            ProductType.MATCH -> "запалкі"
        }}"
        )
    }
}

class Factory(private var productType: ProductType = ProductType.CAR) {
    private val workers: MutableList<Worker> = mutableListOf()
    private val products: MutableList<Product> = mutableListOf()

    fun produce(name: String): Product {
        println("\nФабрыка пачала вырабляць \"$name\"")
        val product =
                when (productType) {
                    ProductType.CAR -> Car(name)
                    ProductType.POT -> Pot(name, 3u)
                    ProductType.MATCH -> Match(name)
                }
        workers.forEach {
            it.work(
                    name,
                    when (productType) {
                        ProductType.CAR -> 2_000
                        ProductType.POT -> 500
                        ProductType.MATCH -> 5
                    }
            )
        }
        println("Фабрыка зрабіла \"$name\"")
        products.add(product)
        return product
    }

    fun hire(worker: Worker) = workers.add(worker)

    fun setProductType(type: ProductType) {
        productType = type
    }

    fun transfer(store: Store): MutableList<Product> {
        println("Фабрыка перадае товары на склад")
        store.transfer(this.products.toMutableList())
        this.products.clear()
        return products
    }
}

class Store {
    private val products: MutableList<Product> = mutableListOf()

    fun transfer(products: MutableList<Product>) {
        this.products.addAll(products)
        list()
    }

    fun list() {
        println("\nТовары на складзе магазіна:")
        products.forEach { println(it.getNaming()) }
    }
}

abstract class Product(protected val name: String) {
    fun getNaming() = name
}

enum class ProductType {
    CAR,
    POT,
    MATCH
}

class Car(name: String) : Product(name) {

    fun drive() = println("Машына \"$name\" ў руху")
}

class Pot(name: String, volume: UInt) : Product(name) {
    val volume = volume
}

class Match(name: String) : Product(name) {
    var isLightable = true
    var length = 5

    fun light(): Boolean {
        length -= 1
        if (length == 0) {
            println("$name занадта кароткая")
            isLightable = false
        }
        if (!isLightable) {
            println("$name немагчыма запаліць")
            return false
        }
        if (Random.nextDouble() < 0.3) {
            println("$name не запальваецца")
            return false
        }
        println("$name загараецца...")
        isLightable = false
        return true
    }
}

fun main() {
    val match = Match("Запалачка")
    println("Будуецца фабрыка...")
    val factory = Factory()
    println("Пабудаваны ўсефабрычны мегакамбінат")
    val worker =
            Worker(
                    listOf(
                                    "Іваныч",
                                    "Пятровіч",
                                    "Мікалаіч",
                                    "Лёха",
                                    "Васёк",
                                    "Пятрок",
                                    "Мішаня",
                            )
                            .random()
            )
    val director =
            Director(
                    listOf(
                                    "Іван Іванавіч",
                                    "Пётр Пятровіч",
                                    "Мікалай Мікалаевіч",
                                    "Аляксей Аляксееў",
                                    "Васіль Васільеў",
                                    "Пётр Пятровіч",
                                    "Міхайла Міхайлавіч",
                            )
                            .random()
            )
    val store = Store()
    factory.hire(worker)
    factory.produce("Рэнова логан")
    worker.smoke(match)
    director.setProductType(factory, ProductType.POT)
    factory.produce("Рондаль на 3 літры")
    factory.transfer(store)
}
