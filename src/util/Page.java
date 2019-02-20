package util;


public class Page {

	//当前页码
	private int pageIndex;
	//页面容量
	private int pageSize;
	//总页面数量
	private int totalPage;
	//总数据数量
	private int totalCount;

	public Page(){}

	public Page(int pageSize, int totalCount, int pageIndex) {
		setPageSize(pageSize);
		setTotalCount(totalCount);
		setTotalPage();
		setPageIndex(pageIndex);
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		if(pageIndex<=0){
			this.pageIndex = 1;
		}else if(pageIndex>this.totalPage){
			this.pageIndex = this.totalPage;
		}else{
			this.pageIndex = pageIndex;
		}
		if(this.pageIndex == 0){
			this.pageIndex = 1;
		}
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage() {
		this.totalPage = totalCount%pageSize == 0?totalCount/pageSize:totalCount/pageSize+1;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
}
