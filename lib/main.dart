import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Multi-Platform Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = "Hazır";

  // Firestore testi
  Future<void> testFirestore() async {
    setState(() => status = "Firestore testi çalışıyor...");
    try {
      await FirebaseFirestore.instance.collection("test_collection").add({
        "createdAt": DateTime.now().toIso8601String(),
      });
      setState(() => status = "Firestore testi başarılı!");
    } catch (e) {
      setState(() => status = "Firestore HATA: $e");
    }
  }

  // Google Sign-In testi
  Future<void> testGoogleSignIn() async {
    setState(() => status = "Google Sign-In testi çalışıyor...");
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        setState(() => status = "Google Sign-In iptal edildi");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      setState(
        () => status = "Google Sign-In başarılı: ${userCredential.user!.email}",
      );
    } catch (e) {
      setState(() => status = "Google Sign-In HATA: $e");
    }
  }

  // Google Sign-Out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    setState(() => status = "Çıkış yapıldı");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Multi-Platform Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: testFirestore,
              child: const Text("Firestore Testi"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: testGoogleSignIn,
              child: const Text("Google Sign-In Testi"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: signOut, child: const Text("Çıkış Yap")),
          ],
        ),
      ),
    );
  }
}
