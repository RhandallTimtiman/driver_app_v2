import 'package:flutter/material.dart';
import 'package:driver_app/app/widgets/widgets.dart';

class MessageDetailsScreen extends StatefulWidget {
  const MessageDetailsScreen({Key? key}) : super(key: key);

  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar = MainAppBar(
      onBackPress: () => Navigator.of(context).pop(),
      title: const Text(
        'TR-100001',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      showOnlineButton: false,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Stack(
            children: [
              const ChatBody(),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: MessageInput(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 150,
          ),
          child: ListView.builder(
            reverse: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Chat(
                isRecipient: index % 2 == 1 ? true : false,
                showDate: index == 18 || index == 10,
              );
            },
          ),
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  final bool isRecipient;
  final bool showDate;

  const Chat({Key? key, this.isRecipient = true, this.showDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          showDate
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'Yesterday, 7:43 am',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Row(
            mainAxisAlignment:
                isRecipient ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 70,
                ),
                width: MediaQuery.of(context).size.width * .80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: isRecipient ? Colors.grey[600] : Colors.blue,
                ),
                child: const Text(
                  'Lorem Ipsum Dolor Lorem Ipsum Dolor,  ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
