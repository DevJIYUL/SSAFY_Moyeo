package com.danim.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TimelinePostOuter {
    private List<TimelinePostInner> timeline;
    private Boolean isComplete;
    private Boolean isPublic;
   // private List<String> nationList;
    private Boolean isMine;

    private String title;


    public TimelinePostOuter() {
        timeline = new ArrayList<>();

    }
}
