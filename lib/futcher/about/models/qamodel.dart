import 'package:flutter/material.dart';
 class QAmodel{
   String questionText;
   String answerText;
   bool isExpanded;
   QAmodel({required this.questionText,required this.answerText, this.isExpanded = false});
 }