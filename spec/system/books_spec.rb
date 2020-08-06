require "rails_helper"

RSpec.describe "books", type: :system do
  let(:user) { create(:user) }
  let(:login_user) { user }
  let!(:book) { create(:book, user: user) }

  before {
    log_in(login_user, type: :system)
    visit book_path(book)
  }

  describe 'favorite' do
    context "when own book" do
      it 'successfully like and dislike' do
        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "fas"
        }
        expect(first("#favorites").text).to eq("1")

        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "far"
        }
        expect(first("#favorites").text).to eq("0")
      end
    end

    context "when other users book" do
      let(:login_user) { create(:user) }
      it 'successfully like and dislike' do
        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "fas"
        }
        expect(first("#favorites").text).to eq("1")

        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "far"
        }
        expect(first("#favorites").text).to eq("0")
      end
    end
  end
end
