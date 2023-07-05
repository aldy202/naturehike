import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:naturehike/model/barang_model.dart';

class BarangController {
  final barangCollection = FirebaseFirestore.instance.collection('barang');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addBarang(BarangModel brmodel, File imageFile) async {
    final barang = brmodel.toMap();
    final DocumentReference docRef = await barangCollection.add(barang);

    final String docId = docRef.id;

    if (imageFile != null) {
      final String imageName = DateTime.now().microsecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(imageName);

      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(imageFile);
      final firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      if (taskSnapshot.state == firebase_storage.TaskState.success) {
        final String imageUrl = await taskSnapshot.ref.getDownloadURL();

        final BarangModel contactModel = BarangModel(
          id: docId,
          name: brmodel.name,
          jumlah: brmodel.jumlah,
          detail: brmodel.detail,
          imageUrl: imageUrl,
        );

        await docRef.update(contactModel.toMap());
      } else {
        print('Failed to upload image');
      }
    } else {
      final BarangModel barangModel = BarangModel(
        id: docId,
        name: brmodel.name,
        jumlah: brmodel.jumlah,
        detail: brmodel.detail,
      );

      await docRef.update(barangModel.toMap());
    }
  }

  Future getBarang() async {
    final barang = await barangCollection.get();
    streamController.add(barang.docs);
    return barang.docs;
  }

  Future updateBarang(
    String docId,
    BarangModel barangModel,
    File imageFile,
  ) async {
    final BarangModel brmModel = BarangModel(
      name: barangModel.name,
      jumlah: barangModel.jumlah,
      detail: barangModel.detail,
      id: docId,
      imageUrl: barangModel.imageUrl,
    );

    final DocumentSnapshot documentSnapshot =
        await barangCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      print('Contact with ID $docId does not exist');
      return;
    }

    if (imageFile != null) {
      final String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(imageName);

      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(imageFile);
      final firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      if (taskSnapshot.state == firebase_storage.TaskState.success) {
        final String imageUrl = await taskSnapshot.ref.getDownloadURL();

        final updatedContactModel = brmModel.copyWith(imageUrl: imageUrl);
        await barangCollection.doc(docId).update(updatedContactModel.toMap());
      } else {
        print('Failed to upload image');
      }
    } else {
      await barangCollection.doc(docId).update(brmModel.toMap());
    }

    await getBarang();
    print('Updated contact with ID: $docId');
  }

  Future deleteContact(String id) async {
    final contact = await barangCollection.doc(id).delete();
    return contact;
  }
}