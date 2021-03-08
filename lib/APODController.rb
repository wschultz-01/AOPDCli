class APODController

    def call
        puts 'Loading APOD...'
        puts ''
        get_data
        header
        until @input == 'exit'
            menu_header
            list_posts
            get_input
            input_parse
        end
        puts 'Live long and prosper'
    end

    def input_parse
        if 1 <= @input.to_i && @input.to_i <=10
            selected_post
        elsif @input == 'exit'
        else
            puts "Not a valid input I'm afraid"
            puts ''
        end
    end

    def selected_post
        @post = @archive.posts[@input.to_i - 1]
        puts @post.title
        puts @post.date
        puts ''
        puts @post.slug + '...'
        puts ''

        second_layer_menu
        second_layer_parse
    end

    def second_layer_menu
        @input2 = ''

        until @input2 == 'more' || @input2 == 'list' 
            puts "Would you like to know more or return to the list (more/list)?"
            @input2 = gets.strip.downcase
            puts ''
            second_layer_parse
        end
        
    end

    def second_layer_parse
        if @input2 == 'more'
            Launchy.open("https://apod.nasa.gov/apod/#{@post.href}")
        elsif @input2 == 'list'
        else
            puts "Invalid input"
        end

    end

    def get_data
        @archive = APODScraper.new.archive
    end

    def menu_header
        puts 'Type the number of the post you would like to know more about,'
        puts 'or "exit" to exit'
        puts ''
    end

    def list_posts
        @archive.posts.each do |p|
            puts "#{@archive.posts.find_index(p) + 1}. #{p.title}"  # functional but ugly, can we refactor the number?
        end
    end

    def get_input
        puts "What would you like to do?"
        @input = gets.strip.downcase
        puts ''

    end

    def header
        puts "      _   ___  ___  ___ "
        puts "     /_\\ | _ \\/ _ \\|   \\ "
        puts "    / _ \\|  _/ (_) | |) | "
        puts "   /_/ \\_\\_|  \\___\/|___\/ "
        puts "Astronomy Picture of the Day"
        puts "============================="
        puts ""
    end
end