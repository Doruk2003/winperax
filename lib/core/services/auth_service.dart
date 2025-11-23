// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   // EMAIL / PASSWORD LOGIN
//   Future<UserCredential?> signInWithEmail(String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // GOOGLE LOGIN
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       final googleAuth = await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // SIGN OUT
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // CURRENT USER
//   User? get currentUser => _auth.currentUser;
// }
