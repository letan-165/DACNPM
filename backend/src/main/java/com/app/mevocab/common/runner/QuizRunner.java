package com.app.mevocab.common.runner;

import com.app.mevocab.common.enums.QuestionType;
import com.app.mevocab.internal.quiz.dto.Question;
import com.app.mevocab.internal.quiz.entity.Quiz;
import com.app.mevocab.internal.quiz.repository.QuizRepository;
import com.app.mevocab.internal.topic.entity.Topic;
import com.app.mevocab.internal.topic.repository.TopicRepository;
import com.app.mevocab.internal.vocabulary.entity.Word;
import com.app.mevocab.internal.vocabulary.repository.WordRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Component
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizRunner implements ApplicationRunner {
    QuizRepository quizRepository;
    WordRepository wordRepository;
    TopicRepository topicRepository;
    static Random random = new Random();

    @Override
    public void run(ApplicationArguments args) throws Exception {
        var topics = topicRepository.findAll();
        System.out.println("Đang tải bài quiz mặc định cho database");
        List<Quiz> quizs = new ArrayList<>();
        for (Topic topic : topics){
            var wordsByTopic = wordRepository.findAllByTopic_Name(topic.getName());
            var translations =  wordsByTopic.stream()
                    .map(Word::getTranslation)
                    .toList();

            if (wordsByTopic.size()!=5 || translations.size()!=5) continue;
            String quizID ="quiz-" + topic.getName()+"-default";
            if (quizRepository.existsById(quizID))
                continue;

            Quiz quiz = Quiz.builder()
                    .quizID(quizID)
                    .topic(topic)
                    .title("Bài mặc định theo chủ đề " + topic.getName())
                    .totalTime(60)
                    .updateAt(Instant.now())
                    .build();

            for (int i = 0 ; i < 5; i++){
                Word word = wordsByTopic.get(i);
                Question question = Question.builder().questionID(i).build();
                if(i == 0){
                    boolean isCorrect = randomBoolean();
                    String titleCorrect = isCorrect ? " có nghĩa là " : " không phải ";
                    question = question.toBuilder()
                            .type(QuestionType.SELECT)
                            .title("Từ "+ word.getWord() + titleCorrect + word.getTranslation() + " phải không?")
                            .options(List.of("Đúng", "Sai"))
                            .correct(isCorrect ? "Đúng" : "Sai")
                            .build();
                } else if ( i == 4) {
                    question = question.toBuilder()
                            .type(QuestionType.ENTER)
                            .title("Từ "+ word.getTranslation() + " có nghĩa là =@= .?")
                            .correct(word.getWord())
                            .build();
                }else{
                    String translation=word.getTranslation();
                    question = question.toBuilder()
                            .type(QuestionType.SELECT)
                            .title("Từ "+ word.getWord() + " có nghĩa là gì ?")
                            .options(generateOptions(translation,translations))
                            .correct(translation)
                            .build();
                }
                quiz.getQuestions().put(question.getQuestionID(), question);
            }
            quizs.add(quiz);
        }
        if (!quizs.isEmpty())
            quizRepository.saveAll(quizs);
        System.out.println("Bài quiz mặc định mỗi chủ đề đã được lưu vào database!");
    }
    public boolean randomBoolean() {
        return random.nextBoolean();
    }

    public static List<String> generateOptions(String correct, List<String> options) {
        List<String> wrongOptions = new ArrayList<>(options);
        wrongOptions.removeIf(opt -> opt.equals(correct));

        List<String> newOptions = new ArrayList<>(wrongOptions.subList(0, 3));
        newOptions.add(correct);
        Collections.shuffle(newOptions);

        return newOptions;
    }


}
