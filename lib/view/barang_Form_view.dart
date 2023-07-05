import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturehike/controller/barang_controller.dart';
import 'package:naturehike/model/barang_model.dart';
import 'package:naturehike/view/barang.dart';

class BarangFormView extends StatefulWidget {
  const BarangFormView({super.key});

  @override
  State<BarangFormView> createState() => _BarangFormViewState();
}

class _BarangFormViewState extends State<BarangFormView> {
  var barangController = BarangController();
  final formKey = GlobalKey<FormState>();
  String? name;
  String? jumlah;
  String? detail;
  File? imageFile;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Input"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if (imageFile != null) Image.file(imageFile!),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Select Image'),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  jumlah = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  detail = value;
                },
              ),
              ElevatedButton(
                child: Text('Add Barang'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BarangModel bm = BarangModel(
                        name: name!, jumlah: jumlah!, detail: detail!);
                    barangController.addBarang(bm, imageFile!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Barang(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
