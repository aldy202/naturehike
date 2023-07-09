import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/controller/peminjam_controller.dart';
import 'package:naturehike/view/detailpeminjaman.dart';
import 'package:naturehike/view/peminjamanview.dart';

class Peminjam extends StatefulWidget {
  const Peminjam({Key? key}) : super(key: key);

  @override
  State<Peminjam> createState() => _PeminjamState();
}

class _PeminjamState extends State<Peminjam> {
  var ct = PeminjamController();
  final authController = AuthController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    ct.getPeminjam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Peminjam"),
      ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'List Data Peminjam',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: ct.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<DocumentSnapshot> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (data[index]['uid'] == user.uid) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPeminjam(
                                    // Pass the required data to the detail screen
                                    // id: data[index]['id'],
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                ),
                                child: Text(
                                  'No Image',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(data[index]['namapeminjam']),
                              subtitle: Text(data[index]['status']),
                              trailing: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ct.deletePeminjaman(
                                        data[index]['id'].toString(),
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PeminjamanView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
