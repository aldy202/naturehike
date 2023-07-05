import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/view/barang_Form_view.dart';

class Barang extends StatelessWidget {
  const Barang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List barang"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarangFormView(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("user")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text("Error");
                    if (!snapshot.hasData) return Text("No Data");
                    final data = snapshot.data!;

                    return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          var item = (data.docs[index].data() as Map);

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage:
                                    AssetImage("assets/images/tools.png"),
                              ),
                              title: Text("Aldy Bot"),
                              subtitle: Text("Progammer"),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
