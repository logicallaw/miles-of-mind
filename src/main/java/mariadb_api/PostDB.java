package mariadb_api;

import javax.naming.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDB {
	private Connection con;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	// Constructor: Establishes DB connection via connection pool
	public PostDB() throws SQLException, NamingException {
		con = ConnectionPool.getConnection();
	}

	// Inserts a new post into the database
	public void insertPost(Post post) throws SQLException {
		String sql = "INSERT INTO posts("
		           + "id, title, body, background_color, original_file_name, saved_file_name, "
		           + "temp_saved, is_important, created_at, category_id) "
		           + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, post.getId());
		pstmt.setString(2, post.getTitle());
		pstmt.setString(3, post.getBody());
		pstmt.setString(4, post.getBackgroundColor());
		pstmt.setString(5, post.getOriginalFileName());
		pstmt.setString(6, post.getSavedFileName());
		pstmt.setBoolean(7, post.isTempSaved());
		pstmt.setBoolean(8, post.isImportant());
		pstmt.setTimestamp(9, post.getCreatedAt());
		pstmt.setInt(10, post.getCategoryId());

		pstmt.executeUpdate();
	}

	// Updates an existing post in the database
	public void updatePost(Post post) throws SQLException {
		String sql = "UPDATE posts SET "
		           + "title = ?, body = ?, background_color = ?, "
		           + "original_file_name = ?, saved_file_name = ?, "
		           + "temp_saved = ?, is_important = ?, created_at = ?, category_id = ? "
		           + "WHERE id = ?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, post.getTitle());
		pstmt.setString(2, post.getBody());
		pstmt.setString(3, post.getBackgroundColor());
		pstmt.setString(4, post.getOriginalFileName());
		pstmt.setString(5, post.getSavedFileName());
		pstmt.setBoolean(6, post.isTempSaved());
		pstmt.setBoolean(7, post.isImportant());
		pstmt.setTimestamp(8, post.getCreatedAt());
		pstmt.setInt(9, post.getCategoryId());
		pstmt.setInt(10, post.getId());

		pstmt.executeUpdate();
	}

	// Retrieves a single post by ID
	public Post getPost(int id) throws SQLException {
		String sql = "SELECT * FROM posts WHERE id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		rs.next();

		Post post = new Post();
		post.setId(rs.getInt(1));
		post.setTitle(rs.getString(2));
		post.setBody(rs.getString(3));
		post.setBackgroundColor(rs.getString(4));
		post.setOriginalFileName(rs.getString(5));
		post.setSavedFileName(rs.getString(6));
		post.setTempSaved(rs.getBoolean(7));
		post.setImportant(rs.getBoolean(8));
		post.setCreatedAt(rs.getTimestamp(9));
		post.setCategoryId(rs.getInt(10));
		return post;
	}

	// Retrieves all posts, ordered by latest created date
	public List<Post> getAllPosts() throws SQLException {
		List<Post> postList = new ArrayList<>();
		String sql = "SELECT * FROM posts ORDER BY created_at DESC";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			Post post = new Post();
			post.setId(rs.getInt(1));
			post.setTitle(rs.getString(2));
			post.setBody(rs.getString(3));
			post.setBackgroundColor(rs.getString(4));
			post.setOriginalFileName(rs.getString(5));
			post.setSavedFileName(rs.getString(6));
			post.setTempSaved(rs.getBoolean(7));
			post.setImportant(rs.getBoolean(8));
			post.setCreatedAt(rs.getTimestamp(9));
			post.setCategoryId(rs.getInt(10));
			postList.add(post);
		}
		return postList;
	}

	// Returns the next available post ID
	public int getNextPostId() throws SQLException {
		int nextPostId = 1;
		String sql = "SELECT COALESCE(MAX(id), 0) + 1 FROM posts";

		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			nextPostId = rs.getInt(1);
		}
		return nextPostId;
	}

	// Returns the total number of posts
	public int getTotalPostNum() throws SQLException {
		int totalPostNum = 0;
		String sql = "SELECT COUNT(*) FROM posts";

		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			totalPostNum = rs.getInt(1);
		}
		return totalPostNum;
	}

	// Deletes a post by ID
	public void deletePost(int id) throws SQLException {
		String sql = "DELETE FROM posts WHERE id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.executeUpdate();
	}

	// Returns the number of posts under a specific category
	public int getPostCountByCategoryId(int categoryId) throws SQLException {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM posts WHERE category_id = ?";
	    pstmt = con.prepareStatement(sql);
	    pstmt.setInt(1, categoryId);
	    rs = pstmt.executeQuery();
	    if (rs.next()) {
	        count = rs.getInt(1);
	    }
	    return count;
	}

	// Returns all posts under a specific category, ordered by date and ID
	public List<Post> getPostsByCategoryId(int categoryId) throws SQLException {
		List<Post> postList = new ArrayList<>();
		String sql = "SELECT * FROM posts WHERE category_id = ? ORDER BY created_at DESC, id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, categoryId);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			Post post = new Post();
			post.setId(rs.getInt(1));
			post.setTitle(rs.getString(2));
			post.setBody(rs.getString(3));
			post.setBackgroundColor(rs.getString(4));
			post.setOriginalFileName(rs.getString(5));
			post.setSavedFileName(rs.getString(6));
			post.setTempSaved(rs.getBoolean(7));
			post.setImportant(rs.getBoolean(8));
			post.setCreatedAt(rs.getTimestamp(9));
			post.setCategoryId(rs.getInt(10));
			postList.add(post);
		}
		return postList;
	}

	// Deletes all posts under a specific category
	public void deletePostsByCategoryId(int categoryId) throws SQLException {
	    String sql = "DELETE FROM posts WHERE category_id = ?";
	    pstmt = con.prepareStatement(sql);
	    pstmt.setInt(1, categoryId); 
	    pstmt.executeUpdate();
	}

	// Retrieves category name by given post ID
	public String getCategoryNameByPostId(int postId) throws SQLException {
	    String sql = "SELECT categories.name "
	               + "FROM posts JOIN categories ON posts.category_id = categories.id "
	               + "WHERE posts.id = ?";
	    
	    String categoryName = null;
	    pstmt = con.prepareStatement(sql);
	    pstmt.setInt(1, postId);
	    ResultSet rs = pstmt.executeQuery();
	    if (rs.next()) {
	        categoryName = rs.getString("name");
	    }
	    return categoryName;
	}

	// Helper: Maps a ResultSet row to a Post object
	private Post mapResultSetToPost(ResultSet rs) throws SQLException {
		Post post = new Post();
		post.setId(rs.getInt("id"));
		post.setTitle(rs.getString("title"));
		post.setBody(rs.getString("body"));
		post.setCreatedAt(rs.getTimestamp("created_at"));
		post.setBackgroundColor(rs.getString("background_color"));
		post.setSavedFileName(rs.getString("saved_file_name"));
		post.setImportant(rs.getBoolean("is_important"));
		post.setCategoryId(rs.getInt("category_id"));
		return post;
	}

	// Searches posts by title (keyword-based)
	public List<Post> searchPostsByTitle(String keyword) throws SQLException {
		List<Post> list = new ArrayList<>();
		String sql = "SELECT * FROM posts WHERE title LIKE ? ORDER BY created_at DESC, id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + keyword + "%");
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			list.add(mapResultSetToPost(rs));
		}
		return list;
	}

	// Searches posts by body (keyword-based)
	public List<Post> searchPostsByBody(String keyword) throws SQLException {
		List<Post> list = new ArrayList<>();
		String sql = "SELECT * FROM posts WHERE body LIKE ? ORDER BY created_at DESC, id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + keyword + "%");
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			list.add(mapResultSetToPost(rs));
		}
		return list;
	}

	// Closes all database resources
	public void close() throws SQLException {
		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		if (pstmt != null) pstmt.close();
		if (con != null) con.close();
	}
}