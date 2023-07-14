import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxitaxi_admin/helpers/style.dart';

import '../../helpers/methods.dart';
import '../../models/ride_fare_model.dart';
import '../../services/ride_fare_service.dart';
import '../cab_text.dart';
import '../cab_text_field.dart';

// ignore: must_be_immutable
class RideFareTile extends StatefulWidget {
  RideFare rideFare;
  int index;
  void Function(RideFare? newRideFare, int index, String type) func;
  RideFareTile({
    Key? key,
    required this.rideFare,
    required this.func,
    required this.index,
  }) : super(key: key);

  @override
  State<RideFareTile> createState() => _RideFareTileState();
}

class _RideFareTileState extends State<RideFareTile> {
  TextEditingController titleController = TextEditingController();
  TextEditingController fareController = TextEditingController();

  TextEditingController descController = TextEditingController();
  TextEditingController fixedFareController = TextEditingController();
  bool addMode = false;
  bool editMode = false;

  bool isActive = true;
  dynamic image;
  @override
  void initState() {
    if (widget.rideFare.image == null) {
      addMode = true;
    }
    isActive = widget.rideFare.isActive;
    image = widget.rideFare.image;
    titleController.text = widget.rideFare.name;
    fareController.text = widget.rideFare.farePerKm.toString();
    descController.text = widget.rideFare.desc;
    fixedFareController.text = widget.rideFare.fixedRate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Card(
        elevation: 2,
        child: ListTile(
          //  tilePadding: const EdgeInsets.only( left: 26),
          // onExpansionChanged: (val) {
          //   if (val == true) {
          //     animationController!.forward();
          //   } else {
          //     animationController!.reverse();
          //   }
          // },
          trailing: const SizedBox(),
          title: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 30, top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: image != null
                                  ? (image is XFile)
                                      ? Image.network(
                                          image!.path,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 180,
                                        )
                                      : ImageNetwork(
                                          image: image!,
                                          height: 100,
                                          width: 180)
                                  : Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                            height: 100,
                                            width: 180,
                                            child: InkWell(
                                              onTap: () async {
                                                image =
                                                    await getImageFromGallery();
                                                setState(() {});
                                              },
                                              child: const Icon(Icons.add,
                                                  size: 30,
                                                  color: primaryColor),
                                            )),
                                      ),
                                    ),
                            ),
                          ),
                          (addMode || editMode) && image != null
                              ? Positioned(
                                  right: 15,
                                  child: InkWell(
                                    onTap: () {
                                      image = null;
                                      setState(() {});
                                    },
                                    child: const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.delete,
                                            color: Colors.white)),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                addMode || editMode
                                    ? const SizedBox()
                                    : CabText(
                                        "Name: ",
                                        color: Colors.grey[700],
                                        size: 20,
                                        weight: FontWeight.w100,
                                      ),
                                addMode || editMode
                                    ? SizedBox(
                                        width: 300,
                                        child: CabTextField(
                                            controller: titleController,
                                            hintText: "Ride's Name",
                                            isPassword: false),
                                      )
                                    : CabText(
                                        widget.rideFare.name,
                                        color: const Color(0xFF000000),
                                        size: 22,
                                        weight: FontWeight.w100,
                                      ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                addMode || editMode
                                    ? const SizedBox()
                                    : CabText(
                                        "Desc: ",
                                        color: Colors.grey[700],
                                        size: 20,
                                        weight: FontWeight.w100,
                                      ),
                                addMode || editMode
                                    ? SizedBox(
                                        width: 300,
                                        child: CabTextField(
                                            controller: descController,
                                            hintText: "Description",
                                            isPassword: false),
                                      )
                                    : CabText(
                                        widget.rideFare.desc,
                                        color: const Color(0xFF000000),
                                        size: 22,
                                        weight: FontWeight.w100,
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        addMode || editMode
                                            ? const SizedBox()
                                            : CabText(
                                                "Fixed Fare: ",
                                                color: Colors.grey[700],
                                                size: 20,
                                                weight: FontWeight.w100,
                                              ),
                                        addMode || editMode
                                            ? SizedBox(
                                                width: 180,
                                                child: CabTextField(
                                                    inputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'^\d+\.?\d{0,2}')),
                                                    ],
                                                    controller:
                                                        fixedFareController,
                                                    hintText:
                                                        "Fixed Fare for 1 KM",
                                                    isPassword: false))
                                            : Flexible(
                                                child: CabText(
                                                  "₹ ${widget.rideFare.fixedRate}",
                                                  color:
                                                      const Color(0xFF000000),
                                                  size: 20,
                                                  weight: FontWeight.w100,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: 200,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          addMode || editMode
                                              ? const SizedBox()
                                              : CabText(
                                                  "Fare Per KM: ",
                                                  color: Colors.grey[700],
                                                  size: 20,
                                                  weight: FontWeight.w100,
                                                ),
                                          addMode || editMode
                                              ? SizedBox(
                                                  width: 180,
                                                  child: CabTextField(
                                                      inputFormatter: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^\d+\.?\d{0,2}')),
                                                      ],
                                                      controller:
                                                          fareController,
                                                      hintText: "Add Fare",
                                                      isPassword: false))
                                              : Flexible(
                                                  child: CabText(
                                                    "₹ ${widget.rideFare.farePerKm}",
                                                    color:
                                                        const Color(0xFF000000),
                                                    size: 20,
                                                    weight: FontWeight.w100,
                                                  ),
                                                ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue[700])),
                        onPressed: () async {
                          if (addMode || editMode) {
                            if (image == null ||
                                titleController.text.trim().isEmpty ||
                                fareController.text.trim().isEmpty ||
                                descController.text.trim().isEmpty ||
                                fixedFareController.text.trim().isEmpty) {
                            } else {
                              if (editMode) {
                                await RideFareService()
                                    .editRideFare(
                                        rideFareId: widget.rideFare.id!,
                                        image: image,
                                        name: titleController.text.trim(),
                                        isActive: isActive,
                                        context: context,
                                        fare: double.parse(fareController.text),
                                        desc: descController.text.trim(),
                                        fixedFare: double.parse(
                                            fixedFareController.text))
                                    .then((value) {
                                  if (value != null) {
                                    widget.func(
                                        RideFare(
                                          farePerKm:
                                              double.parse(fareController.text),
                                          id: value,
                                          desc: descController.text.trim(),
                                          fixedRate: double.parse(
                                              fixedFareController.text),
                                          name: titleController.text.trim(),
                                          image: image,
                                          isActive: isActive,
                                        ),
                                        widget.index,
                                        "edit");
                                    setState(() {
                                      editMode = false;
                                    });
                                  }
                                });
                              } else {
                                await RideFareService()
                                    .addRideFare(
                                        image: image,
                                        name: titleController.text.trim(),
                                        context: context,
                                        desc: descController.text.trim(),
                                        fixedFare: double.parse(
                                            fixedFareController.text),
                                        fare: double.parse(fareController.text))
                                    .then((value) {
                                  if (value is Map) {
                                    widget.func(
                                        RideFare(
                                            farePerKm: double.parse(
                                                fareController.text),
                                            id: value['id'],
                                            desc: descController.text.trim(),
                                            fixedRate: double.parse(
                                                fixedFareController.text),
                                            name: titleController.text.trim(),
                                            image: image,
                                            isActive: true),
                                        widget.index,
                                        "add");
                                    setState(() {
                                      addMode = false;
                                    });
                                  }
                                });
                              }
                            }
                          } else {
                            setState(() {
                              editMode = true;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 2),
                          child: Row(
                            children: [
                              Icon(
                                  addMode || editMode ? Icons.done : Icons.edit,
                                  color: Colors.white),
                              const SizedBox(width: 6),
                              CabText(
                                addMode || editMode ? "Save" : "Edit",
                                color: Colors.white,
                                size: 16,
                                weight: FontWeight.w100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      addMode || editMode
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () async {
                                if (addMode) {
                                  widget.func(null, widget.index, "cancel");
                                  setState(() {
                                    addMode = false;
                                  });
                                } else if (editMode) {
                                  setState(() {
                                    editMode = false;
                                    image = widget.rideFare.image;
                                    titleController.text = widget.rideFare.name;
                                    fareController.text =
                                        widget.rideFare.farePerKm.toString();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 2),
                                child: Row(
                                  children: const [
                                    Icon(Icons.close, color: Colors.white),
                                    SizedBox(width: 6),
                                    CabText(
                                      "Cancel",
                                      color: Colors.white,
                                      size: 16,
                                      weight: FontWeight.w100,
                                    ),
                                  ],
                                ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 2),
                              child: CupertinoSwitch(
                                // This bool value toggles the switch.
                                value: widget.rideFare.isActive,
                                thumbColor: widget.rideFare.isActive
                                    ? CupertinoColors.systemGreen
                                    : CupertinoColors.systemRed,
                                trackColor:
                                    CupertinoColors.systemRed.withOpacity(0.34),
                                activeColor: CupertinoColors.systemGreen
                                    .withOpacity(0.34),
                                onChanged: (bool? value) async {
                                  setState(() {
                                    isActive = value!;
                                  });
                                  await RideFareService()
                                      .editRideFare(
                                          rideFareId: widget.rideFare.id!,
                                          name: titleController.text.trim(),
                                          isActive: isActive,
                                          context: context,
                                          desc: descController.text.trim(),
                                          fixedFare: double.parse(
                                              fixedFareController.text),
                                          fare:
                                              double.parse(fareController.text))
                                      .then((value) {
                                    if (value != null) {
                                      widget.func(
                                          RideFare(
                                              farePerKm: double.parse(
                                                  fareController.text),
                                              id: value,
                                              desc: descController.text.trim(),
                                              fixedRate: double.parse(
                                                  fixedFareController.text),
                                              name: titleController.text.trim(),
                                              image: image,
                                              isActive: isActive),
                                          widget.index,
                                          "edit");
                                      setState(() {
                                        editMode = false;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
