package com.example.demo.controller;

import java.io.FileWriter;
import java.io.IOException;
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
	    	// 크롤링할 웹 페이지 URL
	        String url = "https://kovo.co.kr/KOVO/game/v-league?first=%EC%9D%BC%EC%A0%95+%EB%B0%8F+%EA%B2%B0%EA%B3%BC";
	        // 웹 페이지 열기
	        driver.get(url);

	        // 웹 페이지 로드를 위한 대기
	        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
	        WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector(".ant-radio-group input[value='여자부']")));
	        element.click();

//	        WebElement radiobox = driver.findElement(By.cssSelector(".ant-radio-button"));
//	        Select dropdown = new Select(radiobox);
//	        dropdown.selectByVisibleText("여자부");
	        
//	        By radioSelector = By.cssSelector(".ant-radio-group input[value='여자부']");
//            WebElement radioElement = wait.until(ExpectedConditions.presenceOfElementLocated(radioSelector));

            // 라디오 버튼 클릭
//            radioElement.click();
            
	        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".relative"))); 
	        
	        List<WebElement> elements = driver.findElements(By.cssSelector(".relative"));
	        
//	        saveToFile(elements, "output.txt");
//	        
	        for (WebElement element1 : elements) {
	            String title = element1.getText();
	            System.out.println(title);
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
        saveToFile(elements, "test.txt");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 웹 드라이버 종료
        driver.quit();
    }
}


	private void saveToFile(List<WebElement> elements, String fileName) {
		try (FileWriter writer = new FileWriter(fileName)) {
	        for (WebElement element : elements) {
	            String title1 = element.findElement(By.cssSelector(".title")).getText();
	            writer.write(title1 + "\n");
//	            System.out.println(title1);
	        }
	        System.out.println("데이터를 파일에 저장했습니다.");
	    } catch (IOException e) {
	        e.printStackTrace();
	        System.err.println("파일 저장 중 오류가 발생했습니다.");
	    }
	}
	
    public static void main(String[] args) {
    	UsrCrawlingController webCrawler = new UsrCrawlingController();
        webCrawler.crawl();
    }
}
	