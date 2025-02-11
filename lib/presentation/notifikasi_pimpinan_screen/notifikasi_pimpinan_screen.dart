import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../dashboard_pimpinan_screen/dashboard_pimpinan_screen.dart';
import '../detail_absensi_manual_pimpinan_screen/detail_absensi_manual_pimpinan_screen.dart';
import '../detail_pengajuan_cuti_pimpinan_screen/detail_pengajuan_cuti_pimpinan_screen.dart';
import '../detail_pengajuan_kipapp_ketua_tim_screen/detail_pengajuan_kipapp_ketua_tim_screen.dart';
import '../detail_pengajuan_kipapp_ketua_tim_screen_tahun/detail_pengajuan_kipapp_ketua_tim_screen_tahun.dart';
import '../notifikasi_ketua_tim_screen/widgets/listandi_item_widget.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NotifikasiPimpinanScreen extends StatefulWidget {
  const NotifikasiPimpinanScreen({Key? key}) : super(key: key);

  @override
  State<NotifikasiPimpinanScreen> createState() => _NotifikasiPimpinanScreenState();
}

class _NotifikasiPimpinanScreenState extends State<NotifikasiPimpinanScreen> {
  String? userName; // Nama pengguna
  List<Map<String, dynamic>> notifications = []; // Data notifikasi
  List<Map<String, dynamic>> filteredNotifications = []; // Data setelah filter
  bool isLoading = true;

  String selectedTimeFilter = "Semua Permohonan"; // Filter waktu default
  final List<String> timeFilters = ["Semua Permohonan", "Hari Ini", "Minggu Ini", "Bulan Ini"];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  /// Mengambil data pengguna dan notifikasi dari Firestore
  Future<void> _fetchNotifications() async {
    try {
      setState(() {
        isLoading = true; // Tampilkan indikator loading
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Ambil data pengguna
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final submissionsSnapshot = await FirebaseFirestore.instance.collection('submissions').get();

          List<Map<String, dynamic>> tempNotifications = [];

          for (var submission in submissionsSnapshot.docs) {
            final submissionData = submission.data();
            final userId = submissionData['user_id'] ?? '';
            final submissionType = submissionData['submission_type'];
            final createdAt = submissionData['created_at'] as Timestamp?;

            if (submissionType != 'KiP APP') {
              final validStatuses = ['TEAM_APPROVED', 'HEAD_APPROVED', 'HEAD_REJECTED'];
              if (!validStatuses.contains(submissionData['status'])) continue;
            }

            String description = '';
            String teamName = '';

            if (submissionType == "Presensi Manual") {
              description = "Deskripsi: ${submissionData['submission_data']['description']}";
            } else if (submissionType == "Pengajuan Cuti") {
              description = "Alasan: ${submissionData['submission_data']['reason']}";
            } else if (submissionType == "KiP APP") {
              if (submissionData['submission_data']['kipapp_type'] == "Bulanan") {
                description = "Pengumpulan progress Bulanan (${submissionData['submission_data']['year']})";
              } else if (submissionData['submission_data']['kipapp_type'] == "Tahunan") {
                List<dynamic> years = submissionData['submission_data']['years'] ?? [];
                String yearString = years.join(", ");
                description = "Pengumpulan progress Tahunan ($yearString)";
              }
            }

            final rawStatus = submissionData['status'] ?? '';

            String statusText;
            switch (rawStatus) {
              case 'TEAM_APPROVED':
                statusText = 'Menunggu Persetujuan';
                break;
              case 'HEAD_REJECTED':
                statusText = 'Ditolak';
                break;
              case 'HEAD_APPROVED':
                statusText = 'Disetujui';
                break;
              default:
                statusText = '';
            }

            final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
            if (!userDoc.exists) continue;

            final userData = userDoc.data() as Map<String, dynamic>;
            final teamId = userData['team_id']?.toString() ?? '';
            final userName = userData['name'] ?? 'Tidak Diketahui';
            final profileImage = AuthService.getProfilePicturePath(userData['gender']);

            final teamDoc = await FirebaseFirestore.instance.collection('teams').doc(teamId).get();
            if (teamDoc.exists) {
              final teamData = teamDoc.data() as Map<String, dynamic>;
              teamName = teamData['name'] ?? '';
            }

            tempNotifications.add({
              'Submission Data': submissionData,
              'Tim': teamName,
              'Nama': userName,
              'Profile': profileImage,
              'Deskripsi': description,
              'Status': statusText,
              'Tipe': submissionType,
              'Id': submission.id,
              'Created At': createdAt?.toDate(), // Simpan tanggal pengajuan
            });
          }

          setState(() {
            notifications = tempNotifications;
            _applyTimeFilter(); // Terapkan filter waktu
            isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Terapkan filter waktu pada notifikasi
  void _applyTimeFilter() {
    setState(() {
      if (selectedTimeFilter == "Semua Permohonan") {
        filteredNotifications = List.from(notifications);
      } else {
        filteredNotifications = notifications.where((notification) {
          final createdAt = notification['Created At'] as DateTime?;
          if (createdAt == null) return false;

          if (selectedTimeFilter == "Hari Ini") {
            return _isToday(createdAt);
          } else if (selectedTimeFilter == "Minggu Ini") {
            return _isThisWeek(createdAt);
          } else if (selectedTimeFilter == "Bulan Ini") {
            return _isThisMonth(createdAt);
          }

          return true;
        }).toList();
      }
    });
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  bool _isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  bool _isThisMonth(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: DropdownButton<String>(
                      value: selectedTimeFilter,
                      items: timeFilters.map(
                        (filter) {
                          return DropdownMenuItem<String>(
                            value: filter,
                            child: Text(filter),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            selectedTimeFilter = value!;
                            _applyTimeFilter();
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildNotificationList(context),
                  ),
                ],
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPimpinanScreen(),
            ),
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Notifikasi",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    if (filteredNotifications.isEmpty) {
      return Center(
        child: Text(
          "Tidak ada notifikasi",
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        Color statusBackgroundColor;

        // Determine background color based on status
        switch (notification['Status']) {
          case 'Menunggu Persetujuan':
            statusBackgroundColor = Colors.yellow.shade700;
            break;
          case 'Ditolak':
            statusBackgroundColor = Colors.red.shade400;
            break;
          case 'Disetujui':
            statusBackgroundColor = Colors.green.shade400;
            break;
          default:
            statusBackgroundColor = Colors.grey.shade400; // Default color
        }

        return ListandiItemWidget(
          userName: notification['Nama']!,
          description: notification['Deskripsi']!,
          status: notification['Status']!,
          type: notification['Tipe']!,
          backgroundColor: statusBackgroundColor, // Add background color
          onTapRow: () {
            final submissionType = notification['Submission Data']['submission_type'];
            if (submissionType == "Presensi Manual" && notification['Status'] == 'Menunggu Persetujuan') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailAbsensiManualPimpinanScreen(
                    data: notification,
                  ),
                ),
              );
            } else if (submissionType == "Pengajuan Cuti" && notification['Status'] == 'Menunggu Persetujuan') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPengajuanCutiPimpinanScreen(
                    data: notification,
                  ),
                ),
              );
            } else if (submissionType == "KiP APP") {
              final kipAppType = notification['Submission Data']['submission_data']['kipapp_type'];
              if (kipAppType == "Bulanan") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPengajuanKipappKetuaTimScreen(
                      data: notification,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPengajuanKipappKetuaTimScreenTahun(
                      data: notification,
                    ),
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}
