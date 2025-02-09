import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  /// ============================================================
  ///  Ambil data user & tim (sama untuk Pegawai, Ketua Tim,
  ///  dan Pimpinan). Kembalikan userName, teamName, roleId, dsb.
  /// ============================================================
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data() as Map<String, dynamic>;
      final String userName = userData['name'] ?? '';
      final String teamId = userData['team_id']?.toString() ?? '';
      final int roleId = userData['role_id'] ?? 0;
      final String gender = userData['gender'] ?? '';

      String teamName = '';
      if (teamId.isNotEmpty) {
        final teamDoc = await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .get();
        if (teamDoc.exists) {
          final teamData = teamDoc.data() as Map<String, dynamic>;
          teamName = teamData['name'] ?? '';
        }
      }

      return {
        'userName': userName,
        'teamId': teamId,
        'teamName': teamName,
        'roleId': roleId,
        'gender': gender
      };
    } catch (e) {
      print("Error getUserData: $e");
      return null;
    }
  }

  /// ============================================================
  ///  Ambil submissions milik satu tim (untuk Ketua Tim).
  ///   - Gunakan status conversion khusus ketua tim.
  /// ============================================================
  static Future<List<Map<String, dynamic>>> getSubmissionsByTeam({
    required String teamId,
    required String activeFilter, // "Presensi Manual", dll
    required String selectedDropdownItem, // "Semua Permohonan", "Hari Ini", dsb
  }) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('submissions').get();

      List<Map<String, dynamic>> submissions = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final String submissionType = data['submission_type'] ?? '';
        final String rawStatus = data['status'] ?? '';
        final String userId = data['user_id'] ?? '';
        final Timestamp? createdAt = data['created_at'];

        // Abaikan jika submission dibatalkan
        if (rawStatus == 'CANCELED') continue;

        // Filter submission type
        if (activeFilter.isNotEmpty && submissionType != activeFilter) {
          continue;
        }

        // Ambil user doc
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>;
        final userTeamId = userData['team_id']?.toString() ?? '';

        // Harus sesuai tim
        if (userTeamId != teamId) continue;

        // Filter waktu
        if (!_isTimeFilterMatch(createdAt, selectedDropdownItem)) continue;

        // Konversi status untuk ketua tim
        final statusForKetuaTim = _mapStatusForKetuaTim(rawStatus);

        submissions.add({
          'Submission Data': data,
          'Nama': userData['name'] ?? 'Tidak Diketahui',
          'Tim': '', // diisi jika diperlukan
          'Jenis Pengajuan': submissionType,
          'Status': statusForKetuaTim,
          'Id': doc.id,
        });
      }

      return submissions;
    } catch (e) {
      print("Error getSubmissionsByTeam: $e");
      return [];
    }
  }

  /// ============================================================
  /// Ambil submissions dikelompokkan per tim (untuk Pimpinan).
  ///  - Status conversion khusus pimpinan.
  /// ============================================================
  static Future<Map<String, List<Map<String, dynamic>>>>
      getSubmissionsGroupedByTeam({
    required String activeFilter,
    required String selectedDropdownItem,
  }) async {
    try {
      // Mapping nama tim di Firestore -> label tim ringkas
      final Map<String, String> teamNameMapping = {
        'IPDS': 'IPDS',
        'Bagian Umum': 'UMUM',
        'Statistik Sosial': 'SOSIAL',
        'Statistik Produksi': 'PRODUKSI',
        'Statistik Distribusi dan Jasa': 'DISTRIBUSI',
        'Neraca Wilayah dan Analisis': 'NERACA',
      };

      final Map<String, List<Map<String, dynamic>>> teamSubmissions = {
        'IPDS': [],
        'UMUM': [],
        'SOSIAL': [],
        'PRODUKSI': [],
        'DISTRIBUSI': [],
        'NERACA': [],
      };

      final snapshot =
          await FirebaseFirestore.instance.collection('submissions').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final String submissionType = data['submission_type'] ?? '';
        final String rawStatus = data['status'] ?? '';
        final String userId = data['user_id'] ?? '';
        final Timestamp? createdAt = data['created_at'];

        // Filter submission type
        if (activeFilter.isNotEmpty && submissionType != activeFilter) {
          continue;
        }

        // Filter waktu
        if (!_isTimeFilterMatch(createdAt, selectedDropdownItem)) {
          continue;
        }

        // Jika bukan KiP APP, hanya ambil submission dengan status
        // TEAM_APPROVED, HEAD_APPROVED, HEAD_REJECTED
        if (submissionType != 'KiP APP') {
          final validStatuses = [
            'TEAM_APPROVED',
            'HEAD_APPROVED',
            'HEAD_REJECTED'
          ];
          if (!validStatuses.contains(rawStatus)) {
            continue;
          }
        }

        // Ambil user -> tim
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (!userDoc.exists) continue;

        final userTeamId = userDoc['team_id']?.toString() ?? '';
        final userName = userDoc['name'] ?? 'Tidak Diketahui';

        // Ambil nama tim
        final teamDoc = await FirebaseFirestore.instance
            .collection('teams')
            .doc(userTeamId)
            .get();
        if (!teamDoc.exists) continue;

        final originalTeamName = teamDoc['name'] ?? '';
        final mappedTeamLabel = teamNameMapping[originalTeamName];
        if (mappedTeamLabel == null) continue;

        // Konversi status khusus pimpinan
        final statusForPimpinan = _mapStatusForPimpinan(rawStatus);

        teamSubmissions[mappedTeamLabel]?.add({
          'Submission Data': data,
          'Nama': userName,
          'Tim': originalTeamName,
          'Jenis Pengajuan': submissionType,
          'Status': statusForPimpinan,
          'Id': doc.id,
        });
      }

      return teamSubmissions;
    } catch (e) {
      print("Error getSubmissionsGroupedByTeam: $e");
      return {};
    }
  }

  /// ============================================================
  ///  Status Mapping (Untuk Ketua Tim dan Pimpinan)
  /// ============================================================
  /// Status untuk KETUA TIM
  static String _mapStatusForKetuaTim(String rawStatus) {
    switch (rawStatus) {
      case 'PROCESSING':
        return 'Menunggu Persetujuan';
      case 'TEAM_REJECTED':
        return 'Ditolak oleh Ketua Tim';
      case 'TEAM_APPROVED':
        return 'Menunggu Persetujuan Pimpinan';
      case 'HEAD_REJECTED':
        return 'Ditolak oleh Pimpinan';
      case 'HEAD_APPROVED':
        return 'Disetujui oleh Pimpinan';
      default:
        return '';
    }
  }

  /// Status untuk PIMPINAN
  static String _mapStatusForPimpinan(String rawStatus) {
    switch (rawStatus) {
      case 'TEAM_APPROVED':
        return 'Menunggu Persetujuan';
      case 'HEAD_APPROVED':
        return 'Disetujui';
      case 'HEAD_REJECTED':
        return 'Ditolak';
      default:
        return '';
    }
  }

  /// ============================================================
  ///  Util: Filter Waktu (Hari Ini, Minggu Ini, dsb)
  /// ============================================================
  static bool _isTimeFilterMatch(
    Timestamp? createdAt,
    String selectedDropdownItem,
  ) {
    if (createdAt == null) return false;

    final now = DateTime.now();
    final createdDate = createdAt.toDate();

    switch (selectedDropdownItem) {
      case "Hari Ini":
        return now.year == createdDate.year &&
            now.month == createdDate.month &&
            now.day == createdDate.day;
      case "Minggu Ini":
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return createdDate.isAfter(startOfWeek) &&
            createdDate.isBefore(endOfWeek);
      case "Bulan Ini":
        return now.year == createdDate.year && now.month == createdDate.month;
      default:
        // "Semua Permohonan" atau string lain
        return true;
    }
  }
}
