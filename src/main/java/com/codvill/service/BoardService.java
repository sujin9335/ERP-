package com.codvill.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.codvill.dao.BoardDao;

@Service
public class BoardService {

    @Value("${project.uploadpath}") // 파일 업로드 경로
    private String uploadPath;

    @Autowired
    BoardDao bD;

    public Object boardList(Map<String, Object> param) {
        JSONObject obj = bD.boardList(param);

        int total=(Integer) obj.get("total");
        List<Map<String, Object>> data=(List<Map<String, Object>>) obj.get("data");

        for (Map<String,Object> map : data) {
            // System.out.println(map.get("board_content"));
            String temp=(String) map.get("board_content");
            String js=Jsoup.parse(temp).text();
            System.out.println(js);
            if (js.length() >= 12) {
                map.put("board_content", js.substring(0, 12)+"..."); 
            }
        }

        JSONObject result=new JSONObject();
        result.put("data", data);
        result.put("total", total);

        System.out.println("======리스트======");
        System.out.println(data);
        System.out.println("======+++++======");
        return result;
    }

    public Object boardGet(Map<String, Object> param) {
        JSONObject obj = bD.boardGet(param);
        //System.out.println(obj);

        return obj;
    }

    public Object boardInsert(Map<String, Object> param, MultipartFile[] files) {
        // insert 처리 먼저
        JSONObject result=new JSONObject();
        int resultBoard = 0;
        int resultFileInsert = 0;
        
        resultBoard=bD.boardInsert(param);

        // insert 된 게시글 id값 가져오기
        String board_id = bD.getLast();

        for (MultipartFile file : files) {
            System.out.println("파일업로드처리");
            System.out.println(file.toString());
            // 파일 저장
            try {

                String originFileName = file.getOriginalFilename();

                // 파일명,확장자명 분리
                String realFileName = originFileName.substring(0, originFileName.lastIndexOf('.'));
                String fileExtension = originFileName.substring(originFileName.lastIndexOf('.') + 1);

                // 저장 파일명UUID
                UUID uuid = UUID.randomUUID();
                String fileSaveName = uuid+"."+fileExtension;
                // String fileName = file.getOriginalFilename();
                System.out.println("Uploaded File Name: " + fileSaveName);

                // 파일저장
                Path filePath = Paths.get(uploadPath, fileSaveName);
                Files.write(filePath, file.getBytes());

                // DB 저장
                resultFileInsert = bD.fileInsert(realFileName, uuid+"", fileExtension, uploadPath, board_id);

                // 콘솔 확인
                System.out.println();
                System.out.println("파일 확인");
                System.out.println(originFileName);
                System.out.println();

            } catch (IOException e) {

                e.printStackTrace();
            }

        }
        result.put("resultBoard", resultBoard);
        result.put("resultFileInsert", resultFileInsert);
        

        return result;
    }

    public Object boardUpdate(Map<String, Object> param, MultipartFile[] files) {
        JSONObject result=new JSONObject();
        int resultBoard = 0;
        int resultFileInsert = 0;
        int resultFileDel = 0;
        //게시글 업데이트
        resultBoard=bD.boardUpdate(param);

        //파일 삭제된거 관리(우선실행)
        //첨부된 파일 id
        JSONArray id=(JSONArray) param.get("file_id");

        //해당 게시글에 첨부된 파일 목록 가져오기
        List<Map<String, Object>> list=bD.fileList(param.get("board_id"));

        //게시글에 남아있는 파일 목록 String arr에 저장
        String[] fileIds = new String[id.size()];
        for (int i = 0; i < id.size(); i++) {
            fileIds[i] = (String) id.get(i);
        }

        //삭제할 파일 id저장 리스트
        List<String> delId=new ArrayList<>();

        //테이블에 있는 파일 id와 프론트에서 가져온 id 비교 
        for (Map<String,Object> map : list) {
            int temp= (Integer) map.get("file_id");
            String i = temp+"";
            int count=0;
            for (String ids : fileIds) {
                if (ids.equals(i)) {
                    count++;
                }
            }
            if (count == 0) {
                delId.add(i);
            }
        }

        //폴더에서 삭제할 파일 리스트
        List<Map<String, Object>> fileDelList=new ArrayList<>();
        for (Map<String,Object> map : list) {
            for (String str : delId) {
                if (map.get("file_id").toString().equals(str)) {
                    fileDelList.add(map);
                }
            }
        }

        //폴더에서 파일삭제
        fileDel(fileDelList);

        // System.out.println("==============");
        // System.out.println(fileDelList.toString());
        // System.out.println("============");
        // System.out.println("리스트");
        // System.out.println(list.toString());

        //DB에서 삭제
        if (delId.size() > 0) {
            for (String del : delId) {
                resultFileDel=bD.delFile(del);
                System.out.println();
                System.out.println("파일삭제 결과");
                System.out.println(resultFileDel);
                System.out.println();
                if (resultFileDel == -1)  {
                    break;
                }
            }
        }


        //새로 첨부된 파일 넣기
        String board_id = (String) param.get("board_id");

        for (MultipartFile file : files) {
            System.out.println("파일업로드처리");
            System.out.println(file.toString());
            // 파일 저장
            try {

                

                String originFileName = file.getOriginalFilename();

                // 파일명,확장자명 분리
                String realFileName = originFileName.substring(0, originFileName.lastIndexOf('.'));
                String fileExtension = originFileName.substring(originFileName.lastIndexOf('.') + 1);

                // 저장 파일명UUID
                UUID uuid = UUID.randomUUID();
                String fileSaveName = uuid+"."+fileExtension;
                // String fileName = file.getOriginalFilename();
                System.out.println("Uploaded File Name: " + fileSaveName);

                // 파일저장
                Path filePath = Paths.get(uploadPath, fileSaveName);
                Files.write(filePath, file.getBytes());

                // DB 저장
                resultFileInsert=bD.fileInsert(realFileName, uuid+"", fileExtension, uploadPath, board_id);

                // 콘솔 확인
                System.out.println();
                System.out.println("파일 확인");
                System.out.println(originFileName);
                System.out.println();

            } catch (IOException e) {

                e.printStackTrace();
            }

        }

        
        result.put("resultBoard", resultBoard);
        result.put("resultFileInsert", resultFileInsert);
        result.put("resultFileDel", resultFileDel);


        return result;
    }

