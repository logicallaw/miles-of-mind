package mariadb_api;

import javax.naming.*;
import java.sql.*;
import javax.sql.*;

public class ConnectionPool {
	public static Connection getConnection() throws SQLException, NamingException {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/memodb");
		return ds.getConnection();
	}
}
