package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {

    private Long bd_number;
    private String bd_guest_nickname;
    private String bd_guest_pw;
}
