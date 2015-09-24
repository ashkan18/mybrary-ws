class BookRequestMailer < ApplicationMailer
  default from: 'hello@mybrary.com'

  def book_inquery_email(book_request)
    @book_request = book_request

    mail(to: book_request.book_instance.user.email,
         subject: "New Book request for #{book_request.book_instance.book.name}")
  end

  def request_accept_email(book_request)
    @book_request = book_request
    mail(to: [book_request.user.email, book_request.book_instance.user.email],
         subject: "Book Request Accepted, time to coordinate")
  end
end
