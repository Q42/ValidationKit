import Testing
import ValidationKit

@Suite("Accepted Validator Tests")
struct AcceptedTests {
  @Test func testAccepted() {
    let validator = Validator<Bool, Bool>.accepted

    #expect(validator.validate(input: false).isValid == false, "False value should not be accepted")
    #expect(validator.validate(input: true).isValid == true, "True value should be accepted")

    #expect(validator.validate(input: true).value == true, "Accepted value should return true")
  }
}
