import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../components/data.dart';
import '../../models/message.dart';
import '../../models/trade.dart';
import '../../utils.dart';
// import '../Home/HomeScreen.dart';

class ChatBubble extends StatefulWidget {
  final Message msg;
  final VoidCallback refresh;
  final String chatid;

  const ChatBubble({super.key, required this.msg, required this.refresh,
  required this.chatid
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  List colors = Colors.primaries;
  static Random random = Random();
  int rNum = random.nextInt(18);

  Color? chatBubbleColor() {
    if (widget.msg.isMe()) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.grey[800];
      } else {
        return Colors.grey[200];
      }
    }
  }

  // Color? chatBubbleReplyColor() {
  //   if (Theme.of(context).brightness == Brightness.dark) {
  //     return Colors.grey[600];
  //   } else {
  //     return Colors.grey[50];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final align =
        widget.msg.isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = BorderRadius.circular(25);

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        !widget.msg.isTrade()
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: chatBubbleColor(),
                      borderRadius: radius,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.3,
                      minWidth: 20.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        widget.msg.isMe()
                            ? SizedBox()
                            :

                            SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child:
                                Text(
                              widget.msg.message,
                              style: TextStyle(
                                color: widget.msg.isMe()
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .color,
                              ),
                                )
                            ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: widget.msg.isMe()
                        ? EdgeInsets.only(right: 10, bottom: 10.0)
                        : EdgeInsets.only(left: 10, bottom: 10.0),
                    child: Text(
                      widget.msg.timeAgo(),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ],
              )
            : PriceCard(
                trade: trades.firstWhere((element) => element.myId ==widget.msg.trade)!,
                color: chatBubbleColor(),
                onAccept: () {},
                onNewPropose: (propose) {newTrade(propose, widget.chatid, trades.firstWhere((element) => element.myId ==widget.msg.trade)!);},
                onDecline: () {},
                time: widget.msg.timeAgo(),
                isMe: widget.msg.isMe(),
                refresh: widget.refresh),
      ],
    );
  }
}

class PriceCard extends StatefulWidget {
  final Trade trade;
  final void Function() onAccept;
  final void Function() onDecline;
  final void Function(double) onNewPropose;
  final Color? color;
  final bool? isMe;
  final String? time;
  final VoidCallback refresh;

  PriceCard(
      {this.color,
      required this.trade,
      required this.onAccept,
      required this.onDecline,
      required this.onNewPropose,
      this.isMe,
      this.time,
      required this.refresh});

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  @override
  Widget build(BuildContext context) {
    double newPrice = widget.trade.amout;

    return Column(
      crossAxisAlignment:
          widget.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(25),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: NegociationCard(trade: widget.trade, refresh: widget.refresh,onNewPropose:widget.onNewPropose),
        ),
        Padding(
          padding: widget.isMe!
              ? EdgeInsets.only(right: 10, bottom: 10.0)
              : EdgeInsets.only(left: 10, bottom: 10.0),
          child: Text(
            widget.time!,
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6!.color,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}

class DisabledButton extends StatelessWidget {
  final String buttonText;

  const DisabledButton({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        // Add more customizations as needed
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white, // Customize text color
        ),
      ),
    );
  }
}

class NegociationCard extends StatefulWidget {
  final Trade trade;
  final VoidCallback refresh;
  final void Function(double) onNewPropose;
  const NegociationCard(
      {super.key, required this.trade, required this.refresh, required this.onNewPropose});

