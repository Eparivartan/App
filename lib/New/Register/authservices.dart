import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _isWaitingForOtp = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> verifyPhoneNumber() async {
    if (_isWaitingForOtp) {
      print('Please wait before requesting another OTP.');
      return;
    }

    setState(() {
      _isWaitingForOtp = true;
    });

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final phoneNumber = '+91${_phoneController.text.trim()}';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('Verification completed: ${credential.smsCode}');
          // Sign in the user automatically if verification is completed.
          await _auth.signInWithCredential(credential);
          setState(() {
            _isWaitingForOtp = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          setState(() {
            _isWaitingForOtp = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Code sent to $phoneNumber');
          setState(() {
            this._verificationId = verificationId;
            _isWaitingForOtp = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto-retrieval timeout');
          setState(() {
            this._verificationId = verificationId;
            _isWaitingForOtp = false;
          });
        },
      );
    } catch (e) {
      print('Error during phone number verification: $e');
      setState(() {
        _isWaitingForOtp = false;
      });
    }
  }

  Future<void> signInWithPhoneNumber() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final otp = _otpController.text.trim();

    if (_verificationId == null || otp.isEmpty) {
      print('No verification ID available or OTP is empty');
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      print('Successfully signed in');
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('Sending OTP...');
                await verifyPhoneNumber();
              },
              child: Text('Send OTP'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('Verifying OTP...');
                await signInWithPhoneNumber();
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
