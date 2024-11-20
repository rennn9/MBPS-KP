import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/expandablelists_item_widget.dart';
import 'widgets/listpresensiman2_item_widget.dart';

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

  // Data untuk tabel yang akan diubah sesuai dropdown yang dipilih
  List<Map<String, String>> tableData = [
    {'Nama': 'Javier', 'Jenis Pengajuan': 'Presensi Manual', 'Status': 'Menunggu Persetujuan'},
    {'Nama': 'Alicia', 'Jenis Pengajuan': 'Cuti Tahunan', 'Status': 'Disetujui'},
    {'Nama': 'Mark', 'Jenis Pengajuan': 'Izin Sakit', 'Status': 'Ditolak'},
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
                        // Horizontal scrollable list
                        _buildListpresensiman(context),
                        SizedBox(height: 20),

                        // Dropdown menu widget
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
                                // Update table data based on dropdown selection
                                _updateTableData(value);
                              });
                            },
                            dropdownMenuEntries: dropdownItemList.map((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList(),
                            focusNode: dropdownFocusNode..canRequestFocus = false,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Expandable list widget with dynamic table data
                        ExpandablelistsItemWidget(
                          tableData: tableData,  // Passing dynamic data
                          onTapRowone: () {
                            // Add functionality for tap event if needed
                          },
                        ),
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

  void _updateTableData(String selectedItem) {
    // Update table data based on the selected dropdown item
    switch (selectedItem) {
      case "Hari Ini":
        tableData = [
          {'Nama': 'Rina', 'Jenis Pengajuan': 'Liburan', 'Status': 'Menunggu Persetujuan'},
        ];
        break;
      case "Minggu Ini":
        tableData = [
          {'Nama': 'Andi', 'Jenis Pengajuan': 'Pengunduran Diri', 'Status': 'Disetujui'},
        ];
        break;
      case "Bulan Ini":
        tableData = [
          {'Nama': 'Budi', 'Jenis Pengajuan': 'Izin Sakit', 'Status': 'Ditolak'},
        ];
        break;
      default:
        tableData = [
          {'Nama': 'Javier', 'Jenis Pengajuan': 'Presensi Manual', 'Status': 'Menunggu Persetujuan'},
          {'Nama': 'Alicia', 'Jenis Pengajuan': 'Cuti Tahunan', 'Status': 'Disetujui'},
          {'Nama': 'Mark', 'Jenis Pengajuan': 'Izin Sakit', 'Status': 'Ditolak'},
        ];
        break;
    }
  }

  Widget _buildColumnprice(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 24, right: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoBps,
                    height: 28,
                    width: 40,
                    margin: EdgeInsets.only(left: 26),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 4),
                      child: Text(
                        "BADAN PUSAT STATISTIK",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgMdnotificationsnone,
                    height: 24,
                    width: 26,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.maxFinite,
              child: GestureDetector(
                onTap: () {},
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hi, Pimpinan",
                                style: theme.textTheme.titleSmall),
                            Text("IPDS", style: theme.textTheme.bodySmall)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListpresensiman(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(
            3,
            (index) {
              final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
              final imagePaths = [
                ImageConstant.imgEdit,
                ImageConstant.imgCalendar,
                ImageConstant.imgDownload
              ];
              return Listpresensiman2ItemWidget(
                text: texts[index],
                imagePath: imagePaths[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedTextColor: Color(0xFF3E9B97),
              );
            },
          ),
        ),
      ),
    );
  }
}
