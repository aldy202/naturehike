import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateBarang extends StatefulWidget {
  UpdateBarang(
      {super.key,
      this.id,
      this.bfnama,
      this.bfjumlah,
      this.bfdetail,
      this.bfgambar});

  String? id;
  String? bfnama;
  String? bfjumlah;
  String? bfdetail;
  File? bfgambar;

  @override
  State<UpdateBarang> createState() => _UpdateBarangState();
}

class _UpdateBarangState extends State<UpdateBarang> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
