import 'package:get/get.dart';
import 'package:cbo_report/report_repo.dart';

class ReportController extends GetxController {
  static ReportController get instance => Get.find();

  final _reportRepo = Get.put(ReportRepository());

  getReportData() {
    String id = "b44xiw9gHWPzjQVMPyi6";

    return _reportRepo.getReportDetails(id);
  }
}
// class ReportController extends GetxController {
//   static ReportController get instance => Get.find();

//   final _reportRepo = Get.put(ReportRepository());

//   getReportDataStream() {
//     // change the method name to indicate that it returns a stream
//     String id = "b44xiw9gHWPzjQVMPdu2";
//     return _reportRepo.getReportDetails(id);
//   }
// }
