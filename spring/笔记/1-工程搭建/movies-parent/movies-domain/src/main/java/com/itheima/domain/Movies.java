package com.itheima.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Movies implements Serializable {
    private Integer id;

    private String title;//电影名称

    private String picPath;//图片地址

    private Integer cid;//分类的id 0：特色的  1：高观看率   2：高评分  3：最新上映

    private String contentDesc;//电影描述

    private String keyword;//关键字，用来搜索

    private Integer orderNo;//排序号，越小越靠前

    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd") // java转json指定指定的格式
    @DateTimeFormat(pattern = "yyyy-MM-dd") // springMVC接收日期的格式
    private Date showTime;//创建时间

    private String director;//导演姓名

    private String actors;//演员姓名

    private String url;//播放连接

    private Boolean needPay;//是否需要付费，0：不需要 1：需要

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath == null ? null : picPath.trim();
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getContentDesc() {
        return contentDesc;
    }

    public void setContentDesc(String contentDesc) {
        this.contentDesc = contentDesc == null ? null : contentDesc.trim();
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public Date getShowTime() {
        return showTime;
    }

    public void setShowTime(Date showTime) {
        this.showTime = showTime;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director == null ? null : director.trim();
    }

    public String getActors() {
        return actors;
    }

    public void setActors(String actors) {
        this.actors = actors == null ? null : actors.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Boolean getNeedPay() {
        return needPay;
    }

    public void setNeedPay(Boolean needPay) {
        this.needPay = needPay;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", title=").append(title);
        sb.append(", picPath=").append(picPath);
        sb.append(", cid=").append(cid);
        sb.append(", contentDesc=").append(contentDesc);
        sb.append(", keyword=").append(keyword);
        sb.append(", orderNo=").append(orderNo);
        sb.append(", showTime=").append(showTime);
        sb.append(", director=").append(director);
        sb.append(", actors=").append(actors);
        sb.append(", url=").append(url);
        sb.append(", needPay=").append(needPay);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}