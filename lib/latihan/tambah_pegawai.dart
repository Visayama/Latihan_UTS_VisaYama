import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latihan_uts/latihan/list_pegawai.dart';
import 'package:latihan_uts/latihan_model/model_tambah_karyawan.dart';

class PageAddPegawai extends StatefulWidget {
  const PageAddPegawai({super.key});

  @override
  State<PageAddPegawai> createState() => _PageAddPegawaiState();
}

class _PageAddPegawaiState extends State<PageAddPegawai> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtNobp = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController tanggalInput = TextEditingController();

  //validasi form
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  //Proses untuk hit API
  bool isLoading = false;

  Future<ModelAddPegawai?> registerPegawai() async {
    //handle error
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
          Uri.parse('http://192.168.43.45/edukasi_server/addPegawai.php'),
          body: {
            "nama": txtNama.text,
            "nobp": txtNobp.text,
            "nohp": txtNohp.text,
            "email": txtEmail.text,
            "tanggal_input": tanggalInput.text
          });

      ModelAddPegawai data = modelAddPegawaiFromJson(response.body);

      //Cek kondisi
      if (data.value == 1) {
        //Kondisi ketika berhasil register
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));

          //pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageKaryawan()),
                  (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  //Untuk Datepicker
  Future selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        tanggalInput.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form Pegawai'),
      ),

      body: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNama,
                    decoration: InputDecoration(
                        hintText: 'Nama',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNobp,
                    decoration: InputDecoration(
                        hintText: 'NOBP',
                        prefixIcon: Icon(Icons.format_list_numbered_sharp),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNohp,
                    decoration: InputDecoration(
                        hintText: 'No HP',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtEmail,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onTap: (){
                      selectDate();
                    },
                    //validasi kosong
                    validator: (val){
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: tanggalInput,
                    decoration: InputDecoration(
                        hintText: 'Tanggal Input',
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //Proses cek loading
                  Center(
                      child: isLoading
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : MaterialButton(
                        minWidth: 150,
                        height: 45,
                        onPressed: () {
                          //Cek validasi form ada kosong atau tidak
                          if (keyForm.currentState?.validate() ==
                              true) {
                            setState(() {
                              registerPegawai();
                            });
                          }
                        },
                        child: Text('Tambah'),
                        color: Colors.green,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 1, color: Colors.blueGrey)),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}