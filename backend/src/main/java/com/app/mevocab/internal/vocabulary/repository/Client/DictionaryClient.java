package com.app.mevocab.internal.vocabulary.repository.Client;

import com.app.mevocab.internal.vocabulary.dto.response.dictionary.DictionaryResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(value = "Dictionary", url = "https://api.dictionaryapi.dev/api/v2")
public interface DictionaryClient {
    @GetMapping("/entries/en/{word}")
    List<DictionaryResponse> getDictionary(@PathVariable String word);
}
