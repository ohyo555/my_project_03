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
public class UsrCrawlingController3 {


	public static void main(String[] args) {
		UsrCrawlingController3 webCrawler = new UsrCrawlingController3();
		webCrawler.crawl();
	}

	public void crawl() {
		System.setProperty("webdriver.chrome.driver", "C:\\OHJ\\sts-4.22.0.RELEASE-workspace\\my_project_03\\chromedriver.exe");

		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우

		// 웹 드라이버 초기화
		WebDriver driver = new ChromeDriver(options);

		try {
			String url = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=%EC%A0%95%EA%B4%80%EC%9E%A5+%EB%A0%88%EB%93%9C%EC%8A%A4%ED%8C%8C%ED%81%AC%EC%8A%A4";
			
			driver.get(url);
			
			 WebElement button = driver.findElement(By.cssSelector("#snb > div.mod_group_option_filter._search_option_simple_wrap > div > div.option_area.type_sort > a:nth-child(2)"));
			 button.click();

			List<WebElement> Elements = driver.findElements(By.cssSelector("#main_pack > section > div.api_subject_bx > div.group_news > ul > .bx"));

			for (WebElement Element : Elements) {
	            String company_img = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press > span > img")).getAttribute("src");
	            String company_name = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press")).getText();
	            String date = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_info > div.info_group > span")).getText();
	            String title = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_contents > a.news_tit")).getText();
	            String content = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_contents > div")).getText();
	            String title_img = Element.findElement(By.cssSelector(".bx > div.news_wrap.api_ani_send > div > div.news_contents > a.dsc_thumb > img")).getAttribute("src");
	            System.out.println(company_img);
	            System.out.println(company_name);
	            System.out.println(date);
	            System.out.println(title);
	            System.out.println(content);
	            System.out.println(title_img);
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
