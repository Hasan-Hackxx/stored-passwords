import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_passwords/cloud_Service/cloud_fireStroe_exceptions.dart';
import 'package:my_passwords/cloud_Service/cloud_password.dart';
import 'package:my_passwords/cloud_Service/cloud_firestore_constents.dart';

class CloudFirestoreService {
  final passwords = FirebaseFirestore.instance.collection('passwords');

  Future<void> deletePassword({required String doucmentId}) async {
    try {
      await passwords.doc(doucmentId).delete();
    } catch (e) {
      throw CouldntDeletePasswordException();
    }
  }

  Future<void> deleteAllpasswords({
    required String doucmentId,
    required String ownerUserId,
  }) async {
    try {
      await passwords.doc(ownerUserId).delete();
    } catch (e) {
      throw CouldntDeleteAllPasswordException();
    }
  }

  Future<void> updatepassword({
    required String doucmentId,
    required String text,
  }) async {
    try {
      await passwords.doc(doucmentId).update({textpassword: text});
    } catch (e) {
      throw CouldntUpdatePasswordException();
    }
  }

  Future<CloudPassword> savePassword({required String ownerUserId}) async {
    final doucment = await passwords.add({
      textFieldOwnerId: ownerUserId,
      textpassword: '',
    });

    final getdoucment = await doucment.get();
    return CloudPassword(
      doucmentId: getdoucment.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  Stream<Iterable<CloudPassword>> allpasswords({required String ownerUserId}) =>
      passwords.snapshots().map(
        (event) => event.docs
            .map((doc) => CloudPassword.fromsnapshot(doc))
            .where((password) => password.ownerUserId == ownerUserId),
      );

  Future<Iterable<CloudPassword>> getpassords({
    required String ownerUserId,
  }) async {
    try {
      return await passwords
          .where(textFieldOwnerId, isEqualTo: ownerUserId)
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudPassword.fromsnapshot(doc)),
          );
    } catch (e) {
      throw CouldntGetAllPasswordsException();
    }
  }

  static final CloudFirestoreService shared = CloudFirestoreService._shared();
  CloudFirestoreService._shared();

  factory CloudFirestoreService() => shared;
}
