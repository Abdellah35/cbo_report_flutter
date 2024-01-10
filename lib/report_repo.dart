import 'package:cbo_report/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReportRepository extends GetxService {
  static ReportRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ReportModel> getReportDetails(String id) async {
    final snapshot =
        await _db.collection("daily-report").where('id', isEqualTo: id).get();
    final userData =
        snapshot.docs.map((e) => ReportModel.fromSnapshot(e)).single;

    return userData;
  }
}

// class ReportRepository extends GetxService {
//   static ReportRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   Stream<QuerySnapshot<Object?>> getReportDetails(String id) {
//     // change the return type to Stream<ReportModel>
//     return _db
//         .collection("cbo-daily")
//         .where('id', isEqualTo: id)
//         .snapshots(); // map the query snapshot to a single ReportModel object
//   }
// }

// class ReportRepository extends GetxService {
//   static ReportRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   DocumentReference getReportDetails(String id) {
//     // change the return type to DocumentReference
//     return _db
//         .collection("cbo-daily")
//         .doc(id); // use the .doc() method to get a document reference by id
//   }
// }
