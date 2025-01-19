import 'dart:convert';
import 'package:vigenesia_kelompok1/Models/Motivasi_Model.dart';
import 'package:vigenesia_kelompok1/screen/EditPage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login.dart';
import 'package:vigenesia_kelompok1/Constant/Const.dart';
import 'package:another_flushbar/flushbar.dart';

class MainScreens extends StatefulWidget {
  final String iduser;
  final String nama;
  const MainScreens({Key key, this.nama, this.iduser}) : super(key: key);
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  // Color Scheme (same as Login screen)
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF2A2A50);
  static const Color accentColor = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFF8F9FC);
  static const Color textPrimaryColor = Color(0xFF2D3142);
  static const Color textSecondaryColor = Color(0xFF9093A3);

  String baseurl = url;
  String id;
  var dio = Dio();
  List<MotivasiModel> ass = [];
  TextEditingController titleController = TextEditingController();

  String trigger;

  Future<dynamic> sendMotivasi(String isi) async {
    Map<String, dynamic> body = {"isi_motivasi": isi, "iduser": widget.iduser};
    // [Tambah IDUSER -> Widget.iduser]
    try {
      Response response = await dio.post("$baseurl/api/dev/POSTmotivasi/",
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
// Formatnya Harus Form Data
      print("Respon -> ${response.data} + ${response.statusCode}");
      return response;
    } catch (e) {
      print("Error di -> $e");
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      labelStyle: GoogleFonts.poppins(
        color: textSecondaryColor,
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: primaryColor, size: 22),
    );
  }

  List<MotivasiModel> listproduk = [];
  Future<List<MotivasiModel>> getData() async {
    var response =
        await dio.get('$baseurl/api/Get_motivasi?iduser=${widget.iduser}');
// Ngambil by data
    print(" ${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> deletePost(String id) async {
    dynamic data = {
      "id": id,
    };
    var response = await dio.delete('$baseurl/api/dev/DELETEmotivasi',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Content-type": "application/json"}));
    print(" ${response.data}");
    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<List<MotivasiModel>> getData2() async {
    var response = await dio.get('$baseurl/api/Get_motivasi');
// Ngambil by ALL USER
    print(" ${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> _getData() async {
    setState(() {
      getData();
      listproduk.clear();
      return CircularProgressIndicator();
    });
  }

  TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello, ${widget.nama}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textPrimaryColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: primaryColor),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FormBuilderTextField(
                    controller: isiController,
                    name: "isi_motivasi",
                    decoration: _buildInputDecoration(
                        "Write your motivation", Icons.edit),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: textPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await sendMotivasi(isiController.text.toString())
                          .then((value) => {
                                if (value != null)
                                  {
                                    Flushbar(
                                      message: "Successfully submitted",
                                      duration: Duration(seconds: 2),
                                      backgroundColor: primaryColor,
                                      flushbarPosition: FlushbarPosition.TOP,
                                      borderRadius: BorderRadius.circular(16),
                                      margin: EdgeInsets.all(8),
                                      messageText: Text(
                                        "Successfully submitted",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ).show(context)
                                  }
                              });
                      _getData();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      onPrimary: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: primaryColor),
                    onPressed: _getData,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: FormBuilderRadioGroup(
                    onChanged: (value) {
                      setState(() {
                        trigger = value;
                      });
                    },
                    name: "_",
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    options: ["Motivasi By All", "Motivasi By User"]
                        .map((e) => FormBuilderFieldOption(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.poppins(
                                  color: textPrimaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 16),
                if (trigger == "Motivasi By All")
                  FutureBuilder(
                    future: getData2(),
                    builder:
                        (context, AsyncSnapshot<List<MotivasiModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var item in snapshot.data)
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.05),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  item.isiMotivasi,
                                  style: GoogleFonts.poppins(
                                    color: textPrimaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        );
                      } else if (snapshot.hasData && snapshot.data.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data",
                            style: GoogleFonts.poppins(
                              color: textSecondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        );
                      }
                    },
                  ),
                if (trigger == "Motivasi By User")
                  FutureBuilder(
                    future: getData(),
                    builder:
                        (context, AsyncSnapshot<List<MotivasiModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var item in snapshot.data)
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.05),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.isiMotivasi,
                                        style: GoogleFonts.poppins(
                                          color: textPrimaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: primaryColor, size: 20),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPage(
                                                  id: item.id,
                                                  isi_motivasi:
                                                      item.isiMotivasi,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red, size: 20),
                                          onPressed: () {
                                            deletePost(item.id).then((value) =>
                                                {
                                                  if (value != null)
                                                    {
                                                      Flushbar(
                                                        message:
                                                            "Successfully deleted",
                                                        duration: Duration(
                                                            seconds: 2),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        margin:
                                                            EdgeInsets.all(8),
                                                      ).show(context)
                                                    }
                                                });
                                            _getData();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      } else if (snapshot.hasData && snapshot.data.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data",
                            style: GoogleFonts.poppins(
                              color: textSecondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
