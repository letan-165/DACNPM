package com.app.mevocab.internal.quiz.service;

import com.app.mevocab.common.exception.AppException;
import com.app.mevocab.common.exception.ErrorCode;
import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.dto.request.QuestionDeleteRequest;
import com.app.mevocab.internal.quiz.dto.request.QuestionSaveRequest;
import com.app.mevocab.internal.quiz.dto.request.QuizSaveRequest;
import com.app.mevocab.internal.quiz.dto.response.QuizResponse;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.quiz.mapper.QuizMapper;
import com.app.mevocab.internal.quiz.repository.QuizRepository;
import com.app.mevocab.internal.topic.repository.TopicRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class QuizService {
    QuizRepository quizRepository;
    TopicRepository topicRepository;
    QuizMapper quizMapper;

    public List<QuizResponse> findAll(){
        return quizRepository.findAll().stream()
                .map(quizMapper::toQuizResponse)
                .toList();
    }

    public List<QuizResponse> findAllByTopic(String topic){
        return quizRepository.findAllByTopic_Name(topic).stream()
                .map(quizMapper::toQuizResponse)
                .toList();
    }

    public QuizResponse save(QuizSaveRequest request) {
        var quizID = request.getQuizID();
        Quiz quiz;
        if(quizID!=null){
            quiz = quizRepository.findById(quizID)
                    .orElseThrow(()->new AppException(ErrorCode.QUIZ_NO_EXISTS));
        }else {
            quiz = new Quiz();
        }
        var topic = topicRepository.findById(request.getTopic())
                .orElseThrow(()->new AppException(ErrorCode.TOPIC_NO_EXISTS));

        quiz.setTitle(request.getTitle());
        quiz.setTopic(topic);
        quiz.setTotalTime(request.getTotalTime());
        quiz.setUpdateAt(Instant.now());
        return quizMapper.toQuizResponse(quizRepository.save(quiz));
    }

    public void delete (String id){
        if(!quizRepository.existsById(id))
            throw new AppException(ErrorCode.QUIZ_NO_EXISTS);

        quizRepository.deleteById(id);
    }

    public List<Integer> saveQuestions(QuestionSaveRequest request){
        var quiz = quizRepository.findById(request.getQuizID())
                .orElseThrow(()->new AppException(ErrorCode.QUIZ_NO_EXISTS));
        var questionsMap = quiz.getQuestions();
        List<Integer> ids= new ArrayList<>();
        for (Question question : request.getQuestions()){
            Integer id = question.getQuestionID();
            if(!question.checkQuestion())
                throw new AppException(ErrorCode.QUESTION_INVALID);

            if (id == null || !questionsMap.containsKey(id)) {
                id = questionsMap.values().stream()
                        .mapToInt(Question::getQuestionID)
                        .max()
                        .orElse(0) + 1;
                question.setQuestionID(id);
            }
            questionsMap.put(id,question);
            ids.add(id);
        }
        quizRepository.save(quiz);
        return ids;
    }

    public List<Integer> deleteQuestions(QuestionDeleteRequest request){
        var quiz = quizRepository.findById(request.getQuizID())
                .orElseThrow(()->new AppException(ErrorCode.QUIZ_NO_EXISTS));
        var questionsMap = quiz.getQuestions();
        List<Integer> ids= new ArrayList<>();
        for (Integer id: request.getQuestionIDs()){
            if(questionsMap.remove(id) != null){
                ids.add(id);
            }
        }
        quizRepository.save(quiz);
        return ids;
    }

}
