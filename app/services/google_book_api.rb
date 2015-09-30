require 'googlebooks'

module GoogleBookApi
  def GoogleBookApi.getBookByISBN(isbn)
    book_result = GoogleBooks.search("isbn:#{isbn}").first
    if book_result
      return {'title' => book_result.title,
              'author' => book_result.authors,
              'genres' => book_result.categories,
              'small_cover_url' => book_result.image_link}
    end
  end
end