import 'package:flutter/material.dart';
import 'package:ocw/contact_service.dart';
 
class EditForm extends StatefulWidget {
  final Map<dynamic, dynamic> data;
 
  //constructor berfungsi untuk menerima data
  //yang dikirim dari file yang menggunakannya
  EditForm({required this.data});
 
  @override
  State<EditForm> createState() => _EditFormState();
}
 
class _EditFormState extends State<EditForm> {
  //inisialisasi variabel untuk form
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hobby = TextEditingController();
 
  //kita akan menggunakan method dari class Transaction, jadi harus inisialisasi dulu
  ContactService contactService = ContactService();
 
  @override
  void initState() {
    super.initState();
 
    //letakkan fungsi atau method yang ingin dijalankan pertama kali
    //saat file ini dilload/dijalankan
    initializeControllers();
    // Memanggil fungsi initializeControllers saat initState dipanggil
  }
 
  //isi/set form dengan data yang dikirim dari file sebelumnya
  void initializeControllers() {
    name.text = widget.data['name']!;
    gender.text = widget.data['gender']!;
    email.text = widget.data['email']!;
    phone.text = widget.data['phone']!;
    address.text = widget.data['address']!;
    hobby.text = widget.data['hobby']!;
    // Menetapkan nilai awal pada TextEditingController berdasarkan data yang diberikan
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Update Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          // key adalah kunci unik untuk mengidentifikasi suatu form
          // di bawah key ini tambahkan widget sesuai selera kalian
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Nama';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: gender.text,
                items: ['Laki-Laki', 'Perempuan'].map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gender.text = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Handphone'),
                controller: phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Nomor Handphone';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                controller: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Alamat';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hobi'),
                controller: hobby,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukan Hobi';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    contactService.updateData(
                        name.text,
                        gender.text,
                        email.text,
                        phone.text,
                        address.text,
                        hobby.text,
                        widget.data['id']);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) =>
                          false, // Ini akan menghapus semua halaman sebelumnya dari tumpukan navigasi.
                    );
                  }
                },
                child: Text('Update Data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}