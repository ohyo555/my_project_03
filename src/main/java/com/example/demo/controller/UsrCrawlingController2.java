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
import java.util.ArrayList;
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

import com.example.demo.vo.News;
import com.example.demo.vo.Schedule;

@Controller
public class UsrCrawlingController2 {


	public static void main(String[] args) {
		UsrCrawlingController2 webCrawler = new UsrCrawlingController2();
		webCrawler.crawl();
	}

	public void crawl() {
		System.setProperty("webdriver.chrome.driver", "C:\\work\\sts-4.21.0.RELEASE-workspace\\myproject\\chromedriver.exe");

		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우

		// 웹 드라이버 초기화
		WebDriver driver = new ChromeDriver(options);

//		try {
//			String url = "https://sports.news.naver.com/volleyball/news/index?isphoto=N";
//			
//			driver.get(url);
//
//			List<WebElement> Elements = driver.findElements(By.cssSelector("#_newsList > ul > li"));
//			List<WebElement> imageElements = driver.findElements(By.cssSelector("#_newsList > ul > li > a > img"));
//			
//			for (WebElement Element : Elements) {
//	            String title = Element.getText();
//	            System.out.println(title);
//	        }
//
//			for (WebElement imageElement : imageElements) {
//			    String styleAttribute = imageElement.getAttribute("src");
//			    // 스타일 속성에서 URL 추출
//			    System.out.println("Image URL: " + styleAttribute);
//			}
//			
//			// 결과를 파일에 저장
//			//saveToFile(elements, "test.txt");

		try {
			String url = "https://m.blog.naver.com/guitarresca?categoryNo=0&tab=1";
			
			driver.get(url);
			String a = driver.findElement(By.cssSelector("#root > div.content__Lo0ig > div:nth-child(1) > div > div > div > div > div > a > span > span")).getText();
			String b = driver.findElement(By.xpath("//*[@id=\"root\"]/div[5]/div[1]/div/div/div/div/div/a/span/span")).getText();
			//String a = b.findElement(By.cssSelector(".desc__ikpIE")).getText();
			System.err.println("********aaa**************" + a);
			System.err.println("*********bbb*************" + b);
			/*
			 * WebElement button = driver.findElement(By.
			 * cssSelector("#snb > div.mod_group_option_filter._search_option_simple_wrap > div > div.option_area.type_sort > a:nth-child(2)"
			 * )); button.click();
			 * 
			 * List<WebElement> Elements = driver.findElements(By.
			 * cssSelector("#main_pack > section > div.api_subject_bx > div.group_news > ul > .bx"
			 * ));
			 * 
			 * for (WebElement Element : Elements) { String company_img =
			 * Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press > span > img"
			 * )).getAttribute("src"); String company_name = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press"
			 * )).getText(); String date = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > span"
			 * )).getText(); String title = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.news_tit"
			 * )).getText(); String content = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > div"))
			 * .getText(); // String title_img = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.dsc_thumb > img"
			 * )).getAttribute("src"); String title_img = Element.findElement(By.
			 * cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.dsc_thumb > img"
			 * )).getAttribute("src");
			 * 
			 * System.out.println(company_img); System.out.println(company_name);
			 * System.out.println(date); System.out.println(title);
			 * System.out.println(content); System.out.println(title_img); }
			 */
			//model.addAttribute("newsList", newsList);
			//*[@id="sp_nws4"]/div/div/div[2]/a[1]/img
			//*[@id="sp_nws5"]/div/div/div[2]/a[1]/img
			
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
