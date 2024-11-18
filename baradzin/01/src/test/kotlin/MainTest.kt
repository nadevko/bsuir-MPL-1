package io.github.nadevko.bsuir.MPL1

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

class MainTest {

    @Test
    fun `test factory hires workers correctly`() {
        val factory = Factory()
        val worker = Worker("Test Worker")
        assertTrue(factory.hire(worker), "Worker should be hired successfully.")
    }

    @Test
    fun `test factory produces products correctly`() {
        val factory = Factory(ProductType.CAR)
        val product = factory.produce("Test Car")
        assertNotNull(product, "Factory should produce a product.")
        assertTrue(product is Car, "Product should be of type Car.")
    }

    @Test
    fun `test factory transfers products to store`() {
        val factory = Factory()
        val store = Store()
        factory.produce("Test Product 1")
        factory.produce("Test Product 2")
        val transferredProducts = factory.transfer(store)
        assertEquals(0, transferredProducts.size, "Factory's product list should be empty after transfer.")
    }

    @Test
    fun `test store receives transferred products`() {
        val factory = Factory()
        val store = Store()
        factory.produce("Test Product 1")
        factory.produce("Test Product 2")
        factory.transfer(store)
        val output = captureOutput { store.list() }
        assertTrue(output.contains("Test Product 1"), "Store should contain 'Test Product 1'.")
        assertTrue(output.contains("Test Product 2"), "Store should contain 'Test Product 2'.")
    }

    private fun captureOutput(block: () -> Unit): String {
        val originalOut = System.out
        val outputStream = java.io.ByteArrayOutputStream()
        System.setOut(java.io.PrintStream(outputStream))
        try {
            block()
        } finally {
            System.setOut(originalOut)
        }
        return outputStream.toString()
    }
}
