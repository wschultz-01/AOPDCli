class Archive
    attr_accessor :posts

    def initialize
        @posts = []
    end 

    # prevent callers from modifying @posts
    def posts  
        @posts.dup.freeze
    end 

    def add_post(post)
        
        # ensures post is type Post before added
        if !post.is_a?(Post)  
            raise InvalidType, "Must be a Post"
        else
            @posts << post
        end
    
    end

end