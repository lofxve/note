package com.itheima.dao;

import com.itheima.domain.Members;
import com.itheima.domain.MembersExample;

import java.util.List;

public interface MembersDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Members record);

    int insertSelective(Members record);

    List<Members> selectByExample(MembersExample example);

    Members selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Members record);

    int updateByPrimaryKey(Members record);
}