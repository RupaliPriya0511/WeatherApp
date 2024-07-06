import 'package:flutter/material.dart'; 
import 'homepage.dart';  



class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container( 
        color: Colors.blue, 
        child: Center(
          child: Column( // Column widget to arrange its children widgets vertically
            mainAxisAlignment: MainAxisAlignment.center, // Centering the column contents vertically
            children: [
              Image.asset('assets/logo.png'), 
              const SizedBox(height: 25), 
              ElevatedButton( 
                onPressed: () async { // When the button is pressed
                  Navigator.pushReplacement( // Navigates to the homepage and replaces this screen
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()), 
                  );
                },
                child: const Text('START'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

















