import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/expandablelists_item_widget.dart';
import 'widgets/listpresensiman2_item_widget.dart';
import '../notifikasi_pimpinan_screen/notifikasi_pimpinan_screen.dart';
import '../profile_info_pimpinan_screen/profile_info_pimpinan_screen.dart';

class DashboardPimpinanScreen extends StatefulWidget {
  DashboardPimpinanScreen({Key? key}) : super(key: key);

  @override
  _DashboardPimpinanScreenState createState() =>
      _DashboardPimpinanScreenState();
}

class _DashboardPimpinanScreenState extends State<DashboardPimpinanScreen> {
  List<String> dropdownItemList = [
    "Semua Permohonan",
    "Hari Ini",
    "Minggu Ini",
    "Bulan Ini"
  ];
  int selectedIndex = 0;
  String selectedDropdownItem = "Semua Permohonan";
  final FocusNode dropdownFocusNode = FocusNode();

  // Data untuk beberapa dropdown dengan tabel
  final List<Map<String, dynamic>> expandableData = [
    {"label": "IPDS",
      "tableData": [
        {'Nama': 'Javier','Jenis Pengajuan': 'Presensi Manual','Status': 'Menunggu Persetujuan'},
        {'Nama': 'Alicia','Jenis Pengajuan': 'Presensi Manual','Status': 'Disetujui'},
      ],
    },
    { "label": "UMUM",
      "tableData": [
        {'Nama': 'Mark', 'Jenis Pengajuan': 'Cuti', 'Status': 'Ditolak'},
        {'Nama': 'Sophia', 'Jenis Pengajuan': 'Cuti', 'Status': 'Disetujui'},
      ],
    },
    {"label": "SOSIAL",
      "tableData": [
        {'Nama': 'Javier','Jenis Pengajuan': 'KipApp','Status': 'Menunggu Persetujuan'},
        {'Nama': 'Alicia','Jenis Pengajuan': 'KipApp','Status': 'Disetujui'},
      ],
    },
    {"label": "PRODUKSI",
      "tableData": [
        {'Nama': 'Javier','Jenis Pengajuan': 'Cuti','Status': 'Menunggu Persetujuan' },
        {'Nama': 'Alicia','Jenis Pengajuan': 'Cuti','Status': 'Disetujui'},
      ],
    },
    {"label": "DISTRIBUSI",
      "tableData": [
        {'Nama': 'Javier','Jenis Pengajuan': 'Presensi Manual','Status': 'Menunggu Persetujuan'},
        {'Nama': 'Alicia','Jenis Pengajuan': 'Presensi Manual','Status': 'Disetujui'},
      ],
    },
    {"label": "NERACA",
      "tableData": [
        {'Nama': 'Javier','Jenis Pengajuan': 'Cuti','Status': 'Disetujui'},
        {'Nama': 'Alicia','Jenis Pengajuan': 'Cuti','Status': 'Disetujui'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 48),
                  decoration: BoxDecoration(
                    color: appTheme.cyan100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildListpresensiman(context),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownMenu<String>(
                            initialSelection: dropdownItemList.first,
                            onSelected: (String? value) {
                              setState(() {
                                selectedDropdownItem = value!;
                              });
                            },
                            dropdownMenuEntries:
                                dropdownItemList.map((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList(),
                            focusNode: dropdownFocusNode
                              ..canRequestFocus = false,
                          ),
                        ),
                        SizedBox(height: 20),
                        ...expandableData.map((data) {
                          return Column(
                            children: [
                              ExpandablelistsItemWidget(
                                tableData: data["tableData"],
                                label: data["label"],
                                onTapRowone: () {},
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildColumnprice(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnprice(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 24, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoBps,
                  height: 40,
                  width: 50,
                  margin: EdgeInsets.only(left: 26),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 1),
                  child: Text(
                    "Government Approval",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgMdnotificationsnone,
                  height: 24,
                  width: 26,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotifikasiPimpinanScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileInfoPimpinanScreen(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 18),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                  border: Border.all(color: appTheme.gray30001, width: 1),
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvatars3dAvatar21,
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 8),
                    Text("Hi, Pimpinan", style: theme.textTheme.titleSmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListpresensiman(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          final texts = ["Presensi Manual", "Pengajuan Cuti", "KiP APP"];
          final imagePaths = [
            ImageConstant.imgEdit,
            ImageConstant.imgCalendar,
            ImageConstant.imgDownload
          ];
          return Padding(
          padding: EdgeInsets.only(right: 10.0), // Menambahkan jarak antar item
          child: Expanded(
            child: Listpresensiman2ItemWidget(
              text: texts[index],
              imagePath: imagePaths[index],
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedTextColor: Color(0xFF3E9B97),
            ),
          ),
          );
        }),
      ),
    );
  }
}
