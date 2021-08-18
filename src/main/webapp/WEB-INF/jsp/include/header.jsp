<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-between mt-3">
	<h1 class="logo">Inssagram</h1>
	<div class="d-flex justify-content-center align-items-center col-8">
	<div class="d-flex col-8 input-group">
		<input type="text" id="searchTag" name="searchTag" class="form-control" placeholder="검색">
		<div class="input-group-append">
			<button type="button" id="searchTagBtn" class="btn"><i class="fas fa-search"></i></button>
		</div>
	</div>
	</div>
	<div class="d-flex">
		<%-- 로그인이 된 경우 --%>
		<c:if test="${not empty userName}">
			<div class="d-flex align-items-center"> 
				<img src="${userProfileImageFile}" class="profileImage">
			</div>
			<div class="d-flex align-items-end mb-2">
				<small><a href="/user/sign_out">로그아웃</a></small>
			</div>
		</c:if>
		
		<%-- 로그인이 안 된 경우 --%>
		<c:if test="${empty userName}">
			<div class="d-flex align-items-end mb-2">
				<small><a href="/user/sign_in_view">로그인</a></small>
			</div>
		</c:if>
	</div>
</div>