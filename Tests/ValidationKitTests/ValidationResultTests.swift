@testable import ValidationKit
import Testing

struct ValidationResultTests {
    @Test func validResult() {
        let result = ValidationResult<String>.valid("hello")

        #expect(result.isValid)
        #expect(result.value == "hello")
        #expect(result.errors.isEmpty)
    }

    @Test func invalidResultSingleError() {
        let result = ValidationResult<String>.invalid(.notEmpty)

        #expect(!result.isValid)
        #expect(result.value == nil)
        #expect(result.errors.count == 1)
        #expect(result.errors.first == .notEmpty)
    }

    @Test func invalidResultMultipleErrors() {
        let result = ValidationResult<String>.invalid([.notEmpty, .invalidEmail])

        #expect(!result.isValid)
        #expect(result.value == nil)
        #expect(result.errors.count == 2)
    }

    @Test func convenienceSingleError() {
        let result = ValidationResult<String>.invalid(.invalidEmail)

        #expect(result.errors.count == 1)
        #expect(result.errors.first == .invalidEmail)
    }
}
