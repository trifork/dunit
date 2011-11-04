#import("../dunit_base.dart");
#import("../dunit_dsl.dart");
#import("../../dlib/pprint.dart");




main() {

  report(test: () { Expect.equals(2,2); },
         as:"Expect two equals two");


}
