#import("../dunit/dunit_base.dart");
#import("../dunit/dunit_dsl.dart");
#import("../dlib/pprint/pprint.dart");




main() {

  report(test: () { Expect.equals(2,2); },
         as:"Expect two equals two");


}
