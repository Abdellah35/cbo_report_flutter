import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? id;
  final String fbusinessDate;
  final String noCredit;
  final String noDebit;
  final String noTr;
  final String ttlAmount;
  final String ttlCrAmt;
  final String ttlDrAmt;

  const ReportModel(
      {this.id,
      required this.fbusinessDate,
      required this.noCredit,
      required this.noDebit,
      required this.noTr,
      required this.ttlAmount,
      required this.ttlCrAmt,
      required this.ttlDrAmt});

  toJson() {
    return {"fbusinessDate": fbusinessDate};
  }

  factory ReportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReportModel(
        id: document.id,
        fbusinessDate: data['fbusinessDate'],
        noCredit: data['noCredit'],
        noDebit: data['noDebit'],
        noTr: data['noTr'],
        ttlAmount: data['ttlAmount'],
        ttlCrAmt: data['ttlCrAmt'],
        ttlDrAmt: data['ttlDrAmt']);
  }
}
