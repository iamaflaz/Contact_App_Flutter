import 'package:flutter/material.dart';
import 'package:ocw/contact_service.dart';
import 'package:ocw/edit_form.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  //inisialisasi variabel
  ContactService contactService =
      ContactService(); //inisialisai class transaksi
  List data = []; //digunakan untuk menampung data yang diambil
  bool isLoading = true;
 
  @override
  void initState() {
    super.initState();
    //menjalankan data pertama kali
    getData();
  }
 
  //memanggil data
  void getData() async {
    setState(() {
      isLoading = true;
    });
 
    //menggunakan method getData pada class transact ion
    List getData = await contactService.getData();
    setState(() {
      data = getData; //reversed.toList() akan mengurutkan data DESC
      isLoading = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Apps'),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Menampilkan Circular Progress Indicator
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, item) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      leading: Image(
                        image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        '${data[item]['name']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Kelamin: ${data[item]['gender']} \n'
                        'Phone: ${data[item]['phone']} \n'
                        'Alamat: ${data[item]['address']} \n'
                        'Hobi: ${data[item]['hobby']} \n',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditForm(
                                    data: data[item],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {
                              contactService.deleteData(item);
                              getData();
                            },
                            icon: Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addForm');
        },
        child: Icon(Icons.add), // Ikona FAB
        backgroundColor: Colors.blue, // Warna latar belakang FAB
      ),
    );
  }
}