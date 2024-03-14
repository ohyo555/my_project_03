package com.example.demo.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Controller;

@Controller
public class UsrCrawlingController {
	
	public void crawl() {
		// 크롬 드라이버 경로 설정 (크롬 드라이버 설치 필요)
		System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");
		// 크롬 옵션 설정
	    ChromeOptions options = new ChromeOptions();
	    options.addArguments("--headless");
	    // 웹 드라이버 초기화
	    WebDriver driver = new ChromeDriver(options);
	    
	    try {
	    	// 크롤링할 웹 페이지 URLredsparks
	        String url = "https://kovo.co.kr/KOVO/game/v-league?first=%EC%9D%BC%EC%A0%95+%EB%B0%8F+%EA%B2%B0%EA%B3%BC";
	        // 웹 페이지 열기
	        driver.get(url);

	        // 웹 페이지 로드를 위한 대기
	        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
	        
	        // 라디오 버튼이 선택된 후에 나타나는 요소를 기다림
	        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".relative"))); 
//	        
	        List<WebElement> elements = driver.findElements(By.cssSelector(".relative"));
	        
	        // 결과를 파일에 저장
//	        saveToFile(elements, "output.txt");
	        for (WebElement element : elements) {
                String text = element.getText();
                System.out.println(text);
            }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        driver.quit();
	    }
    }
	
	public void crawl3() {
	// 크롬 드라이버 경로 설정 (크롬 드라이버 설치 필요)
    System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

    // 크롬 옵션 설정
    ChromeOptions options = new ChromeOptions();
    options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우

    // 웹 드라이버 초기화
    WebDriver driver = new ChromeDriver(options);

    try {
        // 크롤링할 웹 페이지 URL
        String url = "https://sports.news.naver.com/volleyball/news/index?isphoto=N";
        // 웹 페이지 열기
        driver.get(url);

        // TOP 100 곡을 담고 있는 요소들 찾기
        List<WebElement> elements = driver.findElements(By.cssSelector(".text")); // TOP 50 과 TOP 100 곡을 모두 포함하는 클래스 선택자
        // 결과를 파일에 저장
        // saveToFile(elements, "test.txt");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 웹 드라이버 종료
        driver.quit();
    }
}
	

	public void crawl2() {
		// 크롬 드라이버 경로 설정 (크롬 드라이버 설치 필요)
				System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");
				// 크롬 옵션 설정
			    ChromeOptions options = new ChromeOptions();
			    options.addArguments("--headless");
			    // 웹 드라이버 초기화
			    WebDriver driver = new ChromeDriver(options);
			    
			    try {
			    	// 크롤링할 웹 페이지 URL
			        String url = "https://kovo.co.kr/redsparks/game/v-league?first=%EC%9D%BC%EC%A0%95+%EB%B0%8F+%EA%B2%B0%EA%B3%BC";
			        // 웹 페이지 열기
			        driver.get(url);

			        // 웹 페이지 로드를 위한 대기
			        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
			        
			        // 요소를 기다림
			        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("tr"))); 
	        
			        List<WebElement> elements = driver.findElements(By.cssSelector("tr"));

			        // CSV 파일에 데이터 쓰기
		            saveToCSV(elements, "output.csv");
		            saveToFile(elements, "rs.txt");
		            saveToCSV2(elements, "123.csv");
		            
			        for (WebElement element : elements) {
		                String text = element.getText();
		                System.out.println(text);
		            }

			    } catch (Exception e) {
			        e.printStackTrace();
			    } finally {
			        driver.quit();
			    }
}


	
	private void saveToCSV(List<WebElement> elements, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), StandardCharsets.UTF_8))) {
            // CSV 헤더 작성 (필요에 따라 수정)
        	writer.write("\uFEFF");
            writer.write("날짜,순번,구분,경기,시간,구장,중계일정,라운드,비고\n");
//
//            for(int i = 1; i < elements.size(); i++) {
//        		for(int j = 1; j <= 9; j++) {
//        			WebElement title = elements.get(i);
//        			WebElement text = title.findElement(By.xpath("//*[@id=\"root\"]/article/div/article/section/article/section[2]/article/section[2]/table/tbody/tr[" + i + "]/td[" + j + "]"));
//        			String t = text.getText().replace("\n", ",");
//                	writer.write(t);
//                    writer.newLine();
//        		}	
//        	};
//        	
        	for(int i = 1; i < elements.size(); i++) {
        		for(int j = 1; j <= 9; j++) {
        			WebElement title = elements.get(i);
        			WebElement text = title.findElement(By.xpath("//*[@id=\"root\"]/article/div/article/section/article/section[2]/article/section[2]/table/tbody/tr[" + i + "]/td[" + j + "]"));
        			String t = text.getText().replace("\n", ",").replace(")","),").replace("여자", ",여자,").replace("19", ",19").replace("16", ",16").replace(":00",":00,").replace(":30",":30,").replace("육관","육관,").replace("움","움,").replace("ER","ER,").replace("nd","nd,");
                	
        			if (t.contains("(")) { // "결과"라는 문자열이 포함된 경우
                        writer.write("\n"); // 새로운 행으로 이동
                    }
        			
                	writer.write(t);
        		}	
        	};
//        	for (int i = 1; i <= 37; i++) { // Iterate through each row (tr)
//        	    WebElement row = driver.findElement(By.xpath("//*[@id=\"root\"]/article/div/article/section/article/section[2]/article/section[2]/table/tbody/tr[" + i + "]"));
//        	    WebElement cell = row.findElement(By.xpath("./td[9]")); // Get the 9th column (td[9]) within the current row
//        	    String text = cell.getText();
//        	    writer.write(text + "\n");
//        	}
//        	
        	
//            for (WebElement element : elements) {
//                // 가져온 데이터를 CSV 파일에 작성 (필요에 따라 수정)
//            	//String title = element.findElement(By.cssSelector("td")).getText();
//            	String text = element.getText().replace("\n", ",");
//                writer.write(text);
//                writer.newLine();
//            }
            System.out.println("csv 파일 저장!!!");
        }
    }

	private void saveToFile(List<WebElement> elements, String fileName) throws IOException {
        FileWriter writer = new FileWriter(fileName);
        System.out.println(elements.size());

        	for(int i = 1; i < elements.size(); i++) {
        		for(int j = 1; j <= 9; j++) {
        			WebElement title = elements.get(i);
        			WebElement text = title.findElement(By.xpath("//*[@id=\"root\"]/article/div/article/section/article/section[2]/article/section[2]/table/tbody/tr[" + i + "]/td[" + j + "]"));
        			String t = text.getText().replace("\n", ",").replace(")","),").replace("여자", ",여자,").replace("19", ",19").replace("16", ",16").replace(":00",":00,").replace(":30",":30,").replace("육관","육관,").replace("움","움,").replace("ER","ER,").replace("nd","nd,");
        			String a = t.replace(".,", ".").replace(",,", ",");
        			if (a.contains("(")) { // "결과"라는 문자열이 포함된 경우
                        writer.write("\n"); // 새로운 행으로 이동
                    }
        			
                	writer.write(a);
        		}	
        	};
        
        writer.close();
        System.out.println("데이터를 파일에 저장했습니다.");
        
        String inputFilePath = "rs.txt";
        String outputFilePath = "111111111.csv";
        String delimiter = ","; // 텍스트 파일에서 사용하는 구분자 설정
        
        try (BufferedReader reader = new BufferedReader(new FileReader(inputFilePath));
             BufferedWriter writer2 = new BufferedWriter(new FileWriter(outputFilePath))) {
            String line;
            
            writer2.write("\uFEFF");
            
            while ((line = reader.readLine()) != null) {
                String[] fields = line.split(delimiter); // 구분자를 기준으로 줄을 분할
                for (int i = 0; i < fields.length; i++) {
                    writer2.write(fields[i]);
                    if (i < fields.length - 1) {
                        writer2.write(","); // 필드 사이에 쉼표 추가
                    }
                }
                writer2.newLine(); // CSV 파일에서 다음 줄로 이동
            }
            System.out.println("텍스트 파일이 성공적으로 CSV로 변환되었습니다!");
        } catch (IOException e) {
            System.err.println("오류: " + e.getMessage());
        }
    }
	
	private void saveToCSV2(List<WebElement> elements, String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), StandardCharsets.UTF_8))) {
            // CSV 헤더 작성 (필요에 따라 수정)
        	writer.write("\uFEFF");
            writer.write("날짜,순번,구분,경기,시간,구장,중계일정,라운드,비고\n");

        for(int i = 1; i < elements.size(); i++) {
    		for(int j = 1; j <= 9; j++) {
    			WebElement title = elements.get(i);
    			WebElement text = title.findElement(By.xpath("//*[@id=\"root\"]/article/div/article/section/article/section[2]/article/section[2]/table/tbody/tr[" + i + "]/td[" + j + "]"));
//    			String a = text.getText() + ",";
    			String t = text.getText().replace("\n", ",").replace(" (", ",(").replace(")","),").replace("여자", "여자,").replace(":00",":00,").replace(":30",":30,").replace("육관","육관,").replace("움","움,").replace("ER","ER,").replace("nd","nd,");
            	
    			writer.write(t);
                writer.newLine();
    		}	
    	};
    	
        writer.close();
        System.out.println("데이터를 파일에 저장했습니다.");
    }}
	
	
	public static void main(String[] args) {
    	UsrCrawlingController webCrawler = new UsrCrawlingController();
        webCrawler.crawl2();
    }
}
	