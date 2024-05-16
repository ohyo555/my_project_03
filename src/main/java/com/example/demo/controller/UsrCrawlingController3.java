package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Component;

import com.example.demo.vo.News;

@Component
public class UsrCrawlingController3 {

	// 네이버 기사 크롤링
	public List<News> crawl() {
		
		// 크롬드라이버 경로 설정
		// System.setProperty("webdriver.chrome.driver", "C:\\OHJ\\sts-4.22.0.RELEASE-workspace\\my_project_03\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", "C:\\work\\sts-4.21.0.RELEASE-workspace\\myproject\\chromedriver.exe");
		
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우
		
		// 뉴스 내용을 담을 리스트
		List<News> newsList = new ArrayList<>();

		// 웹 드라이버 초기화
		WebDriver driver = new ChromeDriver(options);

		try {
			String url = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=%EC%A0%95%EA%B4%80%EC%9E%A5+%EB%A0%88%EB%93%9C%EC%8A%A4%ED%8C%8C%ED%81%AC%EC%8A%A4";
			
			driver.get(url);
			
			// 최신순 버튼 클릭하도록
			WebElement button = driver.findElement(By.cssSelector("#snb > div.mod_group_option_filter._search_option_simple_wrap > div > div.option_area.type_sort > a:nth-child(2)"));
			button.click();

			List<WebElement> Elements = driver.findElements(By.cssSelector("#main_pack > section > div.api_subject_bx > div.group_news > ul > li"));
			
			// 뉴스에서 뽑고 싶은 요소들을 설정
			for (WebElement Element : Elements) {
	            String company_img = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press > span > img")).getAttribute("src");
	            String company_name = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > a.info.press")).getText();
	            String date = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_info > div.info_group > span")).getText();
	            String title = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.news_tit")).getText();
	            String content = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > div")).getText();
	            String title_img = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.dsc_thumb > img")).getAttribute("src");
	            String news_url = Element.findElement(By.cssSelector(".bx > .news_wrap.api_ani_send > div > div.news_contents > a.news_tit")).getAttribute("href");
	            News news = new News(company_img, company_name, date, title, content, title_img, news_url);
	            newsList.add(news); 
	        }

		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// 웹 드라이버 종료
			driver.quit();
		}
		return newsList;
	}
		
}
