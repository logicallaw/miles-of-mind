package mariadb_api;

import javax.naming.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDB {
	private Connection con;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	// Constructor: initializes database connection using connection pool
	public CategoryDB() throws SQLException, NamingException {
		con = ConnectionPool.getConnection();
	} 
	
	// Inserts a new category into the database
	public void insertCategory(Category category) throws SQLException {
		String sql = "INSERT INTO categories(name) VALUES(?)";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, category.getName());
		pstmt.executeUpdate();
	}
	
	// Updates the name of an existing category (identified by its ID)
	public void updateCategoryName(Category category) throws SQLException {
		String sql = "UPDATE categories SET name = ? WHERE id = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, category.getName());
		pstmt.setInt(2, category.getId());
		pstmt.executeUpdate();
	}
	
	// Returns the total number of categories in the table
	public int getTotalCategoryCount() throws SQLException {
	    int totalCategoryNum = 0;
	    String sql = "SELECT COUNT(*) FROM categories";
	    
	    pstmt = con.prepareStatement(sql);
	    rs = pstmt.executeQuery();
	    
	    if (rs.next()) {
	        totalCategoryNum = rs.getInt(1);  // Get the count from the first column
	    }

	    return totalCategoryNum;
	}
	
	// Deletes a category by its ID
	public void deleteCategory(int id) throws SQLException {
		String sql = "DELETE FROM categories WHERE id = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.executeUpdate();
	}
	
	// Retrieves a list of all categories ordered by ID (ascending)
	public List<Category> getAllCategories() throws SQLException {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT id, name FROM categories ORDER BY id ASC";
		
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Category category = new Category();
			category.setId(rs.getInt("id"));         // Set category ID
			category.setName(rs.getString("name"));  // Set category name
			categories.add(category);                // Add to list
		}
		
		return categories;
	}
	
	// Closes all database resources
	public void close() throws SQLException {
		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		if (pstmt != null) pstmt.close();
		if (con != null) con.close();
	}
}