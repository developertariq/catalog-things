module LabelModule
  def list_all_labels
    puts "\nNo labels added yet" if @labels.empty?
    puts "\nAll Labels:\n\n"
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

  def book_label
    print "\nDo you want to add label (1) or show list (2)? [Input the number]: "
    type = gets.chomp.to_i
    case type
    when 1
      add_label
      label_id = @labels.length - 1
    when 2
      if @labels.empty?
        puts "\n\e[31mNo labels available, please add a label!\e[0m\n"
        add_label
        label_id = @labels.length - 1
      else
        puts "\nSelect an author from the following list by index (not id) \n"
        list_all_labels
        label_id = idx_validate(@labels, gets.chomp.to_i)
      end
    end
    @labels[label_id]
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