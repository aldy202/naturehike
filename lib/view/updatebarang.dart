import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturehike/controller/barang_controller.dart';

import '../model/barang_model.dart';

class UpdateBarang extends StatefulWidget {
  const UpdateBarang({
    super.key,
    this.id,
    this.bfnama,
    this.bfjumlah,
    this.bfdetail,
    this.bfgambar,
  });

  final String? id;
  final String? bfnama;
  final String? bfjumlah;
  final String? bfdetail;
  final File? bfgambar;

  @override
  State<UpdateBarang> createState() => _UpdateBarangState();
}

class _UpdateBarangState extends State<UpdateBarang> {
  var barangController = BarangController();
  final formkey = GlobalKey<FormState>();

  String? newname;
  String? newjumlah;
  String? newdetail;
  File? newgambar;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        newgambar = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Barang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                    child: newgambar != null
                        ? Image.file(newgambar!)
                        : const Placeholder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Select Image'),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nama Barang'),
                  onChanged: (value) {
                    newname = value;
                  },
                  initialValue: widget.bfnama,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Jumlah'),
                  onChanged: (value) {
                    newjumlah = value;
                  },
                  initialValue: widget.bfjumlah,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Detail'),
                  onChanged: (value) {
                    newdetail = value;
                  },
                  initialValue: widget.bfdetail,
                ),
                ElevatedButton(
                  child: Text('Update Barang'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BarangModel barangModel = BarangModel(
                        name: newname!,
                        jumlah: newjumlah!,
                        detail: newdetail!,
                        imageUrl: widget.bfgambar?.path,
                      );
                      await barangController.updateBarang(
                          widget.id!, barangModel, newgambar!);

                      Navigator.pop(
                          context); // Kembali ke halaman sebelumnya setelah update berhasil// Menggunakan path gambar sebelumnya
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
