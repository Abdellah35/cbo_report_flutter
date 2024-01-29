import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../global/common/toast.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
        .collection('daily-report')
        .orderBy("fbusinessDate", descending: true)
        .orderBy("time", descending: true)
        .limit(1)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return getBody(snapshot);
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

  Scaffold getBody(AsyncSnapshot<QuerySnapshot> snapshot) {
    var reportModel = snapshot.data?.docs;
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
                    const Icon(Icons.calendar_today, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "Business Date: ${reportModel?[0]["fbusinessDate"].toString().toUpperCase()}",
                      style: GoogleFonts.abel(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf8f9fa),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cash',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No. Debit',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_downward,
                                          color: Colors.red),
                                      SizedBox(width: 8),
                                      Text(
                                        'Debit Amount',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${abbreviateNumber(int.parse(reportModel?[0]["noDebit"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ETB ${abbreviateNumber(int.parse(reportModel?[0]["ttlDrAmt"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No. Credit',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_upward,
                                          color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        'Credit Amount',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 184, 239),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${abbreviateNumber(int.parse(reportModel?[0]["noCredit"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ETB ${abbreviateNumber(int.parse(reportModel?[0]["ttlCrAmt"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount Difference',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'ETB ${abbreviateNumber(int.parse(reportModel?[0]["ttlCrAmt"]) - int.parse(reportModel?[0]["ttlDrAmt"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
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
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Non Cash',
                            style: GoogleFonts.abhayaLibre(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.sync_alt,
                                      color: Colors.blue),
                                  const SizedBox(width: 10),
                                  Text(
                                    'No. TR = ${abbreviateNumber(int.parse(reportModel?[0]["noTr"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Amount = ${abbreviateNumber(int.parse(reportModel?[0]["ttlAmount"]))}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 10, 184, 239),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/details");
                              },
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
  }
}
