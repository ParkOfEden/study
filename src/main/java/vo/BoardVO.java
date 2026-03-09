package vo;

import java.util.Date;

public class BoardVO {
    private int num;            // DB의 p_id
    private String category;
    private String title;       // DB의 p_name
    private String author;
    private String content;     // DB의 p_desc
    private int price;          
    private String imgUrl;      
    private String system_filename; 
    private Date createdAt;
    private Date updatedAt;
    private int viewCount;

    public BoardVO() {}

    // Getter & Setter
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

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getImgUrl() { return imgUrl; }
    public void setImgUrl(String imgUrl) { this.imgUrl = imgUrl; }

    public String getSystem_filename() { return system_filename; }
    public void setSystem_filename(String system_filename) { this.system_filename = system_filename; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
}