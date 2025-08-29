package com.app.mevocab.common.runner;

import com.app.mevocab.internal.topic.entity.Topic;
import com.app.mevocab.internal.topic.repository.TopicRepository;
import com.app.mevocab.internal.vocabulary.service.WordService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TopicRunner implements ApplicationRunner {
    TopicRepository topicRepository;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        List<Topic> topics = List.of(
                new Topic("Gia đình", "Từ vựng về các thành viên trong gia đình"),
                new Topic("Màu sắc", "Từ vựng về các màu sắc"),
                new Topic("Động vật", "Từ vựng về động vật"),
                new Topic("Thực phẩm", "Từ vựng về các loại thực phẩm"),
                new Topic("Đồ uống", "Từ vựng về các loại đồ uống"),
                new Topic("Quần áo", "Từ vựng về các loại quần áo"),
                new Topic("Đồ gia dụng", "Từ vựng về đồ dùng gia đình")
        );
        System.out.println("Đang tải chủ đề mặc định cho database");
        topics.forEach(topic -> {
            if (!topicRepository.existsById(topic.getName())) {
                topicRepository.save(topic);
            }
        });

        System.out.println("Chủ đề mặc định đã được lưu vào database!");
    }
}
