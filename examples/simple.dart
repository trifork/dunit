#import("../dunit_base.dart");
#import("../../pprint/pprint.dart");



class ATest extends TestCase {
  ATest():super("ATest");
  tests() => {

    """ Verifies the relationship between object A and b.
Ensures a """    : testA,

    "it should B": testB,

    "it should C too": (){ }
  };

  testA() {

  }
  testB() {
    Expect.equals(42, "42", "but isnt 4242?");
  }
  int hashCode() => 42;
}


main() {
  var tr = new TestRunner().run(new ATest());
  new TestReporter().report(tr);

}
