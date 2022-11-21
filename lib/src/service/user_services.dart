// ignore_for_file: unused_field

part of 'services.dart';

class UserServices {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserServices({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  final usersCollection =
      FirebaseFirestore.instance.collection(userCollectionName);
  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? password, String? name}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final userData = UserModel(
          admin: false,
          email: userCredential.user!.email,
          photoProfile: '',
          uid: userCredential.user!.uid,
          username: name);

      usersCollection.doc(userCredential.user!.uid).set(userData.toMap());
      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<Either<String, UserModel>> loginWithEmail(
      {String? email, String? password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      return loadUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<Either<String, UserModel>> loadUserData(String? uid) async {
    try {
      final userData = await usersCollection.doc(uid).get();
      if (userData.data()!.isNotEmpty) {
        return right(UserModel.fromMap(userData.data()!));
      } else {
        return left('User Belum Terdaftar');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final userCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      await FirebaseAuth.instance.signInWithCredential(userCredential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
