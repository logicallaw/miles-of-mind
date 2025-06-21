package mariadb_api;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.http.Part;

public class PostMultiPart {
	private Map<String, PostPart> fileMap;

	// Constructor: processes multipart file uploads and stores metadata
	public PostMultiPart(Collection<Part> parts, String realFolder) throws IOException {
		fileMap = new HashMap<>();

		for (Part part : parts) {
			String fileName = part.getSubmittedFileName();

			// Only handle parts that are files (not form fields)
			if (fileName != null && fileName.length() != 0) {
				// Extract file extension
				String fileDotExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());

				// Generate a unique file name using UUID
				UUID uuid = UUID.randomUUID();
				String savedFileName = fileName.substring(0, fileName.lastIndexOf(".")) 
				                     + "_" + uuid.toString() + fileDotExt;

				// Save the file to the specified upload folder
				part.write(realFolder + File.separator + savedFileName);

				// Store the file info in a custom PostPart object
				PostPart pp = new PostPart(part, savedFileName);
				fileMap.put(part.getName(), pp);

				// Remove temporary file from memory/disk
				part.delete();
			}
		}
	}

	// Returns the PostPart associated with a form field (e.g., "originalFileName")
	public PostPart getPostPart(String paramName) {
		return fileMap.get(paramName);
	}

	// Returns the saved (renamed with UUID) file name
	public String getSavedFileName(String paramName) {
		return fileMap.get(paramName).getSavedFileName();
	}

	// Returns the original uploaded file name
	public String getOriginalFileName(String paramName) {
		return this.getPostPart(paramName).getPart().getSubmittedFileName();
	}
}