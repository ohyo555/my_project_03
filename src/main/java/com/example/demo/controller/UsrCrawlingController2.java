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
public class UsrCrawlingController2 {


	public static void main(String[] args) {
		UsrCrawlingController2 webCrawler = new UsrCrawlingController2();
		webCrawler.crawl();
	}

	public void crawl() {
		System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우

		// 웹 드라이버 초기화
		WebDriver driver = new ChromeDriver(options);

		try {
			String url = "https://sports.news.naver.com/volleyball/news/index?isphoto=N";
			
			driver.get(url);

			List<WebElement> elements = driver.findElements(By.cssSelector("#_newsList > ul > li"));
			
			for (WebElement element : elements) {
	            String title = element.getText();
	            System.out.println(title);
	        }
			
			// 결과를 파일에 저장
			//saveToFile(elements, "test.txt");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 웹 드라이버 종료
			driver.quit();
		}
	}

	// txt 파일 저장
		private void saveToFile(List<WebElement> elements, String fileName) throws IOException {
			FileWriter writer = new FileWriter(fileName);
			System.out.println(elements.size());

			for (int i = 1; i < elements.size(); i++) {

				for (int j = 1; j <= 9; j++) {
					WebElement title = elements.get(i);
					// String text = title.findElement(By.cssSelector(".text"));

					// writer.write(text);
				}
			}
		}
}
