import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // String titleInput;
  // String amountInput;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }

    widget.addTx(
        enteredTitle,
        enteredAmount,
      _selectedDate,
    );
    
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitData,
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(decoration: InputDecoration(labelText: 'Price'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(child: Text(_selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate)}',)),
                FlatButton(textColor: Theme.of(context).primaryColor,onPressed: _presentDatePicker,
                  child: Text('Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),),
              ],),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              child: Text('Add Transaction'), onPressed: _submitData, textColor: Theme.of(context).primaryColorLight,)
          ],
        ),
      ),
    );
  }
}