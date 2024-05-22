package com.thedeveloper.garant.util.storage;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@Setter
@ConfigurationProperties("documents")
public class DocumentProperties {
    private String location = "storage";
}
