import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachedPhotos extends StatelessWidget {
  const AttachedPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Photos',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_left,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<RouteCompletionController>(
                    builder: (_) {
                      var imageList = _.docs.value.imageList;
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var i = 0; i < imageList!.length; i++)
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: EdgeInsets.zero,
                                    color: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(minWidth: 200),
                                        child: Image.file(
                                          imageList[i],
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      _.removeImage(imageList[i]);
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const Icon(Icons.arrow_right),
            ],
          )
        ],
      ),
    );
  }
}