    public Object boardDel(Map<String, Object> param) {
        JSONObject result=new JSONObject();
        //해당 게시글에 첨부된 파일 목록 가져오기
        List<Map<String, Object>> list=bD.fileList(param.get("board_id"));

        fileDel(list);

        int value=bD.boardDel(param);
        result.put("resultBoard", value);
        

        return result;
    }

    public void fileDel(List<Map<String, Object>> list) {

        //저장된 파일삭제 
        if(list.size() > 0) {
            for (Map<String,Object> map : list) {
                String fileName=map.get("file_save_name").toString() + "." + map.get("file_extension").toString();

                Path filePath = Paths.get(uploadPath, fileName).normalize().toAbsolutePath();
                try {
                    if (Files.deleteIfExists(filePath)) {
                        System.out.println("File deleted successfully: " + filePath);
                    } else {
                        System.out.println("File not found: " + filePath);
                    }
                } catch (IOException e) {
                    throw new RuntimeException("Failed to delete file", e);
                }
            }
        }
    }

    public ResponseEntity<byte[]> fileDown(String id) {
        // JSONObject obj=new JSONObject();
        Map<String, Object> list = bD.fileGet(id);
        System.out.println(list);

        //원래 파일명
        String fileName = (String) list.get("file_name")+ "."
                + (String) list.get("file_extension");

        //저장 파일명
        String savefileName = (String) list.get("file_save_name")+"."+(String) list.get("file_extension");

        System.out.println(fileName);
        System.out.println(savefileName);

        // 파일이 저장된 경로(테이블의 경로값 사용해서 다운로드 해봄)
        String savename = (String)list.get("file_path")+"\\"+savefileName;
        // String savename = "C:\\upload\\파일2^!78.txt";
        File file = new File(savename);

        byte[] result = null;// 1. data
        ResponseEntity<byte[]> entity = null;

        try {
            result = FileCopyUtils.copyToByteArray(file);

            // 2. header
            HttpHeaders header = new HttpHeaders();

            
            //파일이름 인코더(다운받을때의 파일명)
            String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8);
            // 다운로드임을 명시
            header.add("Content-Disposition", "attachment; filename=" + encodedFileName);

            // 3. 응답본문
            entity = new ResponseEntity<>(result, header, HttpStatus.OK);// 데이터, 헤더, 상태값
        } catch (NoSuchFileException e) {
            e.printStackTrace();
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", "text/plain; charset=UTF-8");
            entity = new ResponseEntity<>("파일을 찾을 수 없습니다.".getBytes(), header, HttpStatus.NOT_FOUND);
        } catch (IOException e) {
            e.printStackTrace();
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", "text/plain; charset=UTF-8");
            entity = new ResponseEntity<>("파일을 읽는 중 오류가 발생했습니다.".getBytes(), header, HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", "text/plain; charset=UTF-8");
            entity = new ResponseEntity<>("알 수 없는 오류가 발생했습니다.".getBytes(), header, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return entity;
    }

}
