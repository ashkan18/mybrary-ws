module IsbnDbApi
  def IsbnDbApi.getBookByISBN(isbn)
    isbn_db_response = RestClient.get "#{Rails.configuration.x.isbn_db_host}/#{Rails.configuration.x.isbn_db_api_key}/book/#{isbn}"
    if isbn_db_response.code == 200
      book_result = JSON.parse(isbn_db_response)
      return {'title' =>  book_result['data'][0]['title'],
              'author' => book_result['data'][0]['author_data'][0]['name'],
              'genres' => [],
              'small_cover_url' =>  "http://covers.openlibrary.org/b/isbn/#{isbn}-S.jpg",
              'medium_cover_url' => "http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg",
              'large_cover_url' => "http://covers.openlibrary.org/b/isbn/#{isbn}-L.jpg"}
    end
  end
end