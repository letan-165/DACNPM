package com.app.mevocab.internal.result.service;

import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.quiz.repository.QuizRepository;
import com.app.mevocab.internal.result.dto.Answer;
import com.app.mevocab.internal.result.dto.request.JoinQuizRequest;
import com.app.mevocab.internal.result.dto.request.SubmitRequest;
import com.app.mevocab.internal.result.dto.response.ResultResponse;
import com.app.mevocab.internal.result.entity.Result;
import com.app.mevocab.internal.result.mapper.ResultMapper;
import com.app.mevocab.internal.result.repository.ResultRepository;
import com.app.mevocab.internal.user.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class ResultService {
    ResultRepository resultRepository;
    QuizRepository quizRepository;
    UserRepository userRepository;
    ResultMapper resultMapper;

    public List<ResultResponse> findAllByStudentID(String studentID){
        return resultRepository.findAllByStudentID(studentID).stream()
                .map(resultMapper::toResultResponse)
                .toList();
    }

    public ResultResponse join(JoinQuizRequest request){
        String userID = request.getStudentID();
        if(!userRepository.existsById(userID))
            throw new AppException(ErrorCode.USER_NO_EXISTS);

        var quiz = quizRepository.findById(request.getQuizID())
                .orElseThrow(()->new AppException(ErrorCode.QUIZ_NO_EXISTS));

        var answers = quiz.getQuestions().values().stream()
                .map(question -> Answer.builder()
                        .answerID(question.getQuestionID())
                        .answer("")
                        .build())
                .collect(Collectors.toMap(Answer::getAnswerID, answer -> answer));

        Result result = Result.builder()
                .quiz(quiz)
                .studentID(userID)
                .answers(answers)
                .totalQuestion(quiz.getQuestions().size())
                .createAt(Instant.now())
                .build();

        return resultMapper.toResultResponse(resultRepository.save(result));
    }

    public ResultResponse submit(SubmitRequest request){
        Result result = resultRepository.findById(request.getResultID())
                .orElseThrow(()-> new AppException(ErrorCode.RESULT_NO_EXISTS));

        var questions = result.getQuiz().getQuestions();
        for (var submit : request.getSubmits()){
            Question question = questions.get(submit.getQuestionID());

            Answer answer = Answer.builder()
                    .answerID(submit.getQuestionID())
                    .answer(submit.getAnswer())
                    .correct(submit.getAnswer().equals(question.getCorrect()))
                    .build();
            result.getAnswers().put(submit.getQuestionID(), answer);
        }

        return resultMapper.toResultResponse(resultRepository.save(result));
    }

    public ResultResponse finish(String resultID){
        Result result = resultRepository.findById(resultID)
                .orElseThrow(()-> new AppException(ErrorCode.RESULT_NO_EXISTS));

        var totalQuestion = result.getQuiz().getQuestions().size();
        int totalCorrect = (int) result.getAnswers().values().stream()
                .filter(Answer::isCorrect)
                .count();

        result = result.toBuilder()
                .totalCorrect(totalCorrect)
                .totalQuestion(totalQuestion)
                .score(((double) totalCorrect /totalQuestion)*10)
                .finish(Instant.now())
                .build();

        return resultMapper.toResultResponse(resultRepository.save(result));
    }




}
