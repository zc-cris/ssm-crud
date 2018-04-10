package com.zc.cris.crud.bean.vo;

import java.util.HashMap;
import java.util.Map;

// 用于向客户端发送的数据，SpringMVC 会自动解析封装为 json 字符串
public class Msg {
    
    // 状态码 100 表示操作成功；200 表示操作失败
    private Integer code;
    // 提示信息
    private String message;
    // 用于存储 pageInfo 以及其他信息
    private Map<String, Object> map = new HashMap<>();

    private Msg() {}
    
    // 操作成功后台返回对应的 Msg 实例
    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMessage("操作成功！");
        return msg;
    }
    
    // 操作失败后台返回的 Msg 实例
    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMessage("操作失败！");
        return msg;
    }
    
    // 为了实现链式调用，手写一个可以不断往 map 放 key-value 的方法
    public Msg add(String key, Object value) {
        this.getMap().put(key, value);
        return this;
    }
    
    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }

}
