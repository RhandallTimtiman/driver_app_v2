import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Function? onMenuPress;
  final Function? onBackPress;
  final bool showOnlineButton;

  const MainAppBar({
    Key? key,
    this.title,
    this.onMenuPress,
    this.onBackPress,
    this.showOnlineButton = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: const Color.fromRGBO(
        247,
        247,
        250,
        1,
      ),
      title: title,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => onMenuPress != null ? onMenuPress!() : onBackPress!(),
        child: onMenuPress != null
            ? const Center(
                child: Image(
                  image: AssetImage('assets/icons/menu.png'),
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                ),
              )
            : const Icon(
                Icons.arrow_back,
                color: Colors.black, // add custom icons also
              ),
      ),
      actions: [
        // showOnlineButton
        //     ? Container(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: 10,
        //         ),
        //         child: Obx(
        //           () => Center(
        //             child: GestureDetector(
        //               onTap: () {
        //                 appBarController.toggleOnlineStatus();
        //               },
        //               child: AnimatedContainer(
        //                 duration: Duration(milliseconds: 1000),
        //                 height: 25,
        //                 width: 45,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(20.0),
        //                   color: statusController.status.value
        //                       ? Colors.grey[300]
        //                       : Colors.grey[500],
        //                 ),
        //                 child: Stack(
        //                   children: [
        //                     AnimatedPositioned(
        //                       child: statusController.status.value
        //                           ? CircleAvatar(
        //                               backgroundColor: Colors.green[600],
        //                               radius: 13,
        //                               child: CircleAvatar(
        //                                 backgroundColor: Colors.green,
        //                                 radius: 10,
        //                               ),
        //                             )
        //                           : CircleAvatar(
        //                               backgroundColor: Colors.grey[600],
        //                               radius: 13,
        //                               child: CircleAvatar(
        //                                 backgroundColor: Colors.grey[700],
        //                                 radius: 10,
        //                               ),
        //                             ),
        //                       duration: Duration(milliseconds: 300),
        //                       curve: Curves.easeIn,
        //                       top: 0,
        //                       left: statusController.status.value ? 20 : 0,
        //                       right: statusController.status.value ? 0 : 20,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     : SizedBox.shrink(),
      ],
    );
  }
}
