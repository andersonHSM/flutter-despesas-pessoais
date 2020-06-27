import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(
      title,
      value,
      _selectedDate,
    ); // recebido como herança da classe stateful com as propriedades
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  get _cupertinoDatePicker {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      minimumYear: 2019,
      maximumYear: DateTime.now().year,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _themeOf = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10.0 + _mediaQuery.viewInsets.bottom,
            ),
            child: Column(
              children: <Widget>[
                Platform.isIOS
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CupertinoTextField(
                          padding: EdgeInsets.all(10),
                          controller: _titleController,
                          placeholder: 'Título',
                        ),
                      )
                    : TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Título'),
                      ),
                Platform.isIOS
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CupertinoTextField(
                          padding: EdgeInsets.all(10),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: _valueController,
                          placeholder: 'Valor (R\$)',
                          onSubmitted: (_) => _submitForm(),
                        ),
                      )
                    : TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        controller: _valueController,
                        decoration: InputDecoration(labelText: 'Valor (R\$)'),
                        onSubmitted: (_) => _submitForm(),
                      ),
                Container(
                  height: _mediaQuery.size.height * 0.2,
                  child: Platform.isIOS
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: _mediaQuery.size.width * 0.9,
                              child: _cupertinoDatePicker,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _selectedDate == null
                                  ? 'Nenhuma data selecionada!'
                                  : DateFormat('d MMM y').format(_selectedDate),
                            ),
                            FlatButton(
                              textColor: _themeOf.primaryColor,
                              onPressed: _showDatePicker,
                              child: Text(
                                'Selecionar Data',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                        color: _themeOf.primaryColor,
                        onPressed: _submitForm,
                        child: Text('Nova Transação'),
                        textColor: _themeOf.textTheme.button.color),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
