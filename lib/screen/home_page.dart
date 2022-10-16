import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasse_miner_one/helper/fire_base_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController bookController = TextEditingController();
  TextEditingController autherController = TextEditingController();
  TextEditingController updateBookController = TextEditingController();
  TextEditingController updateAutherController = TextEditingController();

  GlobalKey<FormState> addBook = GlobalKey<FormState>();
  GlobalKey<FormState> updateAddBook = GlobalKey<FormState>();

  String book = "";
  String auther = "";

  String b = "";
  String a = "";

  // int i = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FireBaseCloudHelpper.fireBaseCloudHelpper.fetchAllData();
  }

  final Stream<QuerySnapshot<Object?>> _usersStream =
      FireBaseCloudHelpper.fireBaseCloudHelpper.fetchAllData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text("All Auothers Name"),
        centerTitle: true,
        elevation: 0,
        // actions: [IconButton(onPressed: (){
        //   FireBaseAuthenticationHelper.fireBaseAuthenticationHelper.signOut();
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => LogInPage(),
        //       ),
        //           (route) => false);
        // }, icon: Icon(Icons.logout))],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView(
                        children: data.map((e) {
                          Map<String, dynamic> data =
                              e.data() as Map<String, dynamic>;

                          return Card(
                            child: ListTile(
                              subtitle: Text("Author : ${data['author']}"),
                              title: Text("Book : ${data['book']}"),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      FireBaseCloudHelpper.fireBaseCloudHelpper
                                          .deleteUser(i: e.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      updateBookController.text = data['book'];
                                      updateAutherController.text =
                                          data['author'];
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Fill This"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    b = "";
                                                    a = "";

                                                    updateAutherController
                                                        .clear();
                                                    updateBookController
                                                        .clear();

                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    if (updateAddBook
                                                        .currentState!
                                                        .validate()) {
                                                      updateAddBook
                                                          .currentState!
                                                          .save();

                                                      FireBaseCloudHelpper
                                                          .fireBaseCloudHelpper
                                                          .updateUser(
                                                              book: b,
                                                              auother: a,
                                                              i: e.id);

                                                      b = "";
                                                      a = "";

                                                      updateBookController
                                                          .clear();
                                                      updateAutherController
                                                          .clear();

                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text("Update"),
                                                ),
                                              ],
                                              content: Form(
                                                key: updateAddBook,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          updateAutherController,
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Please Enter Auther First...";
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        a = val!;
                                                      },
                                                      cursorColor:
                                                          Colors.blueAccent,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                        labelText: "Auther",
                                                        labelStyle:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          updateBookController,
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Please Enter Book First...";
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        b = val!;
                                                      },
                                                      cursorColor:
                                                          Colors.blueAccent,
                                                      decoration: InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(),
                                                          focusedBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                          labelText: "Book",
                                                          labelStyle: GoogleFonts.poppins(
                                                              textStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .grey))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                      ),
                    );
                  }
                  return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Fill This"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        book = "";
                        auther = "";

                        bookController.clear();
                        autherController.clear();

                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (addBook.currentState!.validate()) {
                          addBook.currentState!.save();

                          FireBaseCloudHelpper.fireBaseCloudHelpper.addUser(
                            book: book,
                            auother: auther,
                          );

                          book = "";
                          auther = "";

                          bookController.clear();
                          autherController.clear();

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                  content: Form(
                    key: addBook,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: autherController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Auther First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            auther = val!;
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Auther",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: bookController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Book First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            book = val!;
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Book",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
