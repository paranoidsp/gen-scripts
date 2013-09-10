package fanficproject;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class fanficDl{
	/*
	 *  Class to dl all the HP fanfics from fanfiction.net
	 */
	
	public static void main(String[] str){
		
		Document doc; 
		String siteName = "www.flagfic.com";
		
		for(int i = 0 ; i <15 ; i++){

			try{
				
				doc = Jsoup.connect("http://www.fanfiction.net/community/DLP-5-Starred-and-Featured-Authors/84507/99/4/" + i + "/0/0/0/0/").get();
				
				String title = doc.title();
				
				Elements links = doc.select(".stitle");
				for(Element link : links ){
					
					// Print all links with name and target from href attr
					System.out.println("http://fanfiction.net" + link.attr("href"));
				/*
					Document flagDoc = Jsoup.connect(siteName + "/flag")
							.data("source",link.attr("href").substring(3,10))
							.data("format","mobi")
							.post();
					*/
				}
			}
			catch (IOException exp){
				exp.printStackTrace();
	
		}
		
	}
}
