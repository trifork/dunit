class TestRunner {
  const TestRunner();
  TestResult run(var test, [TestResult result=null]) {
    if (result == null) result = new TestResult();
    if (test is TestCase) {
      _runTestCase(test,result);
    } else if (test is TestSuite) {
      _runTestSuite(test,result);
    }
    return result;
  }


  TestResult _runTestCase(TestCase test, TestResult result) {
    TestResult testCaseResult = new TestResult();
    Stopwatch watch = new Stopwatch();

    time(()=>test.setUp(), watch);

    test.tests().forEach((name,t) {
        Stopwatch testWatch = new Stopwatch();
        try {
          time(t, [watch, testWatch]);
          testCaseResult.pass(t, name, testWatch.elapsedInUs());
        } catch (var exception, var st) {
          testCaseResult.fail(t, name, testWatch.elapsedInUs(), exception.toString(), st);
        }
      });

    time(()=>test.tearDown(), watch);

    var caseTime = watch.elapsedInUs();
    if (testCaseResult.noDefects()) {
      result.pass(test,test.name, caseTime, result:testCaseResult);
    } else {
      result.fail(test,test.name, caseTime, result:testCaseResult);
    }
    return result;

  }

  TestResult _runTestSuite(TestSuite suite, TestResult result) {
    TestResult testSuiteResult = new TestResult();
    Stopwatch watch = new Stopwatch();

    suite.testCases.forEach((tc) {
        Stopwatch testWatch = new Stopwatch();//TODO SUM instead of time
        time(()=>_runTestCase(tc,testSuiteResult),
             [watch, testWatch]);
      });

    var suiteTime = watch.elapsedInUs();
    if (testSuiteResult.noDefects()) {
      result.pass(suite,suite.name, suiteTime, result:testSuiteResult);
    } else {
      result.fail(suite,suite.name, suiteTime, result:testSuiteResult);
    }
    return result;
  }

}
