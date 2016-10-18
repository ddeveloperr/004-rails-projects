class Scrape
	attr_accessor :title, :hotness, :image_url, :rating, :director,
	:genre, :runtime, :synopsis, :failure

	def scrape_new_movie
		begin
			doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/m/the_martian/"))
			doc.css('script').remove 
			self.title = doc.at("//h1").text.strip  
			self.hotness = doc.at_css('span.meter-value').text[0, doc.at_css('span.meter-value').text.index('%')] 
			self.image_url = doc.at_css('#movie-image-section img')['src'] 
			self.rating = doc.at_css("div.info > div:nth-child(2)").text
			self.director = doc.at_css("div.info > div:nth-child(6)").text.strip 
			self.genre = doc.at_css("div.info > div:nth-child(4)").text.strip
			self.runtime = doc.at_css("div.info > div:nth-child(12)").text.strip
			self.synopsis = doc.css('#movieSynopsis').text.strip
			return true
		rescue Exception => e
			self.failure = "Something went wrong with the scrape"
		end
	end
end