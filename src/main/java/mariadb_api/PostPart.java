package mariadb_api;

import jakarta.servlet.http.Part;

public class PostPart {
	private Part part;
	private String savedFileName;
	
	public PostPart(Part part, String savedFileName) {
		this.part = part;
		this.savedFileName = savedFileName;
	}
	
	public Part getPart() {
		return part;
	}
	
	public String getSavedFileName() {
		return savedFileName;
	}
}
