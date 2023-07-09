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
  const Peminjam({super.key});

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
        title: Text("List barang"),
      ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'List Barang',
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
                final List<DocumentSnapshot> item = snapshot.data!;

                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPeminjam(),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(item[index]['namapeminjam']),
                            subtitle: Text(item[index]['status']),
                            trailing: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    ct.deletePeminjaman(
                                      item[index]['id'].toString(),
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
                  },
                );
              },
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
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
