import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxitaxi_admin/helpers/style.dart';

import '../helpers/animated_spinner.dart';

import '../helpers/constants.dart';
import '../services/admin_service.dart';
import '../widgets/cab_text.dart';
import '../widgets/tiles/home_tile.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Map count = {};
  // List<Order>? orders;
  // List<UserModel>? users;

  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    init();
    super.initState();
  }

  Future init() async {
    count.clear();
    count = await AdminService().fetchCount();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 1),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://upwork-usw2-prod-assets-static.s3.us-west-2.amazonaws.com/org-logo/1084860007191973888"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const CabText('Welcome,\nProvis Technologies',
                              size: 17, color: Colors.black),
                        ],
                      ),
                    ),
                    Hero(
                        tag: "logo-shift",
                        child: Image.asset(
                          "assets/logo-tb.png",
                          height: 120,
                          width: 160,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 115, right: 20),
                        child: InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            await prefs.remove(authPref);
                            await prefs.setBool(loggedInPref, false);

                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.black),
                              SizedBox(width: 20),
                              CabText('Logout', size: 16, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CabText("Dashboard", size: 30),
                  const SizedBox(width: 20),
                  SpinningIconButton(
                    controller: animationController!,
                    iconData: Icons.refresh_rounded,
                    onPressed: () async {
                      animationController!.repeat();

                      await init();

                      animationController!
                          .forward(from: animationController!.value);
                    },
                  )
                ],
              )),
          // orders != null || users != null
          //     ? Padding(
          //         padding: const EdgeInsets.only(right: 80, left: 80, top: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             orders == null || orders!.isEmpty
          //                 ? const SizedBox()
          //                 : Card(
          //                     elevation: 8,
          //                     child: SizedBox(
          //                         width: 540,
          //                         child: Column(
          //                           children: [
          //                             SizedBox(
          //                                 height: 360,
          //                                 child: HomeOrderChart(
          //                                     orderList: orders!)),
          //                             const SizedBox(height: 10),
          //                             const CabText("Order Summary"),
          //                             const SizedBox(height: 30)
          //                           ],
          //                         ))),
          //             Card(
          //                 elevation: 8,
          //                 child: SizedBox(
          //                     width: 540,
          //                     child: Column(
          //                       children: [
          //                         SizedBox(
          //                             height: 360,
          //                             child: HomeUserChart(users: users!)),
          //                         const SizedBox(height: 10),
          //                         const CabText("Users Summary"),
          //                         const SizedBox(height: 30)
          //                       ],
          //                     ))),
          //           ],
          //         ),
          //       )
          //     : const SizedBox(height: 420),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            itemCount: homeSections.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 180, crossAxisCount: 2),
            itemBuilder: (ctx, i) {
              return HomeTile(tileData: homeSections[i], countMap: count);
            },
          ),
        ]));
  }
}
