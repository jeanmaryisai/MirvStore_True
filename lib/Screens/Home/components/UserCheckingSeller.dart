import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/components/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class UserInformationDialog extends StatefulWidget {
  @override
  _UserInformationDialogState createState() => _UserInformationDialogState();
}

class _UserInformationDialogState extends State<UserInformationDialog> {
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
              try {
                _sendVerificationEmail();
                Navigator.of(context).pop();
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Email Sending Failed'),
                      content: Text(
                          'Sorry, we were unable to send the email. Please try again later.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
        ),
      ],
    );
  }

  void _sendVerificationEmail() async {
    // Compose the email message
    final message = Message()
      ..from = Address('isaitest334@gmail.com', 'Your Name')
      ..recipients.add('jeanmaryisai@gmail.com')
      ..subject = 'User Verification Request'
      ..text =
          'A user has requested verification.\n\nTelephone: ${_telephoneController.text}\nEmail: ${_emailController.text}\nFirst Name: ${_firstNameController.text}\nLast Name: ${_lastNameController.text}';

    try {
      // Configure the SMTP server settings

      final smtpServer = SmtpServer(
        'smtp.gmail.com',
        username: 'isaitest334@gmail.com',
        password: 'mgotweqrwrtmvsfo',
        port: 587,
        ssl: false,
        // tls: true
      );

      // Send the email
      Navigator.of(context).pop();
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(msg: 'Congratulations! The email has been sent successfully. We will contact you soon');
      currentUser.isSeller = null;
      // print('Email sent: ${sendReport.mail.html}');
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Email Sent'),
      //       content: Text(
      //           'Congratulations! The email has been sent successfully. We will contact you soon'),
      //       actions: [
      //         TextButton(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    } on MailerException catch (e) {
      print('Sending failed: ${e.toString()}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Sending Failed'),
            content: Text(
                'Sorry, we were unable to send the email. Please try again later.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // Navigate to the home page or perform any other desired action
    Navigator.of(context).pop();
    // Navigate to home page example:
    // Navigator.pushReplacementNamed(context, '/home');
  }
}

// Usage example:
void showUserInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserInformationDialog();
    },
  );
}
