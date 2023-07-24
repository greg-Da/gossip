class Gossip
    attr_accessor :author, :content
    
    def initialize(author, content)
        @author = author
        @content = content
    end
    
    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end
    
    def self.find(id)
        CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
            if index == id.to_i
                return Gossip.new(csv_line[0], csv_line[1])
            end
        end
    end

    def update(author, content)
        csv_array = []
        CSV.foreach("./db/gossip.csv") do |csv|
                csv_array << csv
        end

        csv_array[csv_array.index([@author, @content])] = [author, content]
        CSV.open("./db/gossip.csv", "w") do |csv|
            csv_array.each do |row|
                csv << row
            end
        end
    end
    
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end
    
    
end
