import 'package:cbo_report/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbo_report/report_model.dart';
import '../../../../global/common/toast.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// Get a reference to the Firestore instance
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _reportStream =
      FirebaseFirestore.instance
          .collection('daily-report')
          .doc("b44xiw9gHWPzjQVMPyi6")
          .snapshots();
  Stream documentStream =
      FirebaseFirestore.instance.collection('daily-report').snapshots();

  String abbreviateNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '$number';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> documentStream =
        FirebaseFirestore.instance.collection('daily-report').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              var reportModel = snapshot.data?.docs[0];
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
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white), // Icon for date
                              const SizedBox(
                                  width: 8), // Space between the icon and text
                              Text(
                                "Business Date: ${reportModel?["fbusinessDate"]}",
                                style: const TextStyle(
                                  fontSize: 16, // Larger font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFf8f9fa), // Light grey color for the card
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.1), // Lighter shadow for softer look
                                      blurRadius: 10,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    const Text(
                                      'Cash',
                                      style: TextStyle(
                                        fontSize:
                                            24, // Larger font size for the title
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            20), // More space below the title
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Debit
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(Icons.arrow_downward,
                                                color: Colors.red),
                                            const SizedBox(
                                                width: 8), // Icon for debit
                                            const Text(
                                              'No. Debit = ',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              abbreviateNumber(int.parse(
                                                  reportModel?["noDebit"])),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Amount = ${abbreviateNumber(int.parse(reportModel?["ttlDrAmt"]))}',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 10, 184, 239),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Divider(
                                        color: Colors.grey), // Divider
                                    const SizedBox(
                                        height:
                                            20), // More space before the next row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.arrow_upward,
                                                color: Colors.green),
                                            const SizedBox(
                                                width: 8), // Icon for credit
                                            Text(
                                              'No. Credit = ${abbreviateNumber(int.parse(reportModel?["noCredit"]))}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Amount = ${abbreviateNumber(int.parse(reportModel?["ttlCrAmt"]))}',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 10, 184, 239),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Divider(
                                        color: Colors.grey), // Divider
                                    const SizedBox(height: 20),

                                    // Amount Difference Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.compare_arrows,
                                                color: Colors.blue),
                                            const SizedBox(
                                                width:
                                                    8), // Icon for difference
                                            Text(
                                              'Amount Diff = ${abbreviateNumber(int.parse(reportModel?["ttlCrAmt"]) - int.parse(reportModel?["ttlDrAmt"]))}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height:
                                            20), // More space before the button

                                    // Button
                                    Center(
                                      child: ElevatedButton(
                                        onPressed:
                                            () {}, // Add your action here
                                        child: const Text('View Details'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.1), // Lighter shadow for softer look
                                      blurRadius: 10,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    const Text(
                                      'Non Cash',
                                      style: TextStyle(
                                        fontSize:
                                            24, // Larger font size for the title
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            20), // More space below the title
                                    // Transaction Rows
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Number of Transactions
                                        Row(
                                          children: [
                                            const Icon(Icons.sync_alt,
                                                color: Colors.blue),
                                            const SizedBox(
                                                width:
                                                    10), // Icon for transactions
                                            Text(
                                              'No. TR = ${abbreviateNumber(int.parse(reportModel?["noTr"]))}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // Icon for amount
                                            Text(
                                              'Amount = ${abbreviateNumber(int.parse(reportModel?["ttlAmount"]))}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 184, 239),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        color: Colors.grey), // Divider
                                    const SizedBox(height: 20),

                                    // Button
                                    Center(
                                      child: ElevatedButton(
                                        onPressed:
                                            () {}, // Add your action here
                                        child: const Text('View Details'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(
                child: Text("Something is went wrong!"),
              );
            }
          }
        });
  }
}
