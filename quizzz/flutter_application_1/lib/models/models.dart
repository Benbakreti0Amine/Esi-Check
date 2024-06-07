

class Question {
  
  String id;
  String moduleName;
  String question;
  Map<String, dynamic> propositions;
  String correctAnswer;
  String selectedAnswer;
  int time;
  
 // String imageUrl;
  Question({
    required this.id,
    required this.question,
    required this.moduleName,
    required this.propositions,
    required this.correctAnswer,
   // required this.imageUrl,
    required this.selectedAnswer,
    required this.time
  }) ; // initialize startTime to current time

  factory Question.fromJson(json) {
    return Question(
      id: json['id'],
      moduleName: json['moduleName'],
      propositions: json['propositions'],
      correctAnswer: json['correctAnswer'],
     // imageUrl: json['imageUrl'],
      question: json['question'],
      selectedAnswer: json['selectedAnswer'],
      time:json['time']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleName': moduleName,
      'question': question,
      'propositions': propositions,
      'correctAnswer': correctAnswer,
      //'imageUrl': imageUrl,
      'selectedAnswer': selectedAnswer,
      'time':time,
      
    };
  }
}



