class APODScraper

    attr_accessor :archive, :doc, :links

    def initialize
        @archive = Archive.new
        @doc = Nokogiri::HTML(URI("https://apod.nasa.gov/apod/archivepix.html").open())
        get_posts_array
        create_posts
        scrape_post_details
        
    end

    def get_posts_array
        @links = @doc.css('body').css('b').css('a')[1..10]
    end

    def scrape_post_details
        @doc2 = Nokogiri::HTML(URI("https://apod.nasa.gov/apod/#{@post.href}").open())
        @post.date = @doc2.css('body').css('center').css('p')[1].text.strip
        # remove newlines, remove text up until 'Explanation:', remove leading or trailing whitespace, standardize spacing between words left, limit slug to 200 char 
        @post.slug = @doc2.css('body').css('p').text.gsub(/\n/, ' ').gsub(/\A.*Explanation./, '').strip.gsub(/ {2,}/, ' ').slice(0, 300)
    end

    def create_posts
        @links.each do |link|
            @post = Post.new
            @post.title = link.text
            @post.href  = link['href']
            scrape_post_details
            @archive.add_post(@post)
        end
    end

end