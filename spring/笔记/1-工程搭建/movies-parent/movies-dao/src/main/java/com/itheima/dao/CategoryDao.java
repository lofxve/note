package com.itheima.dao;

import com.itheima.domain.Category;
import com.itheima.domain.CategoryExample;

import java.util.List;

public interface CategoryDao {
    int insert(Category record);

    int insertSelective(Category record);

    List<Category> selectByExample(CategoryExample example);
}