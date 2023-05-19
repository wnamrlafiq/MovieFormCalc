import 'package:flutter/material.dart';
import 'package:labwork2/display.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie Form',
      theme: ThemeData(brightness: Brightness.dark),
      home: const FormPage(title: 'Flutter Movie Form Page'),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), child: MovieForm()),
    );
  }
}

class MovieForm extends StatefulWidget {
  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _movie = 'Avengers (RM20)';
  int _selectedGender = 0;
  int _quantity = 0;
  bool _termsChecked = true;
  int price = 0;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value.toString();
        });
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Avenger (RM20)'),
          value: 'Avenger (RM20)',
          groupValue: _movie,
          onChanged: (value) {
            setState(() {
              _movie = value.toString();
              price = 20;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Batman (RM10)'),
          value: 'Batman (RM10)',
          groupValue: _movie,
          onChanged: (value) {
            setState(() {
              _movie = value.toString();
              price = 10;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Kimenitsu no yoiba (RM12)'),
          value: 'Kimenitsu no yoiba (RM12)',
          groupValue: _movie,
          onChanged: (value) {
            setState(() {
              _movie = value.toString();
              price = 12;
            });
          },
        ),
      ],
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Quantity', hintText: 'Quantity'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a number';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _quantity = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState?.save();

        String gender = '';
        switch (_selectedGender) {
          case 0:
            gender = "Male";
            break;
          case 1:
            gender = "Female";
            break;
          case 3:
            gender = "Others";
            break;
        }

        String name = _name;
        String email = _email;
        String movie = _movie;
        int quantity = _quantity;
        int total = price * _quantity;

        
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Display(
                  name: name,
                  email: email,
                  gender: gender,
                  movie: movie,
                  quantity: quantity,
                  total: total),
            ));
      }
    }

    formWidget.add(ElevatedButton(
        onPressed: onPressedSubmit, child: const Text('Calculate')));

    return formWidget;
  }
}
