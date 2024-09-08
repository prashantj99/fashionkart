package com.fashionkart.payload;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Response {
    private final boolean success;

    public Response(boolean success) {
        this.success = success;
    }
}