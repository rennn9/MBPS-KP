import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sign In Function
  Future<void> signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Cari email berdasarkan username di Firestore
      final QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        // Jika username tidak ditemukan
        _showToast("Username tidak ditemukan.");
        return;
      }

      // Ambil email dari database
      final String email = userSnapshot.docs.first['email'];

      // Login menggunakan email dan password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Ambil informasi pengguna
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final roleId = userData['role_id'];

          // Navigasi berdasarkan role_id
          _navigateByRole(roleId, context);
        } else {
          _showToast("Data pengguna tidak ditemukan, hubungi admin.");
        }
      }
    } on FirebaseAuthException catch (_) {
      // Handle Firebase-specific sign-in errors
      _showToast(
          "Username atau password yang Anda masukkan salah, silahkan coba lagi.");
    } catch (e) {
      // Handle unexpected errors
      _showToast("Terjadi kesalahan: $e");
    }
  }

  /// Navigasi berdasarkan role_id
  void _navigateByRole(int roleId, BuildContext context) {
    switch (roleId) {
      case 1:
        // Root
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardAdminScreen);
        break;
      case 2:
        // Admin
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardAdminScreen);
        break;
      case 3:
        // Pegawai
        Navigator.pushReplacementNamed(
            context, AppRoutes.dashboardPegawaiScreen);
        break;
      case 4:
        // Ketua Tim
        Navigator.pushReplacementNamed(
            context, AppRoutes.dashboardKetuaTimScreen);
        break;
      case 5:
        // Pimpinan
        Navigator.pushReplacementNamed(
            context, AppRoutes.dashboardPimpinanScreen);
        break;
      default:
        _showToast("Role tidak dikenal, hubungi admin.");
    }
  }

  /// Menampilkan pesan Toast
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  /// Reset password
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      // Kirim email reset password menggunakan FirebaseAuth
      await _auth.sendPasswordResetEmail(email: email);
      _showToast("Email reset password telah dikirim ke $email");
    } on FirebaseAuthException catch (e) {
      // Tangani error spesifik Firebase
      _showToast("Terjadi kesalahan: ${e.message}");
    } catch (e) {
      // Tangani error lainnya
      _showToast("Terjadi kesalahan: $e");
    }
  }

  /// Fungsi untuk mendapatkan path foto profil berdasarkan gender
  static String getProfilePicturePath(String? gender) {
    if (gender != null) {
      final lowerGender = gender.toLowerCase();
      if (lowerGender.contains("laki")) {
        return ImageConstant.imgAvatarsMale;
      } else if (lowerGender.contains("perempuan")) {
        return ImageConstant.imgAvatarsFemale;
      }
    }
    // Jika null atau tidak mengandung kata "laki" atau "perempuan"
    return ImageConstant.imgAvatars3dAvatar21;
  }
}
