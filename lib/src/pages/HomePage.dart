



import 'package:alerbox_textfiled/src/pages/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'demo.dart';

class Calenda extends StatefulWidget {

  const Calenda({super.key});

  @override
  State<Calenda> createState() => _CalendaState();
}

class _CalendaState extends State<Calenda> {
  List<Map> Event =[



  ];
  DateTime today = DateTime.now();


  final titleController =TextEditingController();
  final descpController =TextEditingController();
  final dateController =TextEditingController();


  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {

      today = day;
      dateController.text='${today}';
    });
  }
  _showAddEventDialog() async{
    await showDialog(
        context: context,
        builder: (context)=>AlertDialog(

          title:  const Text(
            "Add New Event",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Title",
                      suffixIcon: IconButton(onPressed: () {
                        titleController.clear();
                      },
                          icon: Icon(Icons.cancel))
                  ),
                ),
                TextField(
                  controller: dateController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: IconButton(onPressed: () {
                        dateController.clear();
                      },
                          icon: Icon(Icons.cancel))
                  ),
                ),


                TextField(
                  controller: descpController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Description",
                      suffixIcon: IconButton(onPressed: () {
                        descpController.clear();
                      },
                          icon: Icon(Icons.cancel))
                  ),
                ),

              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () async {
              if(titleController.text.isEmpty &&
                  descpController.text.isEmpty)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Requird title and description"),
                    duration: Duration(seconds: 2),),);
                return;
              }else{
                final Eevents= await <String,dynamic>{
                  "name":titleController.text,
                  "test":descpController.text,
                  "date":dateController.text,
                };
                Event.add(Eevents);
                Navigator.pop(context);
                // print(titleController.text);
                // print(descpController.text);
                // addDetails(titleController.text, descpController.text);
                // setState(() {
                //   titleController.text='';titleController.text='';
                //
                // });
                // print(
                //     "New Event for backend developer${
                //         json.encode(mySelectedEvents)}");
              }},
              child: Text("Submit"),),


            TextButton(onPressed: ()=>Navigator.pop(context),
                child: Text("Cancel")),
          ],
        ));

  }



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00CECE),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text( "today date"+ today.toString().split("")[0]),
            TableCalendar(
                calendarStyle:CalendarStyle(

                  todayTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),
                  todayDecoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                      color: Color(0xff00CECE)
                  ),


                  defaultTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),
                  defaultDecoration:  ShapeDecoration(shape: OutlineInputBorder(gapPadding: 0.4,
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black,width: 2))),


                  selectedTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),
                  selectedDecoration:ShapeDecoration(shape: OutlineInputBorder(gapPadding: 0.4,
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Color(0xff00CECE),width: 2))),


                  weekendTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),
                  weekendDecoration: ShapeDecoration(shape: OutlineInputBorder(gapPadding: 0.4,
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black,width: 2))),

                  outsideTextStyle: TextStyle(color: Colors.black12,fontWeight: FontWeight.w700,fontSize: 16),
                  outsideDecoration: ShapeDecoration(shape: OutlineInputBorder(gapPadding: 0.4,
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black12,width: 2))),

                ) ,
                locale: "en_US",

                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Color(0xff324B4B),
                      fontSize: 16,fontWeight: FontWeight.w700),
                  weekendStyle:  TextStyle(color: Color(0xff324B4B),
                      fontSize: 16,fontWeight: FontWeight.w700),
                ),

                // rowHeight: 55,
                headerStyle: HeaderStyle(headerMargin: const EdgeInsets.only(right: 130,left: 130, top:15,bottom: 15),
                  decoration: BoxDecoration(
                      color: Color(0xff324B4B),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  // color: Colors.deepOrangeAccent,

                  formatButtonDecoration:BoxDecoration(
                      color: Color(0xff324B4B),
                      borderRadius: BorderRadius.circular(24)
                  ) ,
                  headerPadding: EdgeInsets.all(12),
                  rightChevronVisible: false,
                  leftChevronVisible: false,
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                  ),

                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day)=>isSameDay(day,today),
                focusedDay:today ,
                firstDay: DateTime.utc(2010,10,13),
                lastDay: DateTime.utc(2030,11,20),
                onDaySelected:_onDaySelected),

            SizedBox(height: 30),


          Container(
            height:  MediaQuery.of(context).size.height,
            // color: Colors.yellow,
            child: Expanded(child:ListView.builder(
              itemCount: Event.length,
                itemBuilder: (context, index) {
                  return
                      Card(

                        // margin: EdgeInsets.all(10),
                        shape: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff95B1B0),width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        // color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(Event[index]["name"],
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 16,fontWeight: FontWeight.w700),),

                                          Text(Event[index]["date"],
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 11,fontWeight: FontWeight.w400),),

                                          Text(Event[index]["test"],
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,fontWeight: FontWeight.w400),),

                            ],
                          ),
                        ),
                      );
                },)),
          ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){ _showAddEventDialog();},
        label: Text("Event"),backgroundColor: Color(0xff00CECE),),

    );
  }
}

