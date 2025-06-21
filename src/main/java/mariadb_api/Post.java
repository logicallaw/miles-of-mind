package mariadb_api;

import java.sql.Timestamp;

public class Post {
	private int id;
	private String title;
	private String body;
	private String backgroundColor;
	private String originalFileName;
	private String savedFileName;
	private boolean tempSaved;
	private boolean isImportant;
	private Timestamp createdAt;
	private int categoryId;
	
	public Post() {}
	
	public Post(int id, String title, String body, String backgroundColor, String originalFileName,
			String savedFileName, boolean tempSaved, boolean isImportant, Timestamp createdAt, int categoryId) {
		this.id = id;
		this.title = title;
		this.body = body;
		this.backgroundColor = backgroundColor;
		this.originalFileName = originalFileName;
		this.savedFileName = savedFileName;
		this.tempSaved = tempSaved;
		this.isImportant = isImportant;
		this.createdAt = createdAt;
		this.categoryId = categoryId;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getSavedFileName() {
		return savedFileName;
	}
	public void setSavedFileName(String savedFileName) {
		this.savedFileName = savedFileName;
	}
	public boolean isTempSaved() {
		return tempSaved;
	}
	public void setTempSaved(boolean tempSaved) {
		this.tempSaved = tempSaved;
	}
	public boolean isImportant() {
		return isImportant;
	}
	public void setImportant(boolean isImportant) {
		this.isImportant = isImportant;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

}
