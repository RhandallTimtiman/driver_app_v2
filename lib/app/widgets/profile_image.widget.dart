import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  final String tag;
  final String imgUrl;

  const ProfileImage({Key? key, required this.tag, required this.imgUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height / 3,
      child: Stack(
        children: [
          Hero(
            tag: tag,
            child: SizedBox(
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                errorWidget: (context, url, error) => Image.asset(
                  "assets/icons/error_user_image.png",
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black54,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: 10,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    100.0,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    100.0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 166, 227, 1),
                      ),
                    ),
                    Container(
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 185, 0, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
