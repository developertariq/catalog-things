module LabelModule
  def show_list_all_labels
    if @labels.empty?
      puts "\n\e[31mNo labels available!\e[0m\n"
      puts
    else
      puts "\nList of Labels:\n\n"
      list_all_labels
    end
  end

  def list_all_labels
    puts "\n| Index \t| Labels \t| Color"
    puts "\n--------------------------------------------"
    @labels.each_with_index do |label, index|
      puts "| #{index} \t\t| #{label.title} \t| #{label.color}"
      puts "\n--------------------------------------------"
    end
  end

  def add_label
    puts "\nAdd author details:"
    print 'Title: '
    title = empty?(gets.chomp.to_s)
    print 'Color: '
    color = empty?(gets.chomp.to_s)
    label = Label.new(title, color)
    @labels << label
    puts "\e[32mLabel added successfully!\e[0m"
  end

  def find_label(id)
    labels = @labels.select { |label| label.id == id }
    labels.first
  end

  def load_labels
    labels = []
    data = load_from_file('labels')

    data.map do |items|
      label = Label.new(items['title'], items['color'])
      items['items'].map do |item|
        if item['type'].include?('Book')
          book = Book.new(item['publisher'], item['cover_state'], item['publish_date'])
          label.add_item(book)
        end
      end
      labels << label
    end
    labels
  end
end
