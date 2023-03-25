require './classes/book'
require './classes/label'
require './classes/item'
require './classes/game'
require './classes/author'
require './classes/music_album'
require './classes/genre'
require './modules/game_module'
require './modules/author_module'
require './modules/common'
require './modules/storage'
require './modules/music_album_module'
require './modules/genre_module'
require './modules/book_module'
require './modules/label_module'
require 'json'

class App
  include GameModule
  include AuthorModule
  include CommonModule
  include StorageModule
  include MusicAlbumModule
  include GenreModule
  include BookModule
  include LabelModule

  attr_reader :books, :labels, :games, :authors, :music_albums, :genres

  def initialize
    prepare_storage
    @games = load_games
    @authors = load_authors
    @music_albums = load_music_albums
    @genres = load_genres
    @books = load_books
    @labels = load_labels
  end

  def prepare_storage
    create_file('games')
    create_file('authors')
    create_file('music_albums')
    create_file('genres')
    create_file('labels')
    create_file('books')
  end

  def save_data
    save_to_file(@games.map(&:to_hash), 'games')
    save_to_file(@authors.map(&:to_hash), 'authors')
    save_to_file(@music_albums.map(&:to_hash), 'music_albums')
    save_to_file(@genres.map(&:to_hash), 'genres')
    save_to_file(@books.map(&:to_hash), 'books')
    save_to_file(@labels.map(&:to_hash), 'labels')
  end
end
