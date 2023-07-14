import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/models/user_model.dart';

import '../helpers/style.dart';
import '../services/user_service.dart';
import '../widgets/cab_header.dart';
import '../widgets/cab_text.dart';
import '../widgets/search_field.dart';
import '../widgets/tiles/user_tile.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = "/Users";
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserModel> users = [];
  List<UserModel>? filteredResult;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  @override
  void initState() {
    UserService().fetchUsers().then((value) => setState(() {
          value.removeWhere((element) => element.email == "admin@provis.com");
          users = value;
          filteredResult = value;
        }));
    super.initState();
  }

  void filterData() {
    List<UserModel> dummy = [];
    for (var element in users) {
      if (nameController.text.trim().isEmpty &&
          idController.text.trim().isEmpty &&
          emailController.text.trim().isEmpty) {
        dummy.add(element);
      } else if ((nameController.text.trim().isEmpty ||
              element.name
                  .toLowerCase()
                  .contains(nameController.text.toLowerCase().trim())) &&
          (emailController.text.trim().isEmpty ||
              element.email
                  .toLowerCase()
                  .contains(emailController.text.toLowerCase().trim())) &&
          (idController.text.trim().isEmpty ||
              element.id.contains(idController.text.trim()))) {
        dummy.add(element);
      }
    }
    filteredResult = dummy;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(children: [
          const CabHeader(title: "Dashboard"),
          const Center(
            child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: CabText("Users", size: 30)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 108),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: SearchField(
                            controller: idController,
                            hintText: "Search By ID")),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: SearchField(
                            controller: nameController,
                            hintText: "Search By Name")),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: SearchField(
                            controller: emailController,
                            hintText: "Search By Email"))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryColor)),
                      onPressed: () {
                        filterData();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: CabText(
                          "Search",
                          color: Colors.black,
                          size: 17,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        nameController.clear();
                        emailController.clear();
                        idController.clear();
                        filterData();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: CabText(
                          "Clear",
                          color: Colors.white,
                          size: 17,
                          weight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          filteredResult == null
              ? const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : filteredResult!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(children: [
                        const Icon(Icons.info_outline,
                            size: 36, color: primaryColor),
                        const SizedBox(height: 12),
                        Text(
                            "No Users found ${(nameController.text.trim().isEmpty && idController.text.trim().isEmpty && emailController.text.trim().isEmpty) ? "" : "with search filter."}",
                            style: const TextStyle(
                                fontSize: 25, color: primaryColor)),
                      ]),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20),
                      itemCount: filteredResult!.length,
                      itemBuilder: (ctx, i) {
                        return UserTile(userModel: filteredResult![i]);
                      },
                    ),
        ]));
  }
}
