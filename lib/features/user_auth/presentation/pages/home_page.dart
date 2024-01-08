import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbo_report/report_controller.dart';
import 'package:cbo_report/report_model.dart';
import 'package:get/get.dart';
import '../../../../global/common/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _reportStream = FirebaseFirestore.instance
      .collection('cbo-daily')
      .where('id', isEqualTo: "b44xiw9gHWPzjQVMPdu2")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                "assets/images/Cooplogo.png",
                height: 40,
                width: 75,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 4,
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
              child: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  showToast(message: "Successfully signed out");
                },
              ),
            ),
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 10, 184, 239),
          child: FutureBuilder(
            future: controller.getReportData(),
            builder: (context, snapshat) {
              if (snapshat.connectionState == ConnectionState.done) {
                if (snapshat.hasData) {
                  ReportModel reportModel = snapshat.data as ReportModel;
                  return Column(
                    children: [
                      Text(
                        "Business Date: ${reportModel.fbusinessDate}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // const Text(
                      //   'Cash',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // GridView.count(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   padding: const EdgeInsets.all(10),
                      //   shrinkWrap: true,
                      //   children: [
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ],
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'No_ of Debit',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184, 239),
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.noDebit,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(
                      //                         255, 10, 184, 239))),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ], // use a gradient effect with the cyan-blue color and another color
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'TTL DR Amt',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184,
                      //                     239), // use a different color for the title
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.ttlDrAmt,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(255, 10, 184,
                      //                         239))), // use the same color for the subtitle
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ], // use a gradient effect with the cyan-blue color and another color
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'No_ of Credit',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184,
                      //                     239), // use a different color for the title
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.noCredit,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(255, 10, 184,
                      //                         239))), // use the same color for the subtitle
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ], // use a gradient effect with the cyan-blue color and another color
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'TTL CR Amt',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184,
                      //                     239), // use a different color for the title
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.ttlCrAmt,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(255, 10, 184,
                      //                         239))), // use the same color for the subtitle
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cash',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'No. Debit = ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.noDebit,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Amount = ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.ttlDrAmt,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'No. Credit = ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.noCredit,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Amount = ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.ttlCrAmt,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Amount Diff = ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.noCredit,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // const Text(
                      //   'Non Cash',
                      //   style: TextStyle(
                      //     fontSize: 24,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // GridView.count(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   padding: const EdgeInsets.all(10),
                      //   shrinkWrap: true,
                      //   children: [
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ], // use a gradient effect with the cyan-blue color and another color
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'No_ of TR',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184,
                      //                     239), // use a different color for the title
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.noTr,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(255, 10, 184,
                      //                         239))), // use the same color for the subtitle
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 200,
                      //       width: 200,
                      //       child: Card(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(
                      //                 0xFF00BCD4), // use the same cyan-blue color for the card
                      //             gradient: const LinearGradient(
                      //               colors: [
                      //                 Colors.white,
                      //                 Colors.white
                      //               ], // use a gradient effect with the cyan-blue color and another color
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 blurRadius: 10,
                      //                 offset: const Offset(5, 5),
                      //               ),
                      //             ],
                      //           ),
                      //           child: ListTile(
                      //             // remove the leading widget to remove the icon
                      //             title: const Text(
                      //               'TTL Amount',
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 10, 184,
                      //                     239), // use a different color for the title
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             subtitle: Text(reportModel.ttlAmount,
                      //                 style: const TextStyle(
                      //                     color: Color.fromARGB(255, 10, 184,
                      //                         239))), // use the same color for the subtitle
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Non Cash',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'No. TR',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.noTr,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'TTL Amount',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reportModel.ttlAmount,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshat.hasError) {
                  return Center(child: Text(snapshat.error.toString()));
                } else {
                  return const Center(
                    child: Text("Something is went wrong!"),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
