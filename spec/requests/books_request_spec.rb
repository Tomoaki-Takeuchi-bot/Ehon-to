require 'rails_helper'

RSpec.describe 'Books', type: :request do
  before do
    timestamp!
    log_in
  end

  describe 'GET /books' do
    before do
      (1..2).each { |index| create(:book, name: "Name#{index}#{timestamp}") }
    end

    context 'when not loged in' do
      it 'redirect to sign in' do
        log_out
        get books_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when loged in' do
      it 'render to index page' do
        get books_path
        expect(response.status).to eq(200)
        expect(response.body).to include("Name1#{timestamp}")
        expect(response.body).to include("Name2#{timestamp}")
      end
    end

    context 'when include ids params' do
      it 'render to index page specified ids' do
        book = Book.find_by(name: "Name2#{timestamp}")
        get books_path(ids: book.id)
        expect(response.status).to eq(200)
        expect(response.body).not_to include("Name1#{timestamp}")
        expect(response.body).to include("Name2#{timestamp}")
      end
    end

    context 'when include tag_list' do
      before do
        create(:book, name: "Name with tag#{timestamp}", tag_list: 'travel')
      end
      it 'render to index page specified tags' do
        get books_path(tag_list: %w[travel])
        expect(response.status).to eq(200)
        expect(response.body).not_to include("Name1#{timestamp}")
        expect(response.body).not_to include("Name2#{timestamp}")
        expect(response.body).to include("Name with tag#{timestamp}")
      end
    end

    context 'when include name' do
      before { create(:book, name: "Name3#{timestamp}") }
      it 'render to index page specified tags' do
        get books_path(q: { name_cont: "Name3#{timestamp}" })
        expect(response.status).to eq(200)
        expect(response.body).not_to include("Name1#{timestamp}")
        expect(response.body).not_to include("Name2#{timestamp}")
        expect(response.body).to include("Name3#{timestamp}")
      end
    end
  end

  describe 'GET /books/:id' do
    context 'other users book page' do
      it 'render to show page' do
        book = create(:book, name: "Show Page#{timestamp}")
        get book_path(book)
        expect(response.status).to eq(200)
        expect(response.body).to include("Show Page#{timestamp}")
      end
    end

    context 'own book page' do
      it 'render to show page' do
        book = create(:book, user: current_user, name: "Show Page#{timestamp}")
        get book_path(book)
        expect(response.status).to eq(200)
        expect(response.body).to include("Show Page#{timestamp}")
      end
    end
  end

  describe 'GET /books/new' do
    it 'render to new page' do
      get new_book_path
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /books/:id/edit' do
    context 'other users book page' do
      it 'redirect to index page' do
        book = create(:book, name: "Edit Page#{timestamp}")
        get edit_book_path(book)
        expect(response).to redirect_to(books_path)
      end
    end

    context 'own book page' do
      it 'render to edit page' do
        book = create(:book, user: current_user, name: "Edit Page#{timestamp}")
        get edit_book_path(book)
        expect(response.status).to eq(200)
        expect(response.body).to include("Edit Page#{timestamp}")
      end
    end
  end

  describe 'POST /books' do
    context 'valid params' do
      it 'redirect to show page' do
        expect do
          post books_path,
               params: {
                 book:
                   attributes_for(
                     :book,
                     name: "Create book#{timestamp}",
                     tag_list: %w[ゆかいな話 ふしぎな話],
                     image:
                       Rack::Test::UploadedFile.new(
                         File.join(
                           Rails.root,
                           '/spec/factories/images/test.png'
                         )
                       )
                   )
               }
        end.to change { Book.count }.by(1)
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(response.body).to include('本の登録が完了しました。')
        expect(response.body).to include("Create book#{timestamp}")
        expect(response.body).to include('ゆかいな話', 'ふしぎな話')
      end
    end

    context 'invalid params' do
      it 'render to new page' do
        expect do
          post books_path, params: { book: attributes_for(:book, name: '') }
        end.to change { Book.count }.by(0)
        expect(response.status).to eq(200)
        expect(response.body).to include(
          CGI.escapeHTML('本の名前を入力してください')
        )
      end
    end

    context 'request format is json' do
      context 'valid params' do
        it 'return updated attributes' do
          expect do
            post books_path(format: :json),
                 params: {
                   book:
                     attributes_for(
                       :book,
                       name: "Create book#{timestamp}",
                       tag_list: %w[ゆかいな話 ふしぎな話],
                       image:
                         Rack::Test::UploadedFile.new(
                           File.join(
                             Rails.root,
                             '/spec/factories/images/test.png'
                           )
                         )
                     )
                 }
          end.to change { Book.count }.by(1)
          expect(response.status).to eq(201)
          expect(json_response['name']).to eq("Create book#{timestamp}")
          expect(json_response['user_id']).to eq(current_user.id)
          expect(json_response['tag_list']).to include(
            'ゆかいな話',
            'ふしぎな話'
          )
        end
      end

      context 'invalid params' do
        it 'return error messages' do
          expect do
            post books_path(format: :json),
                 params: { book: attributes_for(:book, name: '') }
          end.to change { Book.count }.by(0)
          expect(response.status).to eq(422)
          expect(json_response['name']).to include('を入力してください')
        end
      end
    end
  end

  describe 'PUT /books/:id' do
    let(:book) { create(:book, user: current_user, tag_list: %w[ゆかいな話]) }
    context 'valid params' do
      it 'redirect to show page' do
        put book_path(book),
            params: {
              book: { name: "Updated #{timestamp}", tag_list: %w[ふしぎな話] }
            }
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(response.body).to include('本の更新が完了しました。')
        expect(response.body).to include("Updated #{timestamp}")
        expect(response.body).to include('ふしぎな話')
      end
    end

    context 'invalid params' do
      it 'render to edit page' do
        put book_path(book), params: { book: { name: '' } }
        expect(response.status).to eq(200)
        expect(response.body).to include(
          CGI.escapeHTML('本の名前を入力してください')
        )
      end
    end

    context 'try to update other users book' do
      it 'redirect to index page' do
        other_book = create(:book)
        put book_path(other_book), params: { book: { name: 'Name' } }
        expect(response).to redirect_to(books_path)
      end
    end

    context 'request format is json' do
      context 'valid params' do
        it 'return updated attributes' do
          put book_path(book, format: :json),
              params: {
                book: { name: "Updated #{timestamp}", tag_list: %w[ふしぎな話] }
              }
          expect(response.status).to eq(200)
          expect(json_response['name']).to eq("Updated #{timestamp}")
          expect(json_response['user_id']).to eq(current_user.id)
          expect(json_response['tag_list']).to include('ふしぎな話')
        end
      end

      context 'invalid params' do
        it 'return error messages' do
          put book_path(book, format: :json), params: { book: { name: '' } }
          expect(response.status).to eq(422)
          expect(json_response['name']).to include('を入力してください')
        end
      end
    end
  end

  describe 'DELETE /books/:id' do
    let(:book) { create(:book, user: current_user) }
    context 'delete own book' do
      it 'redirect to index page' do
        delete book_path(book)
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(response.body).to include('本の削除が完了しました。')
      end
    end

    context 'format is json' do
      it 'status 204' do
        delete book_path(book, format: :json)
        expect(response.status).to eq(204)
      end
    end

    context 'try to delete other users book' do
      it 'redirect to index page without notice' do
        other_book = create(:book)
        delete book_path(other_book)
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(response.body).not_to include('Book was successfully destroyed')
      end
    end
  end
end
