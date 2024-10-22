package com.itwillbs.service;

import java.util.List;
import com.itwillbs.domain.CompanyVO;

public interface CompanyService {
    List<CompanyVO> getCompanyList(); // 거래처 목록 조회

    void registerCompany(CompanyVO company); // 거래처 등록

    CompanyVO getCompanyByCode(String companyCode); // 거래처 상세 조회

    void updateCompany(CompanyVO company); // 거래처 수정

    void deleteCompany(int companyCode); // 거래처 삭제
}
