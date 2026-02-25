package utils;

/**
 * 요청한 페이지 정보에 따라
 * 이동가능한 페이지 번호를 계산 및 제공하는 class
 * 필수 정보
 * 사용자가 요청한 페이지 번호 : page
 * 한번에 보여줄 게시물(행) 개수 : perPageNum
 * 전체 게시물 개수 : totalCount
 * 한 페이지 블럭에 출력할 번호 개수 : blockSize
 */
public class PageMaker {

	/**
	 * 요청 페이지 번호
	 * 한번에 보여줄 게시물 개수
	 * 테이블 검색 인덱스 정보를 저장하는 class
	 * page, perPageNum, startRow
	 */
	private Criteria criteria;

	/**
	 * table에 저장된 전체 row 개수
	 * 전체 게시물 수
	 */
	private int totalCount;
	
	/**
	 * 한 페이지 블럭에 보여줄 페이지 번호 개수
	 */
	private int blockSize;
	
	/**
	 * 한번에 보여줄 페이지 번호와 사용자가 요청한 페이지 번호에 따라
	 * 화면에 출력될 페이지 블럭의 시작 페이지 번호를 저장할 field
	 */
	private int startPage;
	
	/**
	 * 한번에 보여줄 페이지 번호와 사용자가 요청한 페이지 번호에 따라
	 * 화면에 출력될 페이지 블럭의 마지막 페이지 번호를 저장할 field
	 */
	private int endPage;
	
	/**
	 * 이동 가능한 최대 페이지 번호
	 */
	private int maxPage;
	
	/**
	 * first - 첫페이지 이동 버튼 활성화 여부
	 * last - 마지막 페이지 이동 버튼 활성화 여부
	 * prev - 이전 페이지 이동 버튼 활성화 여부
	 * next - 다음 페이지 이동 버튼 활성화 여부
	 */
	private boolean first, last, prev, next;
	
	public PageMaker() {
		this(new Criteria(), 0, 5);
	}
	
	/**
	 * 페이지 블럭 생성에 필요한 전체 정보를 매개변수로 받는 생성자
	 */
	public PageMaker(Criteria criteria, int totalCount, int blockSize) {
		setCriteria(criteria);
		setTotalCount(totalCount);
		setBlockSize(blockSize);
	}


	/**
	 * Criteria, displayPageCount, totalCount
	 * 필드에 저장된 정보를 이용하여 
	 * 페이지 블럭에 번호를 출력하기 위한 계산을 하는 method
	 * startPage, endPage, maxPage
	 */
	public void calcPaging() {
		maxPage = (int)Math.ceil(totalCount / (double)criteria.getPerPageNum());
		
		// 마지막 페이지 번호 부터 연산
		endPage = (int)Math.ceil(criteria.getPage() / (double)blockSize) * blockSize;
		
		startPage = endPage - (blockSize - 1);
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이지 블럭 이동 버튼 활성화 여부 계산
		first = (criteria.getPage() != 1) ? true : false;
		last = (criteria.getPage() != maxPage) ? true : false;
		prev = (startPage != 1) ? true : false;
		next = (endPage != maxPage) ? true : false;
		
	} // end calcPaging()
	
	public Criteria getCriteria() {
		return criteria;
	}

	public void setCriteria(Criteria criteria) {
		if(criteria == null) {
			this.criteria = new Criteria();
			return;
		}
		this.criteria = criteria;
		// 변경된 정보로 다시 계산
		calcPaging();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		// 아직 Criteria 가 초기화 되지 않았으면 새롭게 생성
		if(this.criteria == null) {
			this.criteria = new Criteria();
		}
		
		if(totalCount < 0){
			this.totalCount = 0;
		}else {
			this.totalCount = totalCount;
		}
		// 변경된 정보로 다시 계산
		calcPaging();
	}

	public int getBlockSize() {
		return this.blockSize;
	}

	public void setBlockSize(int blockSize) {
		// 아직 Criteria 가 초기화 되지 않았으면 새롭게 생성
		if(this.criteria == null) {
			this.criteria = new Criteria();
		}
		if(blockSize < 0) {
			this.blockSize = 5;
		}else {
			this.blockSize = blockSize;
		}
		// 변경된 정보로 다시 계산
		calcPaging();
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public boolean isFirst() {
		return first;
	}

	public boolean isLast() {
		return last;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	@Override
	public String toString() {
		return "PageMaker [criteria=" + criteria + ", totalCount=" + totalCount + ", blockSize=" + blockSize
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", maxPage=" + maxPage + ", first=" + first
				+ ", last=" + last + ", prev=" + prev + ", next=" + next + "]";
	}

}










