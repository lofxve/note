package com.itheima.dao;

import com.itheima.domain.Movies;
import com.itheima.domain.MoviesExample;

import java.util.List;

public interface MoviesDao {

    Movies selectByPrimaryKey(Integer id);

    int deleteByPrimaryKey(Integer id);

    int insert(Movies record);

    int insertSelective(Movies record);

    int updateByPrimaryKey(Movies record);

    int updateByPrimaryKeySelective(Movies record);

    List<Movies> selectByExample(MoviesExample example);
}