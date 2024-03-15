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
import java.util.StringTokenizer;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Controller;

import com.example.demo.vo.Schedule;

@Controller
public class UsrCrawlingController {
	
	private static final String PERSISTENCE_UNIT_NAME = "YourPersistenceUnitName"; // JPA (Java Persistence API)에서 사용되는 영속성 단위의 이름
	
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
		            //saveToCSV(elements, "output.csv");
		            saveToFile(elements, "result.txt");
			        
			        for (WebElement element : elements) {
		                String text = element.getText();
		                //System.out.println(text);
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
        			String t = text.getText().replace("\n", ",").replace(")","),").replace("여자", ",여자,").replace("19", ",19").replace("16", ",16").replace(":00",":00,").replace(":30",":30,");
        			t = t.replace("육관","육관,").replace("움","움,").replace("ER","ER,").replace("nd","nd,");
        			t = t.replace("트,상", "트 상").replace("트,전", "트 전").replace("교,하", "교 하");
        			t = t.replace(".,", ".").replace(" , ", " ");
        			// t = t.replace("),,", "),");

        			if (t.contains("(")) { // "결과"라는 문자열이 포함된 경우
                        writer.write("\n"); // 새로운 행으로 이동
                    }

                	writer.write(t);
        		}	
        	};
        
        writer.close();
        System.out.println("데이터를 파일에 저장했습니다.");
      
    }

	public static void main(String[] args) {
    	UsrCrawlingController webCrawler = new UsrCrawlingController();
        //webCrawler.crawl2();
    	
//    	 txt -> csv
    	String textFilePath = "result.txt"; 
        String csvFilePath = "result.csv";

        try {
            convertTextToCSV(textFilePath, csvFilePath);
            System.out.println("Conversion completed successfully.");
        } catch (IOException e) {
            System.err.println("Error occurred during conversion: " + e.getMessage());
        }
    }

    public static void convertTextToCSV(String textFilePath, String csvFilePath) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(textFilePath));
        FileWriter writer = new FileWriter(csvFilePath);
        writer.write("\uFEFF");
        String line = null;
        writer.write("날짜,순번,구분,시간,구장,중계일정,라운드,비고,경기\n");
        
        while ((line = reader.readLine()) != null) {
        
        	StringTokenizer tokenizer = new StringTokenizer(line, ",");
        	
        	int index = 0; // 인덱스 카운터를 초기화합니다.
            StringBuilder concatenatedToken = new StringBuilder(); // 토큰을 결합할 StringBuilder를 초기화합니다.
            // 각 데이터를 다음 행의 새 셀에 쓰도록 합니다.
            while (tokenizer.hasMoreTokens()) {
            	
                String token = tokenizer.nextToken().trim();
                
                if (index >= 3 && index <= 5) { // 인덱스가 세 번째, 네 번째 또는 다섯 번째인지 확인합니다.
                    concatenatedToken.append(token); // 토큰을 StringBuilder에 추가합니다.
                    if (index != 5) { // 마지막 토큰이 아닌 경우에만 공백을 추가합니다.
                        concatenatedToken.append(" ");
                    }
                    
                } else if (index == 11) { // 인덱스가 아홉 번째인 경우
                    concatenatedToken.append(",").append(token); // 쉼표와 함께 토큰을 추가합니다.
                } else {
                    System.out.println("인덱스: " + index + ", 토큰: " + token); // 인덱스와 토큰을 출력합니다.
                    writer.write(token + ",");
                }
                index++; // 인덱스 카운터를 증가시킵니다.
            }
            // 결합된 토큰을 단일 토큰으로 쓰도록 합니다.
            // System.out.println("인덱스: 2-4, 결합된 토큰: " + concatenatedToken.toString());
            writer.write(concatenatedToken.toString() + ",");
            writer.write("\n");
        }
        reader.close();
        writer.close();
    	
    }
    
//    public static void file() {
//        String csvFile = "result.csv";
//
//        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//        EntityTransaction transaction = entityManager.getTransaction();
//
//        try (BufferedReader reader = new BufferedReader(new FileReader(csvFile))) {
//            transaction.begin();
//
//            String line;
//            while ((line = reader.readLine()) != null) {
//                String[] data = line.split(","); // CSV가 쉼표로 구분된 값을 가진다고 가정
//                Schedule schedule = new Schedule(); // 데이터를 엔티티로 변환
//
//                entityManager.persist(schedule);
//            }
//
//            transaction.commit();
//            System.out.println("데이터가 성공적으로 삽입되었습니다.");
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//            entityManager.close();
//            entityManagerFactory.close();
//        }
//    }
    
}
