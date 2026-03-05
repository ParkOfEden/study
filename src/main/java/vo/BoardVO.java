package vo;

import java.util.Date;

public class BoardVO {
    private int num;            // DB의 p_id와 매칭
    private String category;
    private String title;       // DB의 p_name과 매칭
    private String author;
    private String content;     // DB의 p_desc와 매칭
    private int price;          // [추가] 상품 가격 필드
    private String imgUrl;      
    private String systemFilename; 
    private Date createdAt;
    private Date updatedAt;
    private int viewCount;

    public BoardVO() {}

    // 가격(price)에 대한 Getter와 Setter를 추가해야 합니다.
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    // 기존 Getter/Setter 유지
    public int getNum() { return num; }
    public void setNum(int num) { this.num = num; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getImgUrl() { return imgUrl; }
    public void setImgUrl(String imgUrl) { this.imgUrl = imgUrl; }

    public String getSystem_filename() { return systemFilename; }
    public void setSystem_filename(String systemFilename) { this.systemFilename = systemFilename; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
}