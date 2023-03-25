module BookModule
  def show_list_all_books
    if @books.empty?
      puts "\n\e[31mNo books available!\e[0m\n"
    else
      puts "\nList of Books \n\n"
      list_all_books
    end
  end

  def list_all_books
    puts "\n| Index \t| Publisher \t| Cover State \t| Publish Date"
    puts '--------------------------------------------'
    @books.each_with_index do |book, index|
      puts " |#{index} \t\t|#{book.publisher} \t\t| #{book.cover_state} \t\t| #{book.publish_date}"
      puts '--------------------------------------------'
    end
  end

  def add_book
    puts "\nAdd a new book"
    print 'Publisher:'
    publisher = gets.chomp
    print 'Cover State:'
    cover_state = gets.chomp
    print 'Publish Date[YYYY/MM/DD]:'
    publish_date = gets.chomp
    book = Book.new(publisher, cover_state, publish_date)
    label = book_label
    label.add_item(book)
    @books << book
    puts 'Your book has been added successfully!'
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

  def load_books
    load_from_file('books').map { |book|  Book.new(book['publisher'], book['cover_state'], book['publish_date']) }
  end
end
