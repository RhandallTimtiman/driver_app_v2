import 'package:flutter/material.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:get/get.dart';

class TripListModal extends StatelessWidget {
  final String title;

  final bool showAcceptAll;

  final String status;

  const TripListModal({
    Key? key,
    this.title = '',
    this.showAcceptAll = false,
    this.status = 'PEN',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 1.0,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 10,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    showAcceptAll
                        ? Positioned(
                            top: -8,
                            right: 10,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: MaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                color: const Color.fromRGBO(0, 166, 227, 1),
                                minWidth: 0,
                                height: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  'accept_all_label'.tr,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 110,
                  // child: ModalTripList(
                  //   status: status,
                  // ),
                  child: const TripList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
