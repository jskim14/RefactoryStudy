package com.nb.spring.common.statusCode;

public enum PermissionYN {
    WAITING("0"),
    CONFIRM("1"),
    REJECT("2");

    private final String status;

    PermissionYN(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
