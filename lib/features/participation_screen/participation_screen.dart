// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/features/participation_screen/blocs/participation_bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticipationScreen extends StatefulWidget {
  const ParticipationScreen({super.key, required this.order});
  final OrderModel order;

  @override
  State<ParticipationScreen> createState() => _ParticipationScreenState();
}

class _ParticipationScreenState extends State<ParticipationScreen> {
  late OrderModel order;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatModel> messages = [];
  ConnectToPusher pusher = ConnectToPusher();

  @override
  void initState() {
    setState(() {
      order = widget.order;
    });
    super.initState();
    prepare();
  }

  void prepare() {
    pusher.pusher.subscribe(
        channelName: 'private-send-message.${order.driver.id}',
        onEvent: (event) {
          var ans = jsonDecode(event.data);
          setState(() {
            messages.add(ChatModel(
                id: -1,
                message: ans['message'],
                orderId: order.id.toString(),
                createdAt: DateTime.now().toIso8601String()));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          order.user.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
            child: BlocListener<ParticipationBloc, ParticipationState>(
          listener: (context, state) {
            if (state is GetMessageListSuccess) {
              setState(() {
                messages = state.chats;
              });
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        bool isMe = message.senderId.toString() ==
                            order.driver.id.toString();
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.green : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message.message.toString(),
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: 'Nhập tin nhắn...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (_messageController.text.isEmpty) return;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          messages.add(ChatModel(
                              id: -1,
                              message: _messageController.text,
                              orderId: order.id.toString(),
                              createdAt: DateTime.now().toIso8601String(),
                              senderId: order.driver.id.toString()));
                        });

                        context.read<ParticipationBloc>().add(SendMessage(
                            guard: 'driver',
                            message: _messageController.text,
                            orderId: order.id.toString(),
                            serverKey: prefs.getString('serverKey')!));
                        _messageController.clear();

                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
