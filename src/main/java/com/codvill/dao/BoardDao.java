package com.codvill.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDao {

	private static final Logger logger = LoggerFactory.getLogger(BoardDao.class);
	static JdbcTemplate jt;

	@Autowired
	@Resource(name = "dataSource")
	DataSource ds;

	String dbType = "";

	private boolean isLoaded;

	@PostConstruct
	public void init() {
		new Thread(this::loadDatasource).start();
	}

	// 처음 실행시 디비가 제대로 실행되지 않은상태라면
	// 아래 로직을 실행하다 전체 서비스가 중단된다.
	// 이를 막기위해 쓰레드로 동작하게처리함.
	private void loadDatasource() {

		while (!isLoaded) {
			try {
				jt = new JdbcTemplate(ds);
				// dbType = getDbType();
				isLoaded = true;
			} catch (Exception e) {
				isLoaded = false;
				try {
					Thread.sleep(1000L);
				} catch (Exception ignored) {
				}
			}
		}
	}//

	public JSONObject boardList(Map<String, Object> param) {
		System.out.println("list");
		int offset = (Integer) param.get("offset");
		int listSize = (Integer) param.get("listSize");
		String searchType = (String) param.get("searchType");

		String search = (String) param.get("search");
		if (searchType == null) {
			searchType = "board_title";
		}
		if (search == null) {
			search = "";
		}

		System.out.println(searchType + " +타입+ " + search);

		// 리스트
		String sqlFist = "select board_id, board_title, board_content, tb.user_id, DATE_FORMAT(board_date, '%Y-%m-%d %H:%i') AS board_date, board_view, tu.user_login_id ";
		// String sql="select board_id, board_title, board_content, user_id,
		// DATE_FORMAT(board_date, '%Y-%m-%d %H:%i') AS board_date, board_view from
		// tbl_board tb ORDER BY board_id DESC";
		String sqlLast = String.format(
				"from tbl_board tb " +
						"inner join tbl_user tu " +
						"on tb.user_id = tu.user_id " +
						"WHERE %s LIKE '%%%s%%' " +
						"ORDER BY board_id DESC " +
						"LIMIT %d OFFSET %d ",
				searchType, search, listSize, offset);

		String sql = sqlFist + sqlLast;
		System.out.println(sql);
		List<Map<String, Object>> list = jt.queryForList(sql);

		// 총 갯수
		sql = String.format("select count(*) from tbl_board WHERE %s LIKE '%%%s%%'", searchType, search);
		// System.out.println(sql);
		int total = jt.queryForObject(sql, Integer.class);
		// System.out.println(total);

		JSONObject result = new JSONObject();

		result.put("data", list);
		result.put("total", total);

		System.out.println("==========================================================");
		System.out.println(listSize +" : " +offset);
		System.out.println("==========================================================");
		return result;


	}

	public JSONObject boardGet(Map<String, Object> param) {
		JSONObject result = new JSONObject();
		int id = (Integer) param.get("board_id");

		// 조회수 증가
		String sql = String.format("UPDATE tbl_board " +
				"SET board_view = (select board_view from tbl_board where board_id = %d)+1 " +
				"WHERE board_id = %d", id, id);
		jt.queryForList(sql);
		// System.out.println("조회수");
		// System.out.println(sql);

		// get
		sql = "SELECT board_id, board_title, board_content, tb.user_id, DATE_FORMAT(board_date, '%Y-%m-%d') AS board_date, board_view, tu.user_login_id "
				+
				"FROM tbl_board tb " +
				"inner join tbl_user tu " +
				"on tb.user_id = tu.user_id " +
				"WHERE board_id = ?";
		List<Map<String, Object>> get = jt.queryForList(sql, id);

		// 파일 조회
		sql = String.format("select * from tbl_file where board_id=%d", id);
		List<Map<String, Object>> files = jt.queryForList(sql);
		for (Map<String, Object> map : files) {
			String temp = (String) map.get("file_name");
			// System.out.println("파일이름조회");
			// System.out.println(temp);
			map.put("file_name", temp);
		}

		result.put("data", get);
		result.put("files", files);

		return result;
	}

	public int boardInsert(Map<String, Object> param) {
		int value = -1;

		String title = (String) param.get("board_title");
		String content = (String) param.get("board_content");
		String id = (String) param.get("user_id");

		String sql = String.format("INSERT INTO tbl_board (board_title, board_content, user_id) " +
				"VALUES ('%s', '%s', %s)", title, content, id);

		// System.out.println(sql);

		// Object get = jt.queryForList(sql);
		try {
			value = jt.update(sql);
		} catch (Exception e) {
			System.out.println("board Insert 에러 발생");
		}

		System.out.println("insert 실행");
		// System.out.println(get);

		System.out.println();
		System.out.println("인서트 결과");

		return value;
	}

	public int boardUpdate(Map<String, Object> param) {
		int value = -1;

		String title = (String) param.get("board_title");
		String content = (String) param.get("board_content");
		String id = (String) param.get("board_id");

		String sql = String.format("UPDATE tbl_board " +
				"SET board_title = '%s', board_content = '%s' " +
				"WHERE board_id = %s", title, content, id);

		System.out.println(sql);

		try {
			value = jt.update(sql);
		} catch (Exception e) {
			System.out.println("board update 에러 발생");
		}
		System.out.println("update 실행");

		return value;
	}

	public int boardDel(Map<String, Object> param) {
		int value = -1;
		String id = (String) param.get("board_id");

		String sql = String.format("DELETE FROM tbl_board " +
				"WHERE board_id = %s", id);

		// System.out.println(sql);

		try {
			value = jt.update(sql);
		} catch (Exception e) {
			System.out.println("board delete 에러 발생");
		}
		System.out.println("del 실행");

		JSONObject result = new JSONObject();
		result.put("result", value);

		return value;
	}

	public String getLast() {
		System.out.println("마지막데이터조회");
		String sql = "SELECT board_id " +
				"FROM tbl_board tb " +
				"ORDER BY board_id DESC " +
				"LIMIT 1";

		return jt.queryForObject(sql, String.class);
	}

	public int fileInsert(String fileName, String fileSaveName, String fileExtension, String uploadPath,
			String board_id) {
		String sql = String.format(
				"INSERT INTO tbl_file (file_name, file_save_name, file_extension, file_path, board_id) " +
						"VALUES ('%s', '%s', '%s', '%s', %s)",
				fileName, fileSaveName, fileExtension, uploadPath, board_id);

		int value = -1;
		try {
			value = jt.update(sql);
		} catch (Exception e) {
			System.out.println("file insert 에러 발생");
		}

		return value;
	}

	public Map<String, Object> fileGet(String id) {
		String sql = String.format("SELECT * " +
				"FROM tbl_file " +
				"WHERE file_id = '%s' ", id);

		// System.out.println(sql);

		// jt.queryForList(sql);

		Map<String, Object> list = jt.queryForMap(sql);

		return list;
	}

	public List<Map<String, Object>> fileList(Object board_id) {
		List<Map<String, Object>> list;
		String id = (String) board_id;

		String sql = String.format("SELECT * " +
				"FROM tbl_file " +
				"WHERE board_id = '%s' ", id);
		System.out.println(sql);

		list = jt.queryForList(sql);

		return list;
	}

	public int delFile(String id) {
		System.out.println("delFile 작동");

		String sql = String.format("DELETE FROM tbl_file " +
				"WHERE file_id = %s", id);

		int value = -1;
		try {
			value = jt.update(sql);
		} catch (Exception e) {
			System.out.println("file delete 에러 발생");
		}

		return value;
	}

}
