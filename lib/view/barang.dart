import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/controller/barang_controller.dart';
import 'package:naturehike/view/barang_Form_view.dart';
import 'package:naturehike/view/updatebarang.dart';

class Barang extends StatefulWidget {
  const Barang({super.key});

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  var cc = BarangController();
  final authController = AuthController();

  @override
  void initState() {
    cc.getBarang();
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
            stream: cc.stream,
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
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InkWell(
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateBarang(
                                // id: data[index]['id'],

                                ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: data[index]['imageUrl'] != null
                                ? Image.network(
                                    data[index]['imageUrl'],
                                    fit: BoxFit.cover,
                                  )
                                : Text(
                                    data[index]['name']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          title: Text(data[index]['name']),
                          subtitle: Text(data[index]['jumlah']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cc.deleteContact(
                                data[index]['id'].toString(),
                              );
                              setState(() {
                                cc.getBarang();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BarangFormView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
