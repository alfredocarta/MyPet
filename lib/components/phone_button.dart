import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberButton extends StatelessWidget {

  final String phoneNumber;

  const PhoneNumberButton({
    super.key, 
    required this.phoneNumber,
  });

  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _launchPhoneCall(phoneNumber),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black), 
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(double.infinity, 60), // Altezza del bottone
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: Colors.grey, width: 0.5), // Definisci il bordo nero
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 8),
                  Text(
                    phoneNumber,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}