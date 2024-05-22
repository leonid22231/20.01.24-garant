package com.thedeveloper.garant.util.storage;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@Setter
@ConfigurationProperties("dealimage")
public class DealImageProperties {
    private String location = "storage";
}