  @override
  _NegociationCardState createState() => _NegociationCardState();
}

class _NegociationCardState extends State<NegociationCard> {
  @override
  Widget build(BuildContext context) {
    double _newPrice = widget.trade.amout;
    bool cc = widget.trade.isAccepted ?? false;

    // TODO: implement build

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: Text(
                "Negociation ${users.firstWhere((element) => element.myId ==widget.trade.sender).username}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                products.firstWhere((element) => element.myId ==widget.trade.product).image,
                height: 130,
                width: MediaQuery.of(context).size.width / 1.3,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      products.firstWhere((element) => element.myId ==widget.trade.product).description,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color,
                        fontSize: 10.0,
                      ),
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child: Text(
                      products.firstWhere((element) => element.myId ==widget.trade.product).isAvailable
                          ? !products.firstWhere((element) => element.myId ==widget.trade.product).isSold
                              ? widget.trade.isAccepted == null
                                  ? 'I am not satisfied with the current proposed price, I am proposing a new one'
                                  : widget.trade.isAccepted!
                                      ? widget.trade.buyer == currentUser.myId
                                          ? 'this trade has been aggreed on both side please proceed to the checking and confirmation phase'
                                          : 'this trade has been aggreed on both side waiting for the checking and confirmation phase'
                                      : 'This trade has been declined'
                              : 'The product has benn Sold'
                          : 'This product is currently unavailable',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              // 'Price: \$${widget.pr.toStringAsFixed(2)}',
              'Price: \$${widget.trade.amout.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 16),
            widget.trade.sender == currentUser.myId
                ? Text(
                    // 'Price: \$${widget.pr.toStringAsFixed(2)}',
                    'Trade sent',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                  )
                : cc &&
                        !products.firstWhere((element) => element.myId ==widget.trade.product).isSold &&
                products.firstWhere((element) => element.myId ==widget.trade.product).isAvailable
                    ? products.firstWhere((element) => element.myId ==widget.trade.product).owner == currentUser.myId
                        ? Text(
                            // 'Price: \$${widget.pr.toStringAsFixed(2)}',
                            'Waiting for check',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              showCheckingInfo(context,users.firstWhere((element) => element.myId ==products.firstWhere((element) => element.myId== widget.trade.product).owner).address,widget.trade.myId);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Proceed to check',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                    : Column(children: [
                        isTradeUnactive(widget.trade.myId)
                            ? DisabledButton(
                                buttonText: 'Accept',
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  confirmTrade(widget.trade.myId, true);
                                  widget.refresh;
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                        SizedBox(height: 8),
                        isTradeUnactive(widget.trade.myId)
                            ? DisabledButton(
                                buttonText: 'Decline',
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  confirmTrade(widget.trade.myId, false);
                                  widget.refresh;
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Decline',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                        SizedBox(height: 16),
                        isTradeUnactive(widget.trade.myId)
                            ? SizedBox()
                            : Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _newPrice = double.tryParse(value) ??
                                          widget.trade.amout;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'New Price',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      // newTrade(
                                      //   _newPrice,widget.chat,trade,
                                      // );
                                      widget.onNewPropose(_newPrice);
                                      // // showCommentDialog(context);
                                      // widget.refresh;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.secondary,
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Icon(Icons.send),
                                  ),
                                ],
                              ),
                      ]),
          ],
        ),
      ),
    );
  }
}

class UserInformationDialog2 extends StatefulWidget {
  final String address;
  final String tradeId;

  const UserInformationDialog2({super.key, required this.address, required this.tradeId});
  @override
  _UserInformationDialog2State createState() => _UserInformationDialog2State();
}

class _UserInformationDialog2State extends State<UserInformationDialog2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _telephoneController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Your informations'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _telephoneController,
              decoration: InputDecoration(
                labelText: 'Telephone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your telephone number';
                }
                // Add custom telephone number validation if needed
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your first name';
                }
                // Add custom first name validation if needed
                return null;
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your last name';
                }
                // Add custom last name validation if needed
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Valid form, proceed with sending the email
              Navigator.of(context).pop();
             tradeConfirm(widget.tradeId,context,widget.address);
             // updateChat(widget., message)
              }
            }

        ),
      ],
    );
  }


}

// Usage example:
void showCheckingInfo(BuildContext context,String address,String tradeId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserInformationDialog2(address: address,tradeId: tradeId,);
    },
  );
}