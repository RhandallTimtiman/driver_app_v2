import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  final bool isFinal;

  final NotificationModel notification;

  final int index;

  final Function updateNotification;

  const NotificationItem({
    Key? key,
    required this.isFinal,
    required this.notification,
    required this.index,
    required this.updateNotification,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _showMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _showMore = !_showMore;
              });

              if (!widget.notification.isRead) {
                widget.updateNotification(
                  widget.index,
                  widget.notification.driverNotificationsId,
                );
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.notifications,
                  color: Colors.black45,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Wrap(
                      children: [
                        Text(
                          widget.notification.notificationTypeId +
                              ' ' +
                              widget.notification.senderName +
                              ' ' +
                              '-' +
                              ' ' +
                              widget.notification.serviceTicketId,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.notification.message,
                          maxLines: _showMore ? 100 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.notification.isRead == false
                            ? Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.pinkAccent,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.notification.createdDate,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Text(
                            _showMore ? 'View Less' : 'View More',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            _showMore ? Icons.expand_less : Icons.expand_more,
                            size: 12,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          !widget.isFinal
              ? const Divider(
                  color: Colors.black26,
                  thickness: 1,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
