package com.app.mevocab.internal.topic.controller;

import com.app.mevocab.common.ApiResponse;
import com.app.mevocab.internal.topic.entity.Topic;
import com.app.mevocab.internal.topic.service.TopicService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/topic")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class TopicController {
    TopicService topicService;

    @GetMapping
    ApiResponse<List<Topic>> findAll(){
        return ApiResponse.<List<Topic>>builder()
                .message("Lấy danh sách chủ đề")
                .result(topicService.findAll())
                .build();
    }

    @PostMapping
    ApiResponse<Topic> save(@RequestBody Topic topic){
        return ApiResponse.<Topic>builder()
                .message("Lưu chủ đề")
                .result(topicService.save(topic))
                .build();
    }

    @DeleteMapping("/{topicID}")
    ApiResponse<Boolean> deleteById(@PathVariable String topicID){
        topicService.deleteById(topicID);
        return ApiResponse.<Boolean>builder()
                .message("Xóa chủ đề")
                .result(true)
                .build();
    }
}
