import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naturehike/model/peminjaman_model.dart';

class PeminjamController {
  final CollectionReference peminjamCollection =
      FirebaseFirestore.instance.collection('peminjam');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addPeminjaman(PeminjamanBarangModel peminjaman) async {
    final pm = peminjaman.toMap();

    final DocumentReference docref = await peminjamCollection.add(pm);

    final String docId = docref.id;

    final PeminjamanBarangModel pbm = PeminjamanBarangModel(
      id: docId,
      namapeminjam: peminjaman.namapeminjam,
      alamat: peminjaman.alamat,
      barangpinjam: peminjaman.barangpinjam,
      jumlah: peminjaman.jumlah,
      status: peminjaman.status,
      uid: peminjaman.uid,
    );
    await docref.update(pbm.toMap());
    await getPeminjamanList();
  }

  Future<List<PeminjamanBarangModel>> getPeminjamanList() async {
    try {
      // Mengambil seluruh data peminjaman dari koleksi "peminjaman" di Firebase Firestore
      final QuerySnapshot snapshot = await peminjamCollection.get();

      // Mengubah hasil snapshot menjadi daftar objek PeminjamanBarangModel
      final List<PeminjamanBarangModel> peminjamanList = snapshot.docs
          .map((doc) =>
              PeminjamanBarangModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return peminjamanList;
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      print('Error saat mengambil data peminjaman: $e');
      return [];
    }
  }

  Future<void> updatePeminjaman(PeminjamanBarangModel peminjaman) async {
    try {
      // Mengupdate data peminjaman dengan ID yang sesuai di koleksi "peminjaman" di Firebase Firestore
      await peminjamCollection.doc(peminjaman.id).update(peminjaman.toMap());

      // Menampilkan pesan sukses
      print('Data peminjaman berhasil diperbarui: ${peminjaman.toJson()}');
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      print('Error saat memperbarui data peminjaman: $e');
    }
  }

  Future<void> deletePeminjaman(String peminjamanId) async {
    try {
      // Menghapus data peminjaman dengan ID yang sesuai dari koleksi "peminjaman" di Firebase Firestore
      await peminjamCollection.doc(peminjamanId).delete();

      // Menampilkan pesan sukses
      print('Data peminjaman berhasil dihapus: $peminjamanId');
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      print('Error saat menghapus data peminjaman: $e');
    }
  }
}
