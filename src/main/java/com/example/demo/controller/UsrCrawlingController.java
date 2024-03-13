package com.example.demo.controller;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
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
            writer.write("Column1,Column2,Column3\n");

            for (WebElement element : elements) {
                // 가져온 데이터를 CSV 파일에 작성 (필요에 따라 수정)
                String text = element.getText().replace("\n", ",");
                writer.write(text);
                writer.newLine();
            }
            System.out.println("csv 파일 저장!!!");
        }
    }

	public static void main(String[] args) {
    	UsrCrawlingController webCrawler = new UsrCrawlingController();
        webCrawler.crawl2();
    }
}
	