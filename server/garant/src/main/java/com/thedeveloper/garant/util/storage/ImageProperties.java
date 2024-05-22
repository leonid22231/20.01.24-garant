package com.thedeveloper.alertsystem.service.storage;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@Setter
@ConfigurationProperties("images")
public class ImageProperties {
    private String location = "storage";

}
