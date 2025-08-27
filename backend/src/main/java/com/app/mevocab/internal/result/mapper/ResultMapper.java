package com.app.mevocab.internal.result.mapper;

import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.dto.response.QuizResponse;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.quiz.mapper.QuizMapper;
import com.app.mevocab.internal.result.dto.Answer;
import com.app.mevocab.internal.result.dto.response.ResultResponse;
import com.app.mevocab.internal.result.entity.Result;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

@Mapper(componentModel = "spring")
public abstract class ResultMapper {
    @Autowired
    private QuizMapper quizMapper;

    @Mapping(target = "quiz", source = "quiz", qualifiedByName = "toQuizResponse")
    @Mapping(target = "answers", source = "answers", qualifiedByName = "toListAnswers")
    public abstract ResultResponse toResultResponse(Result result);

    @Named("toQuizResponse")
    public QuizResponse toQuizResponse(Quiz quiz){
        return quizMapper.toQuizResponse(quiz);
    }

    @Named("toListAnswers")
    public List<Answer> toMapAnswers(Map<Integer,Answer> answerMap){
        return answerMap.values().stream().toList();
    }
}
