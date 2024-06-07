class GraphQl {
  static const getQuizByUserID = """
    query Query(\$getQuizByIdId: ID!) {
  getQuizByID(id: \$getQuizByIdId) {
    correctAnswer
    createdAt
    id
    moduleName
    propositions
    question
    selectedAnswer
    time
  }
}

""";
  static const String getPropositionsById = """
query Quiz(\$quizId: ID!) {
  quiz(id: \$quizId) {
    propositions
  }
}
  """;
  static const String getCorrectIncorrectAnswer = """
  query GetReponsebyuserId(\$userid: ID!) {
  getReponsebyuserId(userid: \$userid) {
    correctAnswer
    selectedAnswer
  }
}

  """;
  static const String getTimeByUserId = """
query GetReponsebyuserId(\$userid: ID!) {
  getReponsebyuserId(userid: \$userid) {
    time
  }
}
    """;
  static const String answerQuiz = """
    mutation Mutation(\$userid: ID!, \$questionid: ID!, \$selectedAnswer: String!, \$time: Int!) {
    createQuizPropa(userid: \$userid, questionid: \$questionid, selectedAnswer: \$selectedAnswer, time: \$time) {
      questionid
    }
  }

  """;
  static const String login = """
    query Login(\$email: String!, \$password: String!) {
   Login(email: \$email, password: \$password) {
    id
    displayName
    email
    password
  }
}
""";
  static const String getQuizesByUserId = """
query GetReponsebyuserId(\$userid: ID!) {
  getReponsebyuserId(userid: \$userid) {
    id
    moduleName
    question
    selectedAnswer
    correctAnswer
    userid
    questionid
    time
  }
}

  """;
  static const String users = """
  query Users {
    users {
    id
    displayName
    password
    email
  }
  }

""";
  static const String createQuizPropa = """
    mutation Mutation(\$userid: ID!, \$questionid: ID!, \$selectedAnswer: String!) {
    createQuizPropa(userid: \$userid, questionid: \$questionid, selectedAnswer: \$selectedAnswer) {
      id
      moduleName
      question
      correctAnswer
      selectedAnswer
      questionid
      time
      userid
      }
    }
  """;
  static const String quizes = """
    query Query {
    quizs {
      moduleName
      id
      question
      correctAnswer
      selectedAnswer
      propositions
      time
     }
    } 
    """;
  static const String quizPropaList = """
    query Query {
    quizPropaList {
      id
      moduleName
      selectedAnswer
      question
      correctAnswer
      questionid
      time
      userid
    }
  }
  """;
}
