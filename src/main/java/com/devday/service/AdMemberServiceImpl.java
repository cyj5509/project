package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.mapper.AdMemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdMemberServiceImpl implements AdMemberService {

	private final AdMemberMapper adMemberMapper;
}
