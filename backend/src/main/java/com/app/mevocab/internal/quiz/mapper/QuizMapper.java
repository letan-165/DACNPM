package com.app.mevocab.internal.quiz.mapper;

import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.dto.response.QuizResponse;
import com.app.mevocab.internal.quiz.entity.Quiz;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.util.List;
import java.util.Map;

@Mapper(componentModel = "spring")
public interface QuizMapper {
    @Mapping(target = "questions", source = "questions", qualifiedByName = "toListQuestions")
    QuizResponse toQuizResponse(Quiz quiz);

    @Named("toListQuestions")
    default List<Question> toMapQuestions(Map<Integer,Question> questionMap){
        return questionMap.values().stream().toList();
    }
}
