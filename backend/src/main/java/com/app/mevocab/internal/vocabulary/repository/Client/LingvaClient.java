package com.app.mevocab.internal.vocabulary.repository.Client;

import com.app.mevocab.internal.vocabulary.dto.response.LingvaResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "lingva", url = "${app.client.lingva}")
public interface LingvaClient {
    @GetMapping("/en/vi/{word}")
    LingvaResponse getTranslation(@PathVariable String word);
}
