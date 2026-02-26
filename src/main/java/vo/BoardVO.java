package vo;

import java.util.Date;

public class BoardVO {
    private int num;
    private String category; // 추가됨
    private String title;
    private String author;
    private String content;
    private String imgUrl;   // 추가됨
    private Date createdAt;
    private Date updatedAt;
    private int viewCount;

    // 기본 생성자
    public BoardVO() {}

    // Getter와 Setter (필수)
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

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
}