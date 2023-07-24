class Comment
    attr_accessor :gossip_id, :author, :content
    
    def initialize(gossip_id, author, content)
        @gossip_id = gossip_id
        @author = author
        @content = content
    end
    
    def self.get_all_related_comments(id)
        all_related_comments = []
        CSV.read("./db/comment.csv").each do |csv_line|
            if id == csv_line[0]
                all_related_comments << Comment.new(csv_line[0], csv_line[1], csv_line[2])
            end
        end
        return all_related_comments
    end
    
    def save
        CSV.open("./db/comment.csv", "ab") do |comment|
            comment << [@gossip_id, @author, @content]
        end
    end
end