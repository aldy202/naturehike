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

    final DocumentReference docRef = await peminjamCollection.add(pm);

    final String docId = docRef.id;

    final PeminjamanBarangModel pbm = PeminjamanBarangModel(
      id: docId,
      namapeminjam: peminjaman.namapeminjam,
      alamat: peminjaman.alamat,
      barangpinjam: peminjaman.barangpinjam,
      jumlah: peminjaman.jumlah,
      status: peminjaman.status,
      uid: peminjaman.uid,
    );

    await docRef.update(pbm.toMap());
    await getPeminjam();
  }

  Future<List<DocumentSnapshot>> getPeminjam() async {
    final peminjam = await peminjamCollection.get();
    streamController.sink.add(peminjam.docs);

    // Menutup sink setelah mengirim data
    streamController.close();

    return peminjam.docs;
  }

  Future<void> updatePeminjaman(PeminjamanBarangModel peminjaman) async {
    try {
      await peminjamCollection.doc(peminjaman.id).update(peminjaman.toMap());
      print('Data peminjaman berhasil diperbarui: ${peminjaman.toJson()}');
    } catch (e) {
      print('Error saat memperbarui data peminjaman: $e');
    }
  }

  Future<void> deletePeminjaman(String peminjamanId) async {
    try {
      await peminjamCollection.doc(peminjamanId).delete();
      print('Data peminjaman berhasil dihapus: $peminjamanId');
    } catch (e) {
      print('Error saat menghapus data peminjaman: $e');
    }
  }
}
