package com.app.mevocab.common.runner;

import com.app.mevocab.internal.topic.repository.TopicRepository;
import com.app.mevocab.internal.vocabulary.dto.request.WordRequest;
import com.app.mevocab.internal.vocabulary.service.WordService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
@Order(2)
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class WordRunner implements ApplicationRunner {

    TopicRepository topicRepository;
    WordService wordService;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        Map<String, List<String>> topicWordMap = Map.of(
                "Gia đình", List.of("father", "mother", "brother", "sister", "grandfather"),
                "Màu sắc", List.of("red", "blue", "green", "yellow", "black"),
                "Động vật", List.of("dog", "cat", "bird", "fish", "elephant"),
                "Thực phẩm", List.of("rice", "bread", "apple", "carrot", "banana"),
                "Đồ uống", List.of("water", "milk", "tea", "coffee", "juice"),
                "Quần áo", List.of("shirt", "pants", "skirt", "hat", "shoes"),
                "Đồ gia dụng", List.of("table", "chair", "bed", "cupboard", "door")
        );

        System.out.println("Đang tải từ vựng mặc định cho database...");
        topicWordMap.forEach((topic, words) -> {
            words.forEach(wordStr -> {
                try {
                    WordRequest request = new WordRequest();
                    request.setWord(wordStr);
                    request.setTopic(topic);
                    wordService.suggest(request, true);
                } catch (Exception ignored) {
                }
            });
        });

        System.out.println("Đã lưu từ vựng mặc định cho mỗi chủ đề!");
    }
}
