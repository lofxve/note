package com.itheima.dao;

import com.itheima.domain.Banner;
import com.itheima.domain.BannerExample;

import java.util.List;

public interface BannerDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Banner record);

    int insertSelective(Banner record);

    List<Banner> selectByExample(BannerExample example);

    Banner selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Banner record);

    int updateByPrimaryKey(Banner record);
}