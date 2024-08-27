package com.codvill.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.codvill.service.BoardService;


@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService bs;

    @Value("${project.uploadpath}") //파일 업로드 경로
    private String uploadPath;
 
    @GetMapping("/")
    public String board(){
        return "/board";
    }

    @GetMapping("/form")
    public String form () {
        return "/form";
    }
    
    

    @PostMapping("/list")
    @ResponseBody
    public Object list(@RequestBody Map<String, Object> param) {

        JSONObject objData = (JSONObject) bs.boardList(param);
        System.out.println("list 작동");
        System.out.println(param);
        
        return objData;
    }

    @PostMapping("/get")
    @ResponseBody
    public Object get(@RequestBody Map<String, Object> param) {
        System.out.println("get 작동");
        System.out.println(param);
        JSONObject objData = (JSONObject) bs.boardGet(param);
        // JSONObject data = new JSONObject();
        // System.out.println(data);

        return objData;
    }

    // @PostMapping("/insert")
    // @ResponseBody
    // public Object insert(@RequestBody Map<String, Object> param) {
    //     System.out.println("insert 작동");
    //     System.out.println(param);
    //     // JSONObject data = new JSONObject();
    //     JSONObject objData = (JSONObject) bs.boardInsert(param);
    //     System.out.println(objData);

    //     return objData;
    // }

    @PostMapping("/insert")
    @ResponseBody
    public Object insert(@RequestParam("files") MultipartFile[] files, @RequestParam("param") String param) throws Exception{
        System.out.println("파일업로드");
        System.out.println(files.length);

        JSONParser parser = new JSONParser();
		JSONObject jo = new JSONObject();
        jo = (JSONObject) parser.parse(param);
        JSONObject data = new JSONObject();

        //게시글 insert
        data=(JSONObject) bs.boardInsert(jo, files);

        //System.out.println(jo.toString());


        System.out.println("파일업로드처리완");
        // JSONObject objData = (JSONObject) bs.fileUpload(param);
        // System.out.println(objData);

        return data;
    }

    @PostMapping("/update")
    @ResponseBody
    public Object update(@RequestParam("files") MultipartFile[] files, @RequestParam("param") String param) throws Exception{
        System.out.println();
        System.out.println("update 작동");

        //문자열로 받아온 JSON형식의 Param 값을 JSONObject 형식으로 변환 함
        //- ObjectMapper objectMapper = new ObjectMapper(); 사용해서 Map형식으로 변환하는게 나은듯
        JSONParser parser = new JSONParser();
		JSONObject jo = new JSONObject();

        jo = (JSONObject) parser.parse(param);
        
        //게시글 update
        JSONObject data = new JSONObject();
        data=(JSONObject) bs.boardUpdate(jo, files);
        


        // System.out.println(jo);

        // System.out.println(jo.get("file_id"));

        // System.out.println();
        
        
        // JSONObject objData = (JSONObject) bs.boardUpdate(param);
        // System.out.println(data);

        

        return data;
    }

    @PostMapping("/del")
    @ResponseBody
    public Object del(@RequestBody Map<String, Object> param) {
        System.out.println("del 작동");
        System.out.println(param);
        // JSONObject data = new JSONObject();
        JSONObject objData = (JSONObject) bs.boardDel(param);
        System.out.println(objData);

        return objData;
    }

    
    @PostMapping("/fileUpload")
    @ResponseBody
    public Object fileUpload(@RequestParam("files") MultipartFile[] files, @RequestParam("param") String param) throws Exception{
        System.out.println("파일업로드");
        System.out.println(Arrays.toString(files));

        JSONParser parser = new JSONParser();
		JSONObject jo = new JSONObject();
        jo = (JSONObject) parser.parse(param);

        //게시글 insert
        bs.boardInsert(jo, files);

        //System.out.println(jo.toString());

        if (files.length == 0) {
            System.out.println("데이터없음");
        }

        System.out.println("파일업로드처리완");
        JSONObject data = new JSONObject();
        // JSONObject objData = (JSONObject) bs.fileUpload(param);
        // System.out.println(objData);

        


        return data;
    }

    @GetMapping("/fileDown/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> fileDown(@PathVariable("id")String id) {
        System.out.println("fileDown 작동");
        System.out.println(id);
        JSONObject data = new JSONObject();
        
        System.out.println(data);

        return bs.fileDown(id);
    }

   
    
    
}
