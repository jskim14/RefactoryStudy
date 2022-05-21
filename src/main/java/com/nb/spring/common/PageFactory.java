package com.nb.spring.common;

public class PageFactory {
	public static String getPageBar(int totalData, int cPage, int numPerPage, int pageBarSize, String url) {
		String pageBar = "";
		int totalPage = (int) Math.ceil((double) totalData / numPerPage);
		int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageNo + pageBarSize - 1;
		pageBar = "<ul class='pagination justify-content-center pagination-sm'>";
		if (pageNo == 1) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo - 1) + "," + numPerPage
					+ ")'>이전</a>";
			pageBar += "</li>";
		}

		while (!(pageNo > pageEnd || pageNo > totalPage)) {
			if (pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link' href='#'>" + pageNo + "</a>";
				pageBar += "</li>";
			} else {
				pageBar += "<li class='page-item'>";
				pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + "," + numPerPage + ")'>"
						+ pageNo + "</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		if (pageNo > totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + "," + numPerPage + ")'>다음</a>";
			pageBar += "</li>";
		}
		pageBar += "</ul>";
		pageBar += "<script>";
		pageBar += "function fn_paging(cPage,numPerPage) {";
		pageBar += "location.assign('" + url + "?cPage='+cPage+'&numPerPage='+ numPerPage);";
		pageBar += "}";
		pageBar += "$('#selectNum').change(e=>{";
		pageBar += "const selectVal = $('#selectNum').val();";
		pageBar += "fn_paging(1,selectVal);";
		pageBar += "});";
		pageBar += "</script>";

		return pageBar;

	}
	
	public static String getPageBarSearch(int totalData, int cPage, int numPerPage, int pageBarSize) {
		String pageBar = "";
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageNo + pageBarSize - 1;
		pageBar = "<ul class='pagination justify-content-center pagination-sm'>";
		if(pageNo==1) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo-1) + ")'>이전</a>";
			pageBar += "</li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link' href='#'>" + pageNo + "</a>";
				pageBar += "</li>";
			}else {
				pageBar += "<li class='page-item'>";
				pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + ")'>" + pageNo + "</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + ")'>다음</a>";
			pageBar += "</li>";
		}
		
		return pageBar;

	}
	
	public static String getPageBarMessageBox(int totalData, int cPage, int numPerPage, int pageBarSize, String url, String msgbox, String memberNo) {
		String pageBar = "";
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageNo + pageBarSize - 1;
		pageBar = "<ul class='pagination justify-content-center pagination-sm'>";
		if(pageNo==1) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo-1) + ")'>이전</a>";
			pageBar += "</li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link' href='#'>" + pageNo + "</a>";
				pageBar += "</li>";
			}else {
				pageBar += "<li class='page-item'>";
				pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + ")'>" + pageNo + "</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging(" + (pageNo) + ")'>다음</a>";
			pageBar += "</li>";
		}
		pageBar += "</ul>";
		pageBar += "<script>";
		pageBar += "function fn_paging(cPage) {";
		pageBar += "location.assign('" + url + "?cPage=' + cPage +'&msgbox=" + msgbox + "&memberNo=" + memberNo + "');";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;

	}
	
	public static String emoneySearch(int totalData, int cPage, int numPerPage, int pageBarSize, String url, String btnCategory) {
		String pageBar = "";
		int totalPage = (int) Math.ceil((double) totalData / numPerPage);
		int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageNo + pageBarSize - 1;
		pageBar = "<ul class='pagination justify-content-center pagination-sm'>";
		if (pageNo == 1) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging2(" + (pageNo - 1) + "," + numPerPage +"," + btnCategory 
					+ ")'>이전</a>";
			pageBar += "</li>";
		}

		while (!(pageNo > pageEnd || pageNo > totalPage)) {
			if (pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link' href='#'>" + pageNo + "</a>";
				pageBar += "</li>";
			} else {
				pageBar += "<li class='page-item'>";
				pageBar += "<a class='page-link' href='javascript:fn_paging2(" + (pageNo) + "," + numPerPage + "," + btnCategory + ")'>"
						+ pageNo + "</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		if (pageNo > totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging2(" + (pageNo) + "," + numPerPage + "," + btnCategory + ")'>다음</a>";
			pageBar += "</li>";
		}
		pageBar += "</ul>";
		pageBar += "<script>";
		pageBar += "function fn_paging(cPage,numPerPage,btnCategory) {";
		pageBar += "location.assign('" + url + "?cPage='+cPage+'&numPerPage='+ numPerPage +'&btnCategory='+btnCategory);";
		pageBar += "}";
		pageBar += "$('#selectNum').change(e=>{";
		pageBar += "const selectVal = $('#selectNum').val();";
		pageBar += "fn_paging2(1,selectVal);";
		pageBar += "});";
		pageBar += "</script>";

		return pageBar;

	}
	
}
